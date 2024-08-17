import 'package:go_router/go_router.dart';
import 'package:openViewF1/views/home.dart';
import 'package:openViewF1/views/session_detail.dart';

late GoRouter goRouter;

GoRouter initGoRouter() {
  return goRouter = GoRouter(
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
