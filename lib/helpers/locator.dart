import 'package:openViewF1/data/repositories/driver_repo.dart';
import 'package:openViewF1/data/repositories/meeting_repo.dart';
import 'package:openViewF1/data/repositories/position_repo.dart';
import 'package:openViewF1/data/repositories/session_repo.dart';

import '../main.dart';

// https://www.burkharts.net/apps/blog/one-to-find-them-all-how-to-use-service-locators-with-flutter/
// return a new instance of class every time we call Provider.of()
void setUpRepoLocator() {
  locator.registerFactory(
    () => SessionRepo(),
  );
  locator.registerFactory(
    () => MeetingRepo(),
  );
  locator.registerFactory(
    () => PositionRepo(),
  );
  locator.registerFactory(
    () => DriverRepo(),
  );
}
