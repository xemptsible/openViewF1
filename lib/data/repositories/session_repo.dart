import 'dart:convert';

import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

class SessionRepo implements IRepository {
  @override
  Future<List<Session>> getAll() async {
    List<Session> list = [];

    dynamic defaultQueryParams = {
      'year': DateTime.now().year.toString(),
    };

    await ApiClient.instance
        .get('/sessions', queryParams: defaultQueryParams)
        .then(
      (json) {
        json != null
            ? list = (jsonDecode(json) as List)
                .map((e) => Session.fromJson(e))
                .toList()
            : list;
      },
    );

    return list;
  }

  @override
  Future<List<Session>> getWithFilter({queryParams}) async {
    List<Session> list = [];

    dynamic defaultQueryParams = {
      'year': DateTime.now().year.toString(),
    };

    await ApiClient.instance
        .get('/sessions', queryParams: queryParams ?? defaultQueryParams)
        .then(
      (json) {
        json != null
            ? list = (jsonDecode(json) as List)
                .map((e) => Session.fromJson(e))
                .toList()
            : list;
      },
    );

    return list;
  }
}
