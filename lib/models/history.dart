// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  final bool success;
  final List<Datum> data;
  final DateTime lastRefreshed;
  final DateTime lastOriginUpdate;

  History({
    @required this.success,
    @required this.data,
    @required this.lastRefreshed,
    @required this.lastOriginUpdate,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    lastRefreshed: DateTime.parse(json["lastRefreshed"]),
    lastOriginUpdate: DateTime.parse(json["lastOriginUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "lastRefreshed": lastRefreshed.toIso8601String(),
    "lastOriginUpdate": lastOriginUpdate.toIso8601String(),
  };
}

class Datum {
  final DateTime day;
  final Summary summary;
  final List<Regional> regional;

  Datum({
    @required this.day,
    @required this.summary,
    @required this.regional,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    day: DateTime.parse(json["day"]),
    summary: Summary.fromJson(json["summary"]),
    regional: List<Regional>.from(json["regional"].map((x) => Regional.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "day": "${day.year.toString().padLeft(4, '0')}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}",
    "summary": summary.toJson(),
    "regional": List<dynamic>.from(regional.map((x) => x.toJson())),
  };
}

class Regional {
  final String loc;
  final int confirmedCasesIndian;
  final int confirmedCasesForeign;
  final int discharged;
  final int deaths;
  final int totalConfirmed;

  Regional({
    @required this.loc,
    @required this.confirmedCasesIndian,
    @required this.confirmedCasesForeign,
    @required this.discharged,
    @required this.deaths,
    @required this.totalConfirmed,
  });

  factory Regional.fromJson(Map<String, dynamic> json) => Regional(
    loc: json["loc"],
    confirmedCasesIndian: json["confirmedCasesIndian"],
    confirmedCasesForeign: json["confirmedCasesForeign"],
    discharged: json["discharged"],
    deaths: json["deaths"],
    totalConfirmed: json["totalConfirmed"],
  );

  Map<String, dynamic> toJson() => {
    "loc": loc,
    "confirmedCasesIndian": confirmedCasesIndian,
    "confirmedCasesForeign": confirmedCasesForeign,
    "discharged": discharged,
    "deaths": deaths,
    "totalConfirmed": totalConfirmed,
  };
}

class Summary {
  final int total;
  final int confirmedCasesIndian;
  final int confirmedCasesForeign;
  final int discharged;
  final int deaths;
  final int confirmedButLocationUnidentified;

  Summary({
    @required this.total,
    @required this.confirmedCasesIndian,
    @required this.confirmedCasesForeign,
    @required this.discharged,
    @required this.deaths,
    @required this.confirmedButLocationUnidentified,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
    total: json["total"],
    confirmedCasesIndian: json["confirmedCasesIndian"],
    confirmedCasesForeign: json["confirmedCasesForeign"],
    discharged: json["discharged"],
    deaths: json["deaths"],
    confirmedButLocationUnidentified: json["confirmedButLocationUnidentified"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "confirmedCasesIndian": confirmedCasesIndian,
    "confirmedCasesForeign": confirmedCasesForeign,
    "discharged": discharged,
    "deaths": deaths,
    "confirmedButLocationUnidentified": confirmedButLocationUnidentified,
  };
}
