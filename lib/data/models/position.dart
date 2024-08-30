import 'dart:convert';

class Position {
  DateTime? date;
  int? driverNumber;
  int? meetingKey;
  int? position;
  int? sessionKey;

  Position({
    this.date,
    this.driverNumber,
    this.meetingKey,
    this.position,
    this.sessionKey,
  });

  factory Position.fromRawJson(String str) =>
      Position.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        driverNumber: json["driver_number"],
        meetingKey: json["meeting_key"],
        position: json["position"],
        sessionKey: json["session_key"],
      );

  Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "driver_number": driverNumber,
        "meeting_key": meetingKey,
        "position": position,
        "session_key": sessionKey,
      };

  @override
  String toString() {
    return 'Position(date: $date, driverNumber: $driverNumber, meetingKey: $meetingKey, position: $position, sessionKey: $sessionKey)';
  }
}
