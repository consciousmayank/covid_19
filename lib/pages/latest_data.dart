import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/pages/widgets/data_summary_tile.dart';
import 'package:covid19graphs/pages/widgets/state_wise_chart.dart';
import 'package:covid19graphs/repository/homescreen_repo.dart';
import 'package:covid19graphs/widget/header.dart';
import 'package:covid19graphs/widget/progress.dart';
import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class LatestData extends StatefulWidget {
  LatestData();

  @override
  _LatestDataState createState() => _LatestDataState();
}

class _LatestDataState extends State<LatestData> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = true;
  History _latestStats;
  HomeScreenRepo _repo;
  bool isLocationPermissionGranted = false;

  @override
  void initState() {
    _repo = HomeScreenRepo();
    getLatestStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Orientation ${MediaQuery
        .of(context)
        .orientation}");
    return Scaffold(
        key: _scaffoldKey,
        appBar: header(
          context: context,
          title: "GoCoronaGo",
          textStyle: null,
          showBackArrow: false,
          actions: null,
        ),
        body: isLoading
            ? circularProgressWithTextBelow("Loading. Please Wait...")
            : MediaQuery
            .of(context)
            .orientation == Orientation.portrait ?
        portraitUi() : landScapeUi());
  }

  bodyWidget() {
    return portraitUi();
  }

  String getCurrentDate(DateTime date) {
    return formatDate(date,
        [d, '' '-', MM, '' '-', yyyy, ' at ', hh, ':', nn, ':', ss, ':', am]);
  }

  void getLatestStats() {
    _repo.getHistory().then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
          _latestStats = value;
        });
      }
    });
  }

  Widget portraitUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        getTitleUi(),
        getSummaryUi(),
        getChartUi(),
        footerLine(),
      ],
    );
  }

  Widget landScapeUi() {
    return Row(
      children: <Widget>[
        getLeftColumn(),
        getChartUi(),
      ],
    );
  }

  Widget getTitleUi() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        "Total Corona Cases in India.",
        style: textFieldStyle(textColor: Colors.black, fontSize: 22.0),),
    );
  }

  Widget getSummaryUi() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child:
      DataSummaryTile(
          _latestStats.data[_latestStats.data.length - 1].summary),
    );
  }

  Widget getChartUi() {
    return StateWiseChart(
        _latestStats.data[_latestStats.data.length - 1].regional,
        _latestStats.data[_latestStats.data.length - 2].regional);
  }

  Widget footerLine() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        "Last Updated on ${getCurrentDate(_latestStats.lastRefreshed)}",
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getLeftColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        getTitleUi(),
        getSummaryUi(),
        footerLine(),
      ],
    );
  }
}
