import 'dart:convert';

class Weather {
  double? airTemperature;
  DateTime? date;
  int? humidity;
  int? meetingKey;
  double? pressure;
  int? rainfall;
  int? sessionKey;
  double? trackTemperature;
  int? windDirection;
  double? windSpeed;

  Weather({
    this.airTemperature,
    this.date,
    this.humidity,
    this.meetingKey,
    this.pressure,
    this.rainfall,
    this.sessionKey,
    this.trackTemperature,
    this.windDirection,
    this.windSpeed,
  });

  factory Weather.fromRawJson(String str) => Weather.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        airTemperature: json["air_temperature"]?.toDouble(),
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        humidity: json["humidity"],
        meetingKey: json["meeting_key"],
        pressure: json["pressure"]?.toDouble(),
        rainfall: json["rainfall"],
        sessionKey: json["session_key"],
        trackTemperature: json["track_temperature"]?.toDouble(),
        windDirection: json["wind_direction"],
        windSpeed: json["wind_speed"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "air_temperature": airTemperature,
        "date": date?.toIso8601String(),
        "humidity": humidity,
        "meeting_key": meetingKey,
        "pressure": pressure,
        "rainfall": rainfall,
        "session_key": sessionKey,
        "track_temperature": trackTemperature,
        "wind_direction": windDirection,
        "wind_speed": windSpeed,
      };
}
