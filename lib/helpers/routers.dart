import 'package:go_router/go_router.dart';
import 'package:openViewF1/views/meetings_view.dart';
import 'package:openViewF1/views/session_view.dart';

class Routers {
  Routers._();

  static final goRouterInstance = Routers._();

  GoRouter initGoRouter() {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) => const Home(),
          routes: <RouteBase>[
            GoRoute(
              path: 'session/:year/:country',
              builder: (context, state) => SessionDetail(
                queryParams: state.extra!,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
