import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LayoutShell extends StatelessWidget {
  const LayoutShell({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('LayoutShell'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: destinations
            .map(
              (dest) => NavigationDestination(
                icon: Icon(dest.icon),
                label: dest.label,
              ),
            )
            .toList(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Destination {
  const Destination({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

const destinations = <Destination>[
  Destination(icon: Icons.home_filled, label: 'Home'),
  Destination(icon: Icons.history, label: 'History'),
  Destination(icon: Icons.settings, label: 'Settings'),
];
