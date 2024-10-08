import 'dart:convert';

import 'package:openViewF1/data/models/meeting.dart';
import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

class MeetingRepo implements IRepository<Meeting> {
  @override
  Future<List<Meeting>> getAll() async {
    List<Meeting> list = [];

    dynamic defaultQueryParams = {'year': DateTime.now().year.toString()};

    await ApiClient.instance
        .get('/meetings', queryParams: defaultQueryParams)
        .then((json) {
      json != null
          ? list = (jsonDecode(json) as List)
              .map((e) => Meeting.fromJson(e))
              .toList()
          : list;
    });

    return list;
  }

  @override
  Future<List<Meeting>> getWithFilter({queryParams}) async {
    List<Meeting> list = [];

    dynamic defaultQueryParams = {
      'year': DateTime.now().year.toString(),
    };

    await ApiClient.instance
        .get('/sessions', queryParams: queryParams ?? defaultQueryParams)
        .then((json) {
      json != null
          ? list = (jsonDecode(json) as List)
              .map((e) => Meeting.fromJson(e))
              .toList()
          : list;
    });

    return list;
  }
}
