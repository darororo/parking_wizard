import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/layouts/layout_shell.dart';
import 'package:parking_wizard/ui/screens/history_screen.dart';
import 'package:parking_wizard/ui/screens/home_screen/home_screen.dart';
import 'package:parking_wizard/ui/screens/welcome/home_screen1.dart';
import 'package:parking_wizard/ui/screens/welcome/home_screen2.dart';
import 'package:parking_wizard/ui/screens/welcome/welcome_screen.dart';
import 'package:parking_wizard/ui/screens/save_screen.dart';
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
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.saveScreen,
              builder: (context, state) =>
                  const SaveScreen(title: 'Save Screen'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settingScreen,
              builder: (context, state) =>
                  const HistoryScreen(title: 'Parking History'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.historyScreen,
              builder: (context, state) =>
                  const SettingScreen(title: 'Setting Screen'),
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
  static const String homeScreen1 = '/home1';
  static const String homeScreen2 = '/home2';
  static const String welcomeScreen = '/welcome';
  static const String saveScreen = '/save';
  static const String historyScreen = '/history';
  static const String settingScreen = '/setting';
}
