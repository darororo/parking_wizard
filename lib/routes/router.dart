import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/layouts/layout_shell.dart';
import 'package:parking_wizard/ui/screens/history_screen.dart';
import 'package:parking_wizard/ui/screens/home_screen/home_screen.dart';
import 'package:parking_wizard/ui/screens/parking/create_parking.dart';
import 'package:parking_wizard/ui/screens/parking_detail_screen.dart';
import 'package:parking_wizard/ui/screens/welcome/welcome_1.dart';
import 'package:parking_wizard/ui/screens/welcome/welcome_2.dart';
import 'package:parking_wizard/ui/screens/welcome/welcome_3.dart';
import 'package:parking_wizard/ui/screens/welcome/welcome_4.dart';
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

  static const String parkingDetail = '/parking';

  static const String welcome1 = '/welcome';

  static const String welcome2 = '/welcome';
  static const String welcomeScreen = '/welcome';

  static const String parkingCreate = '/parking/create';
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  // initialLocation: Routes.home,
  initialLocation: Routes.welcome1, // This makes welcome1 the first screen
  routes: [
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const Welcome1(title: 'welcome 1'),
      routes: [
        GoRoute(
          path: '2',
          builder: (context, state) => const Welcome2(title: 'welcome 2'),
        ),
        GoRoute(
          path: '3',
          builder: (context, state) => const Welcome3(title: 'welcome 3'),
        ),
        GoRoute(
          path: '4',
          builder: (context, state) => const Welcome4(title: 'welcome 4'),
        ),
      ],
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              // path: '/welcome',
              path: Routes.home,
              // builder: (context, state) => const Welcome1(title: 'Home Screen'),
              builder: (context, state) =>
                  const HomeScreen(title: 'Home Screen'),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.save,
              // builder: (context, state) => const Welcome1(title: 'Home Screen'),
              builder: (context, state) =>
                  const SaveScreen(title: 'Save Screen'),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.history,
              builder: (context, state) =>
                  const HistoryScreen(title: 'History Screen'),
              routes: [
                GoRoute(
                  path: Routes.parkingDetail,
                  builder: (context, state) => const ParkingDetailScreen(
                    title: '',
                    description: '',
                    imgUrl: '',
                    time: '',
                  ),
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.settings,
              builder: (context, state) => const SettingScreen(),
              routes: [
                GoRoute(
                  path: Routes.language,
                  builder: (context, state) => const LanguageScreen(),
                ),
              ],
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.parkingCreate,
              builder: (context, state) => const CreateParkingScreen(),
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.parkingDetail,
              builder: (context, state) => const ParkingDetailScreen(
                title: '',
                description: '',
                imgUrl: '',
                time: '',
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
