import 'dart:convert';

class Pitstop {
  DateTime? date;
  int? driverNumber;
  int? lapNumber;
  int? meetingKey;
  double? pitDuration;
  int? sessionKey;

  Pitstop({
    this.date,
    this.driverNumber,
    this.lapNumber,
    this.meetingKey,
    this.pitDuration,
    this.sessionKey,
  });

  factory Pitstop.fromRawJson(String str) => Pitstop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pitstop.fromJson(Map<String, dynamic> json) => Pitstop(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        driverNumber: json["driver_number"],
        lapNumber: json["lap_number"],
        meetingKey: json["meeting_key"],
        pitDuration: json["pit_duration"]?.toDouble(),
        sessionKey: json["session_key"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "driver_number": driverNumber,
        "lap_number": lapNumber,
        "meeting_key": meetingKey,
        "pit_duration": pitDuration,
        "session_key": sessionKey,
      };
}
