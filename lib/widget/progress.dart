import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:flutter/material.dart';

Container circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.purple),
    ),
  );
}

Container circularProgressWithTextBelow(String text) {
  return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: Center(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          Text(
            text,
            style: textFieldStyle(fontSize: 18.0, textColor: Colors.black),
          ),
        ],
      ),
    ),
  );
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.orange),
    ),
  );
}
