import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/data/repositories/session_repo.dart';

class SessionViewModel extends ChangeNotifier {
  final SessionRepo sessionRepo;

  SessionViewModel({required this.sessionRepo});

  bool isLoading = false;
  List<Session> sessions = [];

  Future<void> fetchSessions() async {
    isLoading = true;
    try {
      sessions = await sessionRepo.getAll();
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSessionsByQuery(queryParams) async {
    isLoading = true;
    try {
      sessions = await sessionRepo.getWithFilter(queryParams) as List<Session>;
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
