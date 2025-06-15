import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/heroicons.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:google_fonts/google_fonts.dart';

class LayoutShell extends StatelessWidget {
  const LayoutShell({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('LayoutShell'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.24),
              offset: Offset(0, 3),
              blurRadius: 8,
            ),
          ],
        ),

        child: Row(
          children: [
            _buildNavItem(context, 0),
            _buildNavItem(context, 1),
            _buildCenterButton(context),
            _buildNavItem(context, 2),
            _buildNavItem(context, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // Handle center action here
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF407BFF),
                borderRadius: BorderRadius.circular(12), // Not fully round
              ),
              child: Center(
                child: Iconify(Mdi.fire, size: 28, color: Colors.white),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'PARK',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final destination = destinations[index];
    final isSelected = navigationShell.currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => navigationShell.goBranch(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Iconify(
              _getIconData(destination.icon),
              size: 24,
              color: isSelected ? Colors.blue : Colors.blueGrey,
            ),
            const SizedBox(height: 4),
            Text(
              destination.label,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.blueGrey,
              ),
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
