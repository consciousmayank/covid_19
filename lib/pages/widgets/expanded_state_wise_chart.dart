import 'package:charts_flutter/flutter.dart' as charts;
import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/models/states_expand_collapse.dart';
import 'package:covid19graphs/widget/textfiledstyles.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ExpandedStateWiseChart extends StatefulWidget {
  final List<Regional> currentDayRegionalData;
  final List<Regional> previousDayRegionalData;

  ExpandedStateWiseChart(
      this.currentDayRegionalData, this.previousDayRegionalData);

  @override
  _StateWiseChartState createState() => _StateWiseChartState();
}

class _StateWiseChartState extends State<ExpandedStateWiseChart> {
  int _singleState;
  int _value = 1;
  String initialState = "Please Select a State";
  SelectedStateModel _stateList;

  @override
  void initState() {
    getLastKnownLocation();
    prepareExpandedData().then((value) => _stateList = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          _stateList == null ? Container() : getExpandedStatesList(),
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
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0,
                          bottom: 24.0),
                      child: charts.BarChart(
                        getSeries(),
                        animate: false,
                        barRendererDecorator:
                            new charts.BarLabelDecorator<String>(),
                        domainAxis: new charts.OrdinalAxisSpec(),
                      ),
                    ),
                  ),
                ),
          _singleState == null
              ? Container()
              : Card(
                child: ListTile(
                  title: Text(
                      "${widget.currentDayRegionalData[_singleState].confirmedCasesIndian} "
                          "cases have been reported yet" , textAlign: TextAlign.center,),
                ),
              ),

        ],
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
            _value = _singleState;
            _stateList.header = singleState.loc;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<SelectedStateModel> prepareExpandedData() async {
    List<StatesModel> list = List<StatesModel>();

    for (Regional state in widget.currentDayRegionalData) {
      list.add(StatesModel(singleState: state));
    }

    return SelectedStateModel(
        isExpanded: false, header: initialState, bodyModel: list);
  }

  Widget getExpandedStatesList() {

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ExpansionPanelList(
        animationDuration: Duration(seconds: 1),
        children: [
          ExpansionPanel(
            body: Container(
              height: 50.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.currentDayRegionalData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      label: Text(widget.currentDayRegionalData[index].loc),
                      selected: _value == index,
                      selectedColor: Colors.green,
                      onSelected: (bool value) {
                        setState(() {
                          _value = value ? index : null;
                          _stateList.header =
                              widget.currentDayRegionalData[index].loc;
                          _singleState = index;
                          _stateList.isExpanded = !_stateList.isExpanded;
                        });
                      },
                      backgroundColor: Colors.blue,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  _stateList.header,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              );
            },
            isExpanded: _stateList.isExpanded,
          ),
        ],
        expansionCallback: (int item, bool status) {
          setState(() {
            _stateList.isExpanded = !_stateList.isExpanded;
          });
        },
      ),
    );
  }
}

class CovidData {
  final String type;
  final int number;
  final int difference;

  CovidData(this.type, this.number, this.difference);
}
