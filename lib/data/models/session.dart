import 'dart:convert';

class Session {
  int? circuitKey;
  String? circuitShortName;
  String? countryCode;
  int? countryKey;
  String? countryName;
  DateTime? dateEnd;
  DateTime? dateStart;
  String? gmtOffset;
  String? location;
  int? meetingKey;
  int? sessionKey;
  String? sessionName;
  String? sessionType;
  int? year;

  Session({
    this.circuitKey,
    this.circuitShortName,
    this.countryCode,
    this.countryKey,
    this.countryName,
    this.dateEnd,
    this.dateStart,
    this.gmtOffset,
    this.location,
    this.meetingKey,
    this.sessionKey,
    this.sessionName,
    this.sessionType,
    this.year,
  });

  factory Session.fromRawJson(String str) => Session.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        circuitKey: json["circuit_key"],
        circuitShortName: json["circuit_short_name"],
        countryCode: json["country_code"],
        countryKey: json["country_key"],
        countryName: json["country_name"],
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        dateStart: json["date_start"] == null
            ? null
            : DateTime.parse(json["date_start"]),
        gmtOffset: json["gmt_offset"],
        location: json["location"],
        meetingKey: json["meeting_key"],
        sessionKey: json["session_key"],
        sessionName: json["session_name"],
        sessionType: json["session_type"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "circuit_key": circuitKey,
        "circuit_short_name": circuitShortName,
        "country_code": countryCode,
        "country_key": countryKey,
        "country_name": countryName,
        "date_end": dateEnd?.toIso8601String(),
        "date_start": dateStart?.toIso8601String(),
        "gmt_offset": gmtOffset,
        "location": location,
        "meeting_key": meetingKey,
        "session_key": sessionKey,
        "session_name": sessionName,
        "session_type": sessionType,
        "year": year,
      };

  @override
  String toString() {
    return 'Session(circuitKey: $circuitKey, circuitShortName: $circuitShortName, countryCode: $countryCode, countryKey: $countryKey, countryName: $countryName, dateEnd: $dateEnd, dateStart: $dateStart, gmtOffset: $gmtOffset, location: $location, meetingKey: $meetingKey, sessionKey: $sessionKey, sessionName: $sessionName, sessionType: $sessionType, year: $year)';
  }
}
