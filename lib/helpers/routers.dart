import 'package:go_router/go_router.dart';
import 'package:openViewF1/views/meeting_view.dart';
import 'package:openViewF1/views/session_result_view.dart';
import 'package:openViewF1/views/session_view.dart';

class Routers {
  static final goRouterInstance = Routers();

  GoRouter initGoRouter() {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const MeetingView(),
          routes: <RouteBase>[
            GoRoute(
              name: 'session',
              path: 'session',
              builder: (context, state) =>
                  SessionView(queryParams: state.uri.queryParameters),
              routes: <RouteBase>[
                GoRoute(
                  name: 'result',
                  path: 'result',
                  builder: (context, state) => SessionResultView(
                    queryParams: state.uri.queryParameters,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
