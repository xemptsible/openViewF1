import 'package:get_it/get_it.dart';
import 'package:openViewF1/data/repositories/meeting_repo.dart';
import 'package:openViewF1/data/repositories/session_repo.dart';

final GetIt locator = GetIt.instance;

void setUpRepoLocator() {
  locator.registerFactory(
    () => SessionRepo(),
  );
  locator.registerFactory(
    () => MeetingRepo(),
  );
}
