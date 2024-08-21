import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:openViewF1/data/repositories/meeting_repo.dart';
import 'package:openViewF1/data/repositories/session_repo.dart';
import 'package:openViewF1/helpers/locator.dart';
import 'package:openViewF1/helpers/routers.dart';
import 'package:openViewF1/view_models/session_view_model.dart';
import 'package:openViewF1/view_models/meeting_view_model.dart';
import 'package:provider/provider.dart';

// Initialize a global GoRouter variable
// so it doesn't get rebuilt on hot reload.
final goRouter = Routers.goRouterInstance.initGoRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // final box = await Hive.openBox('testBox');

  // Repostiory locators
  // Service Locator pattern with GetX
  setUpRepoLocator();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              SessionViewModel(sessionRepo: locator<SessionRepo>()),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              MeetingViewModel(meetingRepo: locator<MeetingRepo>()),
        )
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      // Theme config for FlexColorScheme version 7.3.x. Make sure you use
// same or higher package version, but still same major version. If you
// use a lower package version, some properties may not be supported.
// In that case remove them after copying this theme to your app.
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xffe10600),
          primaryContainer: Color(0xfff6b1af),
          secondary: Color(0xff15151e),
          secondaryContainer: Color(0xffff8a80),
          tertiary: Color(0xfff7f4f1),
          tertiaryContainer: Color(0xff95f0ff),
          appBarColor: Color(0xffff8a80),
          error: Color(0xffb00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 8,
        appBarStyle: FlexAppBarStyle.background,
        lightIsWhite: false,
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        colors: const FlexSchemeColor(
          primary: Color(0xffe10600),
          primaryContainer: Color(0xff703334),
          secondary: Color(0xfff7f4f1),
          secondaryContainer: Color(0xff872100),
          tertiary: Color(0xffc78b8b),
          tertiaryContainer: Color(0xfff1f1f1),
          appBarColor: Color(0xff872100),
          error: Color(0xffcf6679),
        ),
        surfaceMode: FlexSurfaceMode.highScaffoldLevelSurface,
        blendLevel: 20,
        appBarStyle: FlexAppBarStyle.background,
        swapColors: true,
        useMaterial3ErrorColors: true,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the Playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      // If you do not have a themeMode switch, uncomment this line
      // to let the device system mode control the theme mode:
      themeMode: ThemeMode.system,

      // home: const Home(),
    );
  }
}
