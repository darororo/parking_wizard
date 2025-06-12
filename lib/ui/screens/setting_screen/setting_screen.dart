import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_wizard/ui/screens/setting_screen/language_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _isLocationSavingOn = true;
  bool _isDarkTheme = true;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/image_setting_page.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
            _buildSettingCard(
              ListTile(
                title: const Text('Automatic Location Saving'),
                trailing: Switch(
                  value: _isLocationSavingOn,
                  onChanged: (value) {
                    setState(() {
                      _isLocationSavingOn = value;
                    });
                  },
                  
                  activeTrackColor: const Color.fromARGB(255, 57, 232, 60),
                  
                ),
              ),
            ),
            _buildSettingCard(
              ListTile(
                title: const Text('App Theme'),
                trailing: Switch(
                  value: _isDarkTheme,
                  onChanged: (value) {
                    setState(() {
                      _isDarkTheme = value;
                    });
                  },
                  activeTrackColor: const Color.fromARGB(255, 57, 232, 60),
                ),
              ),
            ),
            _buildSettingCard(
              ListTile(
                title: const Text('Notifications'),
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                  activeTrackColor: const Color.fromARGB(255, 57, 232, 60),
                ),
              ),
            ),
            _buildSettingCard(
              ListTile(
                title: const Text('Language'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () { context.go('/settings/language');},
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const LanguageScreen(),
                  //   ),
                  // );
          
              ),
            ),

            _buildSettingCard(
              ListTile(
                title: const Text('About Page'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      ),
    );
  }
}
