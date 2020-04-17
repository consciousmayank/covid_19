import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StateWiseChart extends StatefulWidget {
  final List<Regional> currentDayRegionalData;
  final List<Regional> previousDayRegionalData;
  StateWiseChart(this.currentDayRegionalData, this.previousDayRegionalData);

  @override
  _StateWiseChartState createState() => _StateWiseChartState();
}

class _StateWiseChartState extends State<StateWiseChart> {
  int _singleState;

  @override
  void initState() {
    getLastKnownLocation();
    super.initState();
  }

  List<DropdownMenuItem<int>> getDropDownItems() {
    List<DropdownMenuItem<int>> dropDownItems = List<DropdownMenuItem<int>>();

    for (Regional singleRegion in widget.currentDayRegionalData) {
      dropDownItems.add(DropdownMenuItem(
        value: widget.currentDayRegionalData.indexOf(singleRegion),
        child: Text(
          singleRegion.loc,
          style: textFieldStyle(fontSize: 18.0, textColor: Colors.black),
        ),
      ));
    }
    return dropDownItems;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DropdownButton(
                isExpanded: true,
                style: textFieldStyle(fontSize: 20.0, textColor: Colors.black),
                items: getDropDownItems(),
                onChanged: (value) {
                  print(value.toString());
                  setState(() {
                    _singleState = value;
                  });
                },
                value: _singleState,
                hint: Text(
                  "Please Select a state",
                  style:
                      textFieldStyle(fontSize: 20.0, textColor: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            _singleState == null
                ? Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                          "Please Select a State from the Above Drop Down"),
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: charts.BarChart(
                        getSeries(),
                        animate: true,
                        barRendererDecorator:
                            new charts.BarLabelDecorator<String>(),
                        domainAxis: new charts.OrdinalAxisSpec(),
                      ),
                    ),
                  ),
            _singleState == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                        "${widget.currentDayRegionalData[_singleState].confirmedCasesIndian} "
                        "cases have been reported yet"),
                  ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  List<charts.Series<CovidData, String>> getSeries() {
    int currentDayDeaths = widget.currentDayRegionalData[_singleState].deaths;
    int currentDayDischarged =
        widget.currentDayRegionalData[_singleState].discharged;
    int currentDayTotalLeft =
        widget.currentDayRegionalData[_singleState].confirmedCasesIndian -
            (currentDayDeaths + currentDayDischarged);

    int previousDayDeaths = widget.previousDayRegionalData[_singleState].deaths;
    int previousDayDischarged =
        widget.previousDayRegionalData[_singleState].discharged;
    int previousDayTotalLeft =
        widget.previousDayRegionalData[_singleState].confirmedCasesIndian -
            (previousDayDeaths + previousDayDischarged);

    final List<CovidData> data = [
      CovidData("Total\n($currentDayTotalLeft)", currentDayTotalLeft,
          currentDayTotalLeft - previousDayTotalLeft),
      CovidData("Discharged\n($currentDayDischarged)", currentDayDischarged,
          currentDayDischarged - previousDayDischarged),
      CovidData("Deaths\n($currentDayDeaths)", currentDayDeaths,
          currentDayDeaths - previousDayDeaths)
    ];

    return [
      new charts.Series<CovidData, String>(
          id: "sales",
          colorFn: (_, __) => charts.MaterialPalette.indigo.shadeDefault,
          domainFn: (CovidData data, _) => data.type,
          measureFn: (CovidData data, _) => data.number,
          data: data,
          insideLabelStyleAccessorFn: (CovidData data, _) {
            return charts.TextStyleSpec(
                fontSize: 16, color: charts.MaterialPalette.white);
          },
          outsideLabelStyleAccessorFn: (CovidData data, _) {
            return charts.TextStyleSpec(fontSize: 16);
          },
          labelAccessorFn: (CovidData data, _) => data.difference > 0
              ? "+${data.difference}"
              : data.difference < 0 ? "${data.difference}" : "")
    ];
  }

  void getLastKnownLocation() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> p = await Geolocator()
          .placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = p[0];

      for (Regional singleState in widget.currentDayRegionalData) {
        if (singleState.loc.compareTo(place.administrativeArea) == 0) {
          setState(() {
            _singleState = widget.currentDayRegionalData.indexOf(singleState);
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

class CovidData {
  final String type;
  final int number;
  final int difference;

  CovidData(this.type, this.number, this.difference);
}
