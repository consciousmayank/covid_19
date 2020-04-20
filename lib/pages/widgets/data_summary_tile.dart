import 'package:covid19graphs/models/history.dart';
import 'package:covid19graphs/widget/themes.dart';
import 'package:flutter/material.dart';

class DataSummaryTile extends StatelessWidget {
  final Summary summary;

  DataSummaryTile(this.summary);

  @override
  Widget build(BuildContext context) {
    return getListView();
  }

  Widget getListView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        infectedUi(summary.confirmedCasesIndian),
        recoveredUi(summary.discharged),
        deathsUi(summary.deaths)
      ],
    );
  }

  Widget infectedUi(int confirmedCasesIndian) {
    return Card(
      shape: getCustomBeveledRectangleBorder(15.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Text("Infected", style: getTitleTextStyle(Colors.orange),),
            SizedBox(
              height: 18.0,
            ),
            Text("$confirmedCasesIndian",
                style: getMiddleTextStyle(Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget recoveredUi(int confirmedCasesIndian) {
    return Card(
      shape: getCustomBeveledRectangleBorder(15.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Text("Recovered", style: getTitleTextStyle(Colors.green)),
            SizedBox(
              height: 18.0,
            ),
            Text("$confirmedCasesIndian",
                style: getMiddleTextStyle(Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget deathsUi(int confirmedCasesIndian) {
    return Card(
      shape: getCustomBeveledRectangleBorder(15.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Text("Deaths", style: getTitleTextStyle(Colors.red)),
            SizedBox(
              height: 18.0,
            ),
            Text("$confirmedCasesIndian",
                style: getMiddleTextStyle(Colors.black87)),
          ],
        ),
      ),
    );
  }


}
