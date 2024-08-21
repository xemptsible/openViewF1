import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/data/repositories/session_repo.dart';
import 'package:openViewF1/helpers/services/dio_exception_handler.dart';

class SessionViewModel extends ChangeNotifier {
  final SessionRepo sessionRepo;

  SessionViewModel({required this.sessionRepo});

  bool isLoading = false;
  List<Session> sessions = [];
  String errorMsg = "";

  Future<void> fetchSessions() async {
    isLoading = true;
    try {
      sessions.clear();
      sessions = await sessionRepo.getAll();
      sessions = sessions.reversed.toList();
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSessionsByQuery(queryParams) async {
    isLoading = true;
    try {
      sessions.clear();
      sessions = await sessionRepo.getWithFilter(queryParams: queryParams);
      sessions = sessions.reversed.toList();
      print(sessions);
    } on DioException catch (e) {
      errorMsg = DioExceptionHandler.throwError(e).toString();
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
