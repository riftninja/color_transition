# color_transition

[![pub package](https://img.shields.io/pub/v/color_transition.svg)](https://pub.dartlang.org/packages/color_transition)

A dart package for continuous color transition.

## Usage

A simple usage example:

    import 'package:color_transition/color_transition.dart';

    colorTransition = new ColorTransition(callback: (currentColor){
        print(currentColor);
    }).init();

###properties
currentColor: RGB color in `List<int>`, defaults to `List<int> [255, 255, 255]` (optional)

callback: Function called after every transition (optional)

duration: defaults to `int 3` (optional)

fps: defaults to `int 30` (optional)

###methods
init: starts color transition

cancel: ends/cancels color transition

generateRGB: Returns `List<int>` representing a random RGB value

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/riftninja/color_transition/issues