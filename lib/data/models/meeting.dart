import 'dart:convert';

class Meeting {
    int? circuitKey;
    String? circuitShortName;
    String? countryCode;
    int? countryKey;
    String? countryName;
    DateTime? dateStart;
    String? gmtOffset;
    String? location;
    int? meetingKey;
    String? meetingName;
    String? meetingOfficialName;
    int? year;

    Meeting({
        this.circuitKey,
        this.circuitShortName,
        this.countryCode,
        this.countryKey,
        this.countryName,
        this.dateStart,
        this.gmtOffset,
        this.location,
        this.meetingKey,
        this.meetingName,
        this.meetingOfficialName,
        this.year,
    });

    factory Meeting.fromRawJson(String str) => Meeting.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        circuitKey: json["circuit_key"],
        circuitShortName: json["circuit_short_name"],
        countryCode: json["country_code"],
        countryKey: json["country_key"],
        countryName: json["country_name"],
        dateStart: json["date_start"] == null ? null : DateTime.parse(json["date_start"]),
        gmtOffset: json["gmt_offset"],
        location: json["location"],
        meetingKey: json["meeting_key"],
        meetingName: json["meeting_name"],
        meetingOfficialName: json["meeting_official_name"],
        year: json["year"],
    );

    Map<String, dynamic> toJson() => {
        "circuit_key": circuitKey,
        "circuit_short_name": circuitShortName,
        "country_code": countryCode,
        "country_key": countryKey,
        "country_name": countryName,
        "date_start": dateStart?.toIso8601String(),
        "gmt_offset": gmtOffset,
        "location": location,
        "meeting_key": meetingKey,
        "meeting_name": meetingName,
        "meeting_official_name": meetingOfficialName,
        "year": year,
    };
}
