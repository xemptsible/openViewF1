import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/meeting.dart';
import 'package:openViewF1/data/repositories/meeting_repo.dart';

class MeetingViewModel extends ChangeNotifier {
  final MeetingRepo meetingRepo;

  MeetingViewModel({required this.meetingRepo});

  bool _isLoading = false;
  List<Meeting> _meeting = [];

  bool get isLoading => _isLoading;
  List<Meeting> get meetings => _meeting;

  Future<void> fetchMeetings() async {
    _isLoading = false;
    try {
      _meeting = await meetingRepo.getAll();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> filterMeetings(dynamic queryParams) async {
    _isLoading = false;
    try {
      _meeting = await meetingRepo.getWithFilter(queryParams) as List<Meeting>;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
