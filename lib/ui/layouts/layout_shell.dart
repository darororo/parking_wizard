//

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';

class LayoutShell extends StatelessWidget {
  const LayoutShell({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('LayoutShell'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: destinations
            .map(
              (dest) => NavigationDestination(
                icon: Iconify(
                  _getIconData(dest.icon),
                  size: 26,
                  color: Colors.blueGrey,
                ),
                label: dest.label,
              ),
            )
            .toList(),
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
