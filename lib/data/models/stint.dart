import 'dart:convert';

class Stint {
  String? compound;
  int? driverNumber;
  int? lapEnd;
  int? lapStart;
  int? meetingKey;
  int? sessionKey;
  int? stintNumber;
  int? tyreAgeAtStart;

  Stint({
    this.compound,
    this.driverNumber,
    this.lapEnd,
    this.lapStart,
    this.meetingKey,
    this.sessionKey,
    this.stintNumber,
    this.tyreAgeAtStart,
  });

  factory Stint.fromRawJson(String str) => Stint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Stint.fromJson(Map<String, dynamic> json) => Stint(
        compound: json["compound"],
        driverNumber: json["driver_number"],
        lapEnd: json["lap_end"],
        lapStart: json["lap_start"],
        meetingKey: json["meeting_key"],
        sessionKey: json["session_key"],
        stintNumber: json["stint_number"],
        tyreAgeAtStart: json["tyre_age_at_start"],
      );

  Map<String, dynamic> toJson() => {
        "compound": compound,
        "driver_number": driverNumber,
        "lap_end": lapEnd,
        "lap_start": lapStart,
        "meeting_key": meetingKey,
        "session_key": sessionKey,
        "stint_number": stintNumber,
        "tyre_age_at_start": tyreAgeAtStart,
      };
}
