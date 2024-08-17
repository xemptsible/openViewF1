import 'dart:convert';

import 'package:openViewF1/data/models/meeting.dart';
import 'package:openViewF1/data/repositories/.repository.dart';
import 'package:openViewF1/helpers/services/api_client.dart';

// abstract class MeetingRepo {
//   Future<List<Meeting>> getMeetings({dynamic queryParams});
// }

class MeetingRepo extends Repository {
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
  Future<List> getWithFilter(queryParams) {
    // TODO: implement getWithFilter
    throw UnimplementedError();
  }
}
