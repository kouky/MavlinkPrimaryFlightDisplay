//
//  Protocols.swift
//  MavlinkPrimaryFlightDisplay
//
//  Created by Michael Koukoullis on 7/01/2016.
//  Copyright © 2016 Michael Koukoullis. All rights reserved.
//

import SpriteKit

protocol SceneType {
    var sceneSize: CGSize { get }
}

protocol DuplexGeneratorType {
    typealias Element
    
    func next() throws -> Element
    func previous() throws -> Element
}
