import 'package:flutter/material.dart';

TextStyle getTitleTextStyle(Color textColor) {
  return TextStyle(
      fontSize: 22,
      color: textColor
  );
}

TextStyle getMiddleTextStyle(Color textColor) {
  return TextStyle(
      fontSize: 18,
      color: textColor
  );
}

ShapeBorder getCardBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  );
}

ShapeBorder getCustomBeveledRectangleBorder(double radius) {
  return BeveledRectangleBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)
    ),
  );
}

ShapeBorder getStadiumBorder() {
  return StadiumBorder(
    side: BorderSide(
      color: Colors.black,
      width: 1.0,
    ),
  );
}