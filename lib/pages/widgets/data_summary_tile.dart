import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:flutter/material.dart';

class DataSummaryTile extends StatelessWidget {
  final Summary summary;

  DataSummaryTile(this.summary);

  @override
  Widget build(BuildContext context) {
    var text = new RichText(
      text: new TextSpan(
        style: textFieldStyle(fontSize: 16.0, textColor: Colors.black),
        children: <TextSpan>[
          new TextSpan(
              text: "Covid-19 in whole of India",
              style: new TextStyle(fontSize: 14)),
          new TextSpan(text: "\n - Total Confirmed Cases : "),
          new TextSpan(
              text: "${summary.total}",
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: "\n - Patients discharged : "),
          new TextSpan(
              text: "${summary.discharged}",
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: "\n - Deaths Reported : "),
          new TextSpan(
              text: "${summary.deaths}",
              style: new TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );

    return Card(
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: text,
      ),
    );
  }
}
