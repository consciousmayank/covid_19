import 'package:covid19graphs/widget/header.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: header(
          context: context,
          title: "Covid History in India",
          textStyle: null,
          showBackArrow: false,
          actions: null,
        ),
        body: bodyWidget());
  }

  Widget bodyWidget() {
    return Center(
      child: Text("Notifications & advisories"),
    );
  }
}
