import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

InputDecoration textFieldDecoration({String hintText}) {
  return InputDecoration(
    errorStyle: TextStyle(
      color: Colors.red,
      fontSize: 16.0,
    ),
    hintText: hintText,
    hintStyle: TextStyle(
      color: Colors.black45,
    ),
  );
}

List<TextInputFormatter> phoneInputFormat(){
  return <TextInputFormatter>[
    LengthLimitingTextInputFormatter(10),
    WhitelistingTextInputFormatter.digitsOnly,
  ];
}

List<TextInputFormatter> otpInputFormat(){
  return <TextInputFormatter>[
    LengthLimitingTextInputFormatter(6),
    WhitelistingTextInputFormatter.digitsOnly,
  ];
}

TextStyle textFieldStyle({double fontSize, Color textColor}){
  return TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal
  );
}

TextStyle headerTextFieldStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal
  );
}

TextStyle floatingButtonStyle(){
  return TextStyle(
      color: Colors.yellow,
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal
  );
}

TextStyle submitButtonStyle(Color textColor){
  return TextStyle(
      color: textColor,
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      fontStyle: FontStyle.normal
  );
}
