import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/layouts/layout_shell.dart';
import 'package:parking_wizard/ui/screens/history_screen.dart';
import 'package:parking_wizard/ui/screens/home_screen/home_screen.dart';
import 'package:parking_wizard/ui/screens/welcome/home_screen1.dart';
import 'package:parking_wizard/ui/screens/welcome/home_screen2.dart';
import 'package:parking_wizard/ui/screens/welcome/welcome_screen.dart';
import 'package:parking_wizard/ui/screens/save_screen.dart';
import 'package:parking_wizard/ui/screens/setting_screen/setting_screen.dart';
import 'package:parking_wizard/ui/screens/setting_screen/language_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class Routes {
  Routes._();
  static const String home = '/home';
  static const String save = '/save';
  static const String history = '/history';
  static const String settings = '/settings';
  static const String language = '/language';

  static const String homeScreen1 = '/home1';
  static const String homeScreen2 = '/home2';
  static const String welcomeScreen = '/welcome';
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutShell(navigationShell: navigationShell),
      branches: [
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) =>
                  const HomeScreen(title: 'Home Screen'),
            ),
            GoRoute(
              path: Routes.homeScreen1,
              builder: (context, state) =>
                  const HomeScreen1(title: 'Home Screen 1'),
            ),
            GoRoute(
              path: Routes.homeScreen2,
              builder: (context, state) =>
                  const HomeScreen2(title: 'Home Screen 2'),
            ),
            GoRoute(
              path: Routes.welcomeScreen,
              builder: (context, state) =>
                  const WelcomeScreen(title: 'Welcome Screen'),
            ),
          ],
        ),
        // Save Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.save,
              builder: (context, state) => const SaveScreen(title: 'Save'),
            ),
          ],
        ),
        // History Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.history,
              builder: (context, state) =>
                  const HistoryScreen(title: 'Parking History'),
            ),
          ],
        ),
        // Settings Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) => const SettingScreen(),
              routes: [
                // Nested language route under settings
                GoRoute(
                  path: 'language',
                  builder: (context, state) => const LanguageScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
