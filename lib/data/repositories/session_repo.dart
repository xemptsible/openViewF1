import 'dart:convert';

import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

abstract class SessionRepo {
  Future<List<Session>> getSessions({dynamic queryParams});
}

class SessionRepoImpl extends SessionRepo {
  @override
  Future<List<Session>> getSessions({dynamic queryParams}) async {
    List<Session> list = [];

    dynamic defaultQueryParams = {
      'year': '2024',
      'session_name': 'Race',
    };

    final response = await ApiClient.instance
        .get('/sessions', queryParams: queryParams ?? defaultQueryParams);

    if (response != null) {
      list = (jsonDecode(response) as List)
          .map((e) => Session.fromJson(e))
          .toList();
    }

    return list;
  }
}
