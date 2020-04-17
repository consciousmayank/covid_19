import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:flutter/material.dart';

AppBar header(
    {BuildContext context,
    String title,
    TextStyle textStyle,
    bool showBackArrow = true,
    List<Widget> actions}) {
  return AppBar(
    automaticallyImplyLeading: showBackArrow,
    actions: actions,
    title: Text(
      title,
      style: textStyle != null ? textStyle : headerTextFieldStyle(),
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
