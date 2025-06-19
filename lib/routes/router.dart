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
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          LayoutShell(navigationShell: navigationShell),
      branches: [
        // // Welcome Branch
        // StatefulShellBranch(
        //   routes: [
        //     GoRoute(
        //       path: '/welcome',
        //       builder: (context, state) => const Welcome1(title: 'Home Screen'),
        //       routes: [
        //         GoRoute(
        //           path: '2',
        //           builder: (context, state) =>
        //               const Welcome2(title: 'Home Screen 1'),
        //         ),
        //         GoRoute(
        //           path: '3',
        //           builder: (context, state) =>
        //               const Welcome3(title: 'Home Screen 1'),
        //         ),
        //         GoRoute(
        //           path: '4',
        //           builder: (context, state) => const Welcome4(title: 'title'),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),

        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) =>
                  const HomeScreen(title: 'Home Screen'),
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

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.parkingCreate,
              builder: (context, state) => const CreateParking(),
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
