import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/data/repositories/session_repo.dart';

class SessionViewModel extends ChangeNotifier {
  final SessionRepo sessionRepo;

  SessionViewModel({required this.sessionRepo});

  bool _isLoading = false;
  List<Session> _sessions = [];

  List<Session> get sessions => _sessions;
  bool get isLoading => _isLoading;

  Future<void> fetchSessions() async {
    _isLoading = true;
    try {
      _sessions = await sessionRepo.getSessions();
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
