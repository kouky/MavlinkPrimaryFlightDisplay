//
//  StaticPool.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 31/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import Dispatch

enum StaticPoolError: ErrorType {
    case ReleaseOfElementNotOwnedByPool
    case RequestCannotBeFulfilled
}

private let serialQueue = dispatch_queue_create("org.kouky.StaticPoolSerialQueue", DISPATCH_QUEUE_SERIAL)

class StaticPool <ElementType: Equatable> {
    
    private var idleElements: [ElementType]
    private var usedElements = [ElementType]()

    static func build(size size: UInt, builder: () -> ElementType) -> StaticPool {
        guard size > 0 else {
            fatalError("Cannot build StaticPool of size 0")
        }
        
        let elements = (0..<size).map { _ in builder() }
        return self.init(elements: elements)
    }
    
    required init(elements: [ElementType]) {
        self.idleElements = elements
    }

    func requestElement(handler: (ElementType) -> Void) throws {
        var hasError = false
        dispatch_sync(serialQueue) { [weak self] in
    
            guard let `self` = self else { return }
            guard !self.idleElements.isEmpty else {
                hasError = true
                return
            }
        
            let element = self.idleElements.removeFirst()
            self.usedElements.append(element)
            handler(element)
            return
        }
        
        if hasError {
            throw StaticPoolError.RequestCannotBeFulfilled
        }
    }
    
    func releaseElement(element: ElementType, handler: (ElementType) -> Void) throws {
        var hasError = false
        dispatch_async(serialQueue) { [weak self] in

            guard let `self` = self else { return }
            guard let index = self.usedElements.indexOf(element) else {
                hasError = true
                return
            }
            
            self.usedElements.removeAtIndex(index)
            self.idleElements.append(element)
            handler(element)
        }
        
        if hasError {
            throw StaticPoolError.ReleaseOfElementNotOwnedByPool
        }
    }
    
    func forEach(handler: ElementType -> Void) {
        usedElements.forEach { handler($0) }
    }
}
