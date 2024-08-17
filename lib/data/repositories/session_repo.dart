import 'dart:convert';

import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/data/repositories/.repository.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

class SessionRepo extends Repository {
  @override
  Future<List<Session>> getAll() async {
    List<Session> list = [];

    dynamic defaultQueryParams = {
      'year': DateTime.now().year.toString(),
      'session_name': 'Race',
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
  Future<List> getWithFilter(queryParams) {
    // TODO: implement getWithFilter in Session
    throw UnimplementedError();
  }
}
