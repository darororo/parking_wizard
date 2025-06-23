// lib/routes/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/common/models/parking_model.dart';
import 'package:parking_wizard/ui/layouts/layout_shell.dart';
import 'package:parking_wizard/ui/screens/history_screen.dart';
import 'package:parking_wizard/ui/screens/home_screen/home_screen.dart';
import 'package:parking_wizard/ui/screens/parking/create_parking.dart';
import 'package:parking_wizard/ui/screens/parking/parking_detail_screen.dart';
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
  static const String parkingDetail = '/parking-detail';
  static const String welcome1 = '/welcome';
  static const String welcome2 = '/welcome/2';
  static const String welcome3 = '/welcome/3';
  static const String welcome4 = '/welcome/4';
  static const String parkingCreate = '/parking/create';
}

// Traditional MaterialApp router (optional fallback)
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const HomeScreen(title: 'Home Screen'));
    case Routes.parkingCreate:
      return MaterialPageRoute(builder: (_) => const CreateParkingScreen());
    case Routes.parkingDetail:
      final parkingSpot = settings.arguments as ParkingSpot;
      return MaterialPageRoute(
        builder: (_) => ParkingDetailScreen(parkingSpot: parkingSpot),
      );
    // Add other cases as needed
    default:
      return MaterialPageRoute(builder: (_) => const HomeScreen(title: 'Home Screen'));
  }
}

// GoRouter configuration (primary router)
final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.welcome1,
  routes: [
    GoRoute(
      path: Routes.welcome1,
      builder: (context, state) => const Welcome1(title: 'Welcome 1'),
      routes: [
        GoRoute(
          path: '2',
          builder: (context, state) => const Welcome2(title: 'Welcome 2'),
        ),
        GoRoute(
          path: '3',
          builder: (context, state) => const Welcome3(title: 'Welcome 3'),
        ),
        GoRoute(
          path: '4',
          builder: (context, state) => const Welcome4(title: 'Welcome 4'),
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
              path: Routes.home,
              builder: (context, state) => const HomeScreen(title: 'Home Screen'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.save,
              builder: (context, state) => const SaveScreen(title: 'Save Screen'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.history,
              builder: (context, state) => const HistoryScreen(title: 'History Screen'),
              routes: [
                GoRoute(
                  path: 'detail',
                  builder: (context, state) {
                    final parkingSpot = state.extra as ParkingSpot;
                    return ParkingDetailScreen(parkingSpot: parkingSpot);
                  },
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
                  path: 'language',
                  builder: (context, state) => const LanguageScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),

    // Standalone routes
    GoRoute(
      path: Routes.parkingCreate,
      builder: (context, state) => const CreateParkingScreen(),
    ),
    GoRoute(
      path: Routes.parkingDetail,
      builder: (context, state) {
        final parkingSpot = state.extra as ParkingSpot;
        return ParkingDetailScreen(parkingSpot: parkingSpot);
      },
    ),
  ],
);