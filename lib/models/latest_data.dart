// To parse this JSON data, do
//
//     final latestStats = latestStatsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LatestStats latestStatsFromJson(String str) => LatestStats.fromJson(json.decode(str));

String latestStatsToJson(LatestStats data) => json.encode(data.toJson());

class LatestStats {
  final bool success;
  final Data data;
  final DateTime lastRefreshed;
  final DateTime lastOriginUpdate;

  LatestStats({
    @required this.success,
    @required this.data,
    @required this.lastRefreshed,
    @required this.lastOriginUpdate,
  });

  factory LatestStats.fromJson(Map<String, dynamic> json) => LatestStats(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    lastRefreshed: DateTime.parse(json["lastRefreshed"]),
    lastOriginUpdate: DateTime.parse(json["lastOriginUpdate"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "lastRefreshed": lastRefreshed.toIso8601String(),
    "lastOriginUpdate": lastOriginUpdate.toIso8601String(),
  };
}

class Data {
  final Summary summary;
  final List<Regional> regional;

  Data({
    @required this.summary,
    @required this.regional,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    summary: Summary.fromJson(json["summary"]),
    regional: List<Regional>.from(json["regional"].map((x) => Regional.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "summary": summary.toJson(),
    "regional": List<dynamic>.from(regional.map((x) => x.toJson())),
  };
}

class Regional {
  final String loc;
  final int confirmedCasesIndian;
  final int discharged;
  final int deaths;
  final int confirmedCasesForeign;
  final int totalConfirmed;

  Regional({
    @required this.loc,
    @required this.confirmedCasesIndian,
    @required this.discharged,
    @required this.deaths,
    @required this.confirmedCasesForeign,
    @required this.totalConfirmed,
  });

  factory Regional.fromJson(Map<String, dynamic> json) => Regional(
    loc: json["loc"],
    confirmedCasesIndian: json["confirmedCasesIndian"],
    discharged: json["discharged"],
    deaths: json["deaths"],
    confirmedCasesForeign: json["confirmedCasesForeign"],
    totalConfirmed: json["totalConfirmed"],
  );

  Map<String, dynamic> toJson() => {
    "loc": loc,
    "confirmedCasesIndian": confirmedCasesIndian,
    "discharged": discharged,
    "deaths": deaths,
    "confirmedCasesForeign": confirmedCasesForeign,
    "totalConfirmed": totalConfirmed,
  };
}

class   Summary {
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
