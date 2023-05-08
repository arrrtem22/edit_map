import 'package:flutter/material.dart';
import 'package:edit_map/src/src/interfaces/graphic/desk/desk_interface.dart';

const int part = 8;

const double borderWidth = 2;

const double alphaNone = 0.0;
const double alphaHalf = 0.3;
const double alphaActive = 0.6;

const Color blackColor = Colors.black;
const Color whiteColor = Colors.white;

const Color defaultBorderColor = Color(0xffE3E3E3);
const Color activeBorderColor = Color(0xff87EBA3);

const Color defaultFillColor = Color(0xff29708D);
const Color bookedFillColor = Color(0xffE3E3E3);

const DeskState defaultDeskState = DeskState(
  fillColor: defaultFillColor,
  // nameStrokeColor: whiteColor,
  borderColor: defaultBorderColor,
  // nameStrokeWidth: 1,
  // availabilityColor: whiteColor,
  nameColor: whiteColor,
  // availabilityThickness: 2,
);
const DeskState bookedDeskState = DeskState(
  fillColor: bookedFillColor,
  // nameStrokeColor: whiteColor,
  borderColor: bookedFillColor,
  // nameStrokeWidth: 1,
  // availabilityColor: whiteColor,
  nameColor: whiteColor,
  // availabilityThickness: 2,
);

const DeskState activeDeskState = DeskState(
  fillColor: activeBorderColor, // it's an active color only for mobile TODO(Artemii): clarify this color with Eugene
  // nameStrokeColor: whiteColor,
  borderColor: activeBorderColor,
  // nameStrokeWidth: 1,
  // availabilityColor: whiteColor,
  nameColor: whiteColor,
  // availabilityThickness: 2,
);
