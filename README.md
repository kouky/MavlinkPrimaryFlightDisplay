# MavlinkPrimaryFlightDisplay

[![Platform](https://img.shields.io/cocoapods/p/PrimaryFlightDisplay.svg?style=flat-square)](http://cocoadocs.org/docsets/PrimaryFlightDisplay)
[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/kouky/MavlinkPrimaryFlightDisplay/blob/master/LICENSE)


MavlinkPrimaryFlightDisplay is a Mac + iOS app which demonstrates how to integrate the [PrimaryFlightDisplay](https://github.com/kouky/PrimaryFlightDisplay) framework for a [MAVLink](http://qgroundcontrol.org/mavlink/start) speaking autopilot.

The demo app is useful as a learning tool in several other ways as it also demonstrates how to:
- connect to [Pixhawk](https://pixhawk.org/modules/pixhawk) over USB, Bluetooth, and 3DR radio telemetry
- decode [MAVLink](http://qgroundcontrol.org/mavlink/start) attitude, heading, airspeed, and altitude messages
- send decoded data to the primary flight display for real time updates
- customize the display style of the primary flight display

![Screenshot](http://kouky.org/assets/primary-flight-display/alternative-screenshot.png)
![Screenshot](http://kouky.org/assets/primary-flight-display/alternative-screenshot-iphone.png)

## Getting Started

Follow these steps after cloning the repository to get the Mac app running.

Initialize and update git submodules.

    git submodule update --init

Build the framework dependencies.

    carthage bootstrap --platform Mac

If you don't have the [Carthage](https://github.com/Carthage/Carthage) dependency manager it can be installed with [Homebrew](http://brew.sh).

    brew install carthage

Using Xcode 7.3+ select either the Mac or iOS target then build and run.

### Mac App

Use the `Mavlink` menu in the running Mac application to choose which serial port to connect to.

### iOS App

Use the scan button to connect to the Readbear BLE mini.

## Notes when using application with Pixhawk

The sample project is only tested with an authentic 3DR Pixhawk running PX4 firmware.

Communication with 3DR bluetooth and radio telemetry requires a connection to telemetry port 1.

## Contributing

Pull requests are welcome on the `master` branch.
