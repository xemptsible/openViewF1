import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/meeting.dart';

import 'package:openViewF1/data/repositories/.repository_interface.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';
import 'package:openViewF1/view_models/.view_model_interface.dart';

class MeetingViewModel extends ChangeNotifier implements IViewModel {
  final IRepository meetingRepo;

  MeetingViewModel({required this.meetingRepo});

  bool isLoading = false;
  List<Meeting> meetings = [];
  String errorMsg = "";

  @override
  Future<void> fetchData() async {
    isLoading = true;
    try {
      meetings = await meetingRepo.getAll() as List<Meeting>;
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  Future<void> fetchDataWithQuery(queryParams) async {
    isLoading = true;
    try {
      meetings.clear();
      meetings = await meetingRepo.getWithFilter(queryParams: queryParams)
          as List<Meeting>;
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
