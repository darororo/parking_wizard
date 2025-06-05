import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class LayoutShell extends StatelessWidget {
  const LayoutShell({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('LayoutShell'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      // No floatingActionButton!
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Left icon
            IconButton(
              icon: Iconify(
                _getIconData(destinations[0].icon),
                size: 28,
                color: navigationShell.currentIndex == 0
                    ? Colors.blue
                    : Colors.blueGrey,
              ),
              onPressed: () => navigationShell.goBranch(0),
              tooltip: destinations[0].label,
            ),
            // Second icon
            IconButton(
              icon: Iconify(
                _getIconData(destinations[1].icon),
                size: 28,
                color: navigationShell.currentIndex == 1
                    ? Colors.blue
                    : Colors.blueGrey,
              ),
              onPressed: () => navigationShell.goBranch(1),
              tooltip: destinations[1].label,
            ),
            // Center button
            SizedBox(
              width: 56,
              height: 56,
              child: Material(
                color: const Color(0xFF407BFF),
                shape: const CircleBorder(),
                child: IconButton(
                  icon: Iconify(Mdi.fire, size: 36, color: Colors.white),
                  onPressed: () {
                    // Center button action
                  },
                  tooltip: 'FLAME',
                ),
              ),
            ),
            // Third icon
            IconButton(
              icon: Iconify(
                _getIconData(destinations[2].icon),
                size: 28,
                color: navigationShell.currentIndex == 2
                    ? Colors.blue
                    : Colors.blueGrey,
              ),
              onPressed: () => navigationShell.goBranch(2),
              tooltip: destinations[2].label,
            ),
            // Right icon
            IconButton(
              icon: Iconify(
                _getIconData(destinations[3].icon),
                size: 28,
                color: navigationShell.currentIndex == 3
                    ? Colors.blue
                    : Colors.blueGrey,
              ),
              onPressed: () => navigationShell.goBranch(3),
              tooltip: destinations[3].label,
            ),
          ],
        ),
      ),
    );
  }

  String _getIconData(String icon) {
    switch (icon) {
      case 'heroicons:home-solid':
        return Heroicons.home_solid;
      case 'ic:baseline-history':
        return Ic.baseline_history;
      case 'material-symbols:history':
        return MaterialSymbols.history;
      case 'ic:round-cloud-done':
        return Ic.cloud_done;
      case 'ic:baseline-settings':
        return Ic.baseline_settings;
      default:
        return icon;
    }
  }
}

class Destination {
  const Destination({required this.icon, required this.label});

  final String icon;
  final String label;
}

const destinations = <Destination>[
  Destination(icon: 'heroicons:home-solid', label: 'Home'),
  Destination(icon: 'ic:round-cloud-done', label: 'Save'),
  Destination(icon: 'material-symbols:history', label: 'History'),
  Destination(icon: 'ic:baseline-settings', label: 'Settings'),
];
