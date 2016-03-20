# MavlinkPrimaryFlightDisplay

[![License MIT](https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square)](https://github.com/kouky/MavlinkPrimaryFlightDisplay/blob/master/LICENSE)


MavlinkPrimaryFlightDisplay is a Mac app which demonstrates how to integrate the [PrimaryFlightDisplay](https://github.com/kouky/PrimaryFlightDisplay) framework for a [MAVLink](http://qgroundcontrol.org/mavlink/start) speaking autopilot.

The demo app is useful as a learning tool in several other ways as it also demonstrates how to:
- connect to [Pixhawk](https://pixhawk.org/modules/pixhawk) over USB, Bluetooth, and 3DR radio telemetry
- decode [MAVLink](http://qgroundcontrol.org/mavlink/start) attitude, heading, airspeed, and altitude messages
- send decoded data to the primary flight display for real time updates
- customize the display style of the primary flight display

![Screenshot](http://kouky.org/assets/primary-flight-display/alternative-screenshot.png)

## Getting Started

After cloning the repository initialize and update git submodules.

    git submodule update --init --recursive

Using Xcode 7.2+ open the workspace `MavlinkPrimaryFlightDisplay.xcworkspace`, select the target `MavlinkPrimaryFlightDisplay` then build and run.

Use the `Mavlink` menu in the running application to choose which serial port to connect to.

## Notes when using application with Pixhawk

The sample project is only tested with an authentic 3DR Pixhawk running PX4 firmware.

Communication with 3DR bluetooth and radio telemetry requires a connection to telemetry port 1.

## Contributing

Pull requests are welcome on the `master` branch.
