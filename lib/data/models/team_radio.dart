import 'dart:convert';

class TeamRadio {
  DateTime? date;
  int? driverNumber;
  int? meetingKey;
  String? recordingUrl;
  int? sessionKey;

  TeamRadio({
    this.date,
    this.driverNumber,
    this.meetingKey,
    this.recordingUrl,
    this.sessionKey,
  });

  factory TeamRadio.fromRawJson(String str) => TeamRadio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TeamRadio.fromJson(Map<String, dynamic> json) => TeamRadio(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        driverNumber: json["driver_number"],
        meetingKey: json["meeting_key"],
        recordingUrl: json["recording_url"],
        sessionKey: json["session_key"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "driver_number": driverNumber,
        "meeting_key": meetingKey,
        "recording_url": recordingUrl,
        "session_key": sessionKey,
      };
}
