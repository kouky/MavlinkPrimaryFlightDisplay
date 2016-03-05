# MavlinkPrimaryFlightDisplay

[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/kouky/MavlinkPrimaryFlightDisplay/blob/master/LICENSE)

SpriteKit Primary Flight Display for Mavlink demonstrates how to:
- integrate the [PrimaryFlightDisplay](https://github.com/kouky/PrimaryFlightDisplay) framework into a Mac application
- customize the display style of the Primary Flight Display
- connect to Pixhawk over USB, Bluetooth, and 3DR radio telemetry
- decode [MAVLink](http://qgroundcontrol.org/mavlink/start) attitude, heading, airspeed, and altitude messages
- send decoded data to the primary flight display for real time updates

![Screenshot](http://kouky.org/assets/primary-flight-display/alternative-screenshot.png)

## Getting Started

After cloning the repository initialize and update git submodules.

    git submodule update --init

Build and run the demo using Xcode 7.2 or above.

## Notes when using application with Pixhawk

The sample project is only tested with an authentic 3DR Pixhawk running PX4 firmware.

Communication with 3DR bluetooth and radio telemetry requires a connection to telemetry port 1.

Use the `Mavlink` menu in the application to choose which serial port to connect to.

## Contributing

Pull requests are welcome on the `master` branch.
