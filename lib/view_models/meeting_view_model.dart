import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/meeting.dart';
import 'package:openViewF1/data/repositories/meeting_repo.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';

class MeetingViewModel extends ChangeNotifier {
  final MeetingRepo meetingRepo;

  MeetingViewModel({required this.meetingRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  List<Meeting> _meetings = [];

  List<Meeting> get meetings => _meetings;

  set meeting(List<Meeting> value) {
    _meetings = value;
  }

  String _errorMsg = "";

  String get errorMsg => _errorMsg;

  set errorMsg(String value) {
    _errorMsg = value;
  }

  Future<void> fetchMeetings() async {
    _isLoading = true;
    try {
      _meetings = await meetingRepo.getAll();
    } on DioException catch (e) {
      _errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterMeetings(dynamic queryParams) async {
    _isLoading = true;
    try {
      _meetings = await meetingRepo.getWithFilter(queryParams) as List<Meeting>;
    } on DioException catch (e) {
      _errorMsg = DioExceptionHandler.throwError(e).toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
