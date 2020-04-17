import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/models/latest_data.dart';
import 'package:covid19graphs/pages/widgets/data_summary_tile.dart';
import 'package:covid19graphs/pages/widgets/expanded_state_wise_chart.dart';
import 'package:covid19graphs/pages/widgets/state_wise_chart.dart';
import 'package:covid19graphs/repository/homescreen_repo.dart';
import 'package:covid19graphs/widget/header.dart';
import 'package:covid19graphs/widget/progress.dart';
import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class LatestData extends StatefulWidget {
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
            : bodyWidget());
  }

  Widget bodyWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DataSummaryTile(_latestStats.data[_latestStats.data.length-1].summary),
        ExpandedStateWiseChart(_latestStats.data[_latestStats.data.length-1].regional,
        _latestStats.data[_latestStats.data.length-2].regional),
        Card(
          child: ListTile(
            title: Center(
                child: Text('Data Last Updated on',
                    style: textFieldStyle(
                        fontSize: 14.0, textColor: Colors.black87))),
            subtitle: Center(
                child: Text(
              getCurrentDate(_latestStats.lastRefreshed),
              style: textFieldStyle(fontSize: 12.0, textColor: Colors.black),
            )),
          ),
        )
      ],
    );
  }

  String getCurrentDate(DateTime date) {
    return formatDate(date,
        [d, '' '-', MM, '' '-', yyyy, ' at ', hh, ':', nn, ':', ss, ':', am]);
  }

  // void checkLocationPermissions() {
  //   Geolocator().checkGeolocationPermissionStatus().then((value) {
  //     switch (value) {
  //       case GeolocationStatus.denied:
  //       case GeolocationStatus.restricted:
  //       case GeolocationStatus.unknown:
  //         setState(() {
  //           isLocationPermissionGranted = false;
  //         });
  //         break;
  //       case GeolocationStatus.granted:
  //         setState(() {
  //           isLocationPermissionGranted = true;
  //         });
  //         getCurrentLocation();
  //         break;
  //     }
  //   });
  // }

  // void getCurrentLocation() {
  //   Geolocator()
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((value) {
  //     if (value != null) {
  //       getPlaceFromLocation(value);
  //     }
  //   });
  // }

  // void getPlaceFromLocation(Position value) {
  //   Geolocator()
  //       .placemarkFromCoordinates(value.latitude, value.longitude)
  //       .then((value) {
  //     if (value != null) {
  //       setState(() {
  //         _userState = value[0].administrativeArea;
  //       });
  //     }
  //   });
  // }

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
}
