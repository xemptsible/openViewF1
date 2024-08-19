import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/meeting.dart';
import 'package:openViewF1/data/repositories/meeting_repo.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';

class MeetingViewModel extends ChangeNotifier {
  final MeetingRepo meetingRepo;

  MeetingViewModel({required this.meetingRepo});

  bool isLoading = false;
  List<Meeting> meetings = [];
  String errorMsg = "";


  Future<void> fetchMeetings() async {
    isLoading = true;
    try {
      meetings = await meetingRepo.getAll();
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterMeetings(dynamic queryParams) async {
    isLoading = true;
    try {
      meetings = await meetingRepo.getWithFilter(queryParams) as List<Meeting>;
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
