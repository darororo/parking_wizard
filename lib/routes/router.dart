import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/layouts/layout_shell.dart';
import 'package:parking_wizard/ui/screens/history_screen.dart';
import 'package:parking_wizard/ui/screens/home_screen.dart';
import 'package:parking_wizard/ui/screens/setting_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.homeScreen,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.homeScreen,
              builder: (context, state) => const MyHomePage(title: 'bruh'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settingScreen,
              builder: (context, state) => const SettingScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.historyScreen,
              builder: (context, state) => const HistoryScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class Routes {
  Routes._();
  static const String homeScreen = '/home';
  static const String settingScreen = '/setting';
  static const String historyScreen = '/history';
}
