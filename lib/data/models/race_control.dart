import 'dart:convert';

class RaceControl {
  String? category;
  DateTime? date;
  int? driverNumber;
  String? flag;
  int? lapNumber;
  int? meetingKey;
  String? message;
  String? scope;
  dynamic sector;
  int? sessionKey;

  RaceControl({
    this.category,
    this.date,
    this.driverNumber,
    this.flag,
    this.lapNumber,
    this.meetingKey,
    this.message,
    this.scope,
    this.sector,
    this.sessionKey,
  });

  factory RaceControl.fromRawJson(String str) =>
      RaceControl.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RaceControl.fromJson(Map<String, dynamic> json) => RaceControl(
        category: json["category"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        driverNumber: json["driver_number"],
        flag: json["flag"],
        lapNumber: json["lap_number"],
        meetingKey: json["meeting_key"],
        message: json["message"],
        scope: json["scope"],
        sector: json["sector"],
        sessionKey: json["session_key"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "date": date?.toIso8601String(),
        "driver_number": driverNumber,
        "flag": flag,
        "lap_number": lapNumber,
        "meeting_key": meetingKey,
        "message": message,
        "scope": scope,
        "sector": sector,
        "session_key": sessionKey,
      };
}
