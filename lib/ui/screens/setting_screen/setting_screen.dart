// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class SettingScreen extends StatefulWidget {
//   const SettingScreen({super.key});

//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }

// class _SettingScreenState extends State<SettingScreen> {
//   bool _isLocationSavingOn = true;
//   bool _isDarkTheme = true;
//   bool _notificationsEnabled = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Column(
//               children: [
//                 Image.asset(
//                   'assets/images/image_setting_page.png',
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.fitWidth,
//                 ),
//               ],
//             ),
//             _buildSettingCard(
//               ListTile(
//                 title: const Text('Automatic Location Saving'),
//                 trailing: Switch(
//                   value: _isLocationSavingOn,
//                   onChanged: (value) {
//                     setState(() {
//                       _isLocationSavingOn = value;
//                     });
//                   },

//                   activeTrackColor: const Color.fromARGB(255, 57, 232, 60),
//                 ),
//               ),
//             ),
//             _buildSettingCard(
//               ListTile(
//                 title: const Text('App Theme'),
//                 trailing: Switch(
//                   value: _isDarkTheme,
//                   onChanged: (value) {
//                     setState(() {
//                       _isDarkTheme = value;
//                     });
//                   },
//                   activeTrackColor: const Color.fromARGB(255, 57, 232, 60),
//                 ),
//               ),
//             ),
//             _buildSettingCard(
//               ListTile(
//                 title: const Text('Notifications'),
//                 trailing: Switch(
//                   value: _notificationsEnabled,
//                   onChanged: (value) {
//                     setState(() {
//                       _notificationsEnabled = value;
//                     });
//                   },
//                   activeTrackColor: const Color.fromARGB(255, 57, 232, 60),
//                 ),
//               ),
//             ),
//             _buildSettingCard(
//               ListTile(
//                 title: const Text('Language'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {
//                   context.go('/settings/language');
//                 },

//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => const LanguageScreen(),
//                 //   ),
//                 // );
//               ),
//             ),

//             _buildSettingCard(
//               ListTile(
//                 title: const Text('About Page'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSettingCard(Widget child) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//       child: Card(
//         elevation: 1,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: child,
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header image section
            Stack(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/image_setting_page.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Status bar overlay
                // Positioned(
                //   top: 40,
                //   left: 20,
                //   right: 20,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         '10:26',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       Row(
                //         children: [
                //           Icon(
                //             Icons.signal_cellular_4_bar,
                //             color: Colors.white,
                //             size: 16,
                //           ),
                //           SizedBox(width: 4),
                //           Icon(Icons.wifi, color: Colors.white, size: 16),
                //           SizedBox(width: 4),
                //           Icon(
                //             Icons.battery_full,
                //             color: Colors.white,
                //             size: 16,
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // Back button
                Positioned(
                  top: 50,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      // decoration: BoxDecoration(
                      //   color: Colors.black.withOpacity(0.3),
                      //   borderRadius: BorderRadius.circular(20),
                      // ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Settings content
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Automatic Location Saving
                  _buildSettingItem(
                    icon: Image.asset(
                      'assets/images/auto_saving_location.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey[500],
                    ),

                    title: 'Automatic Location Saving',
                    isSwitch: true,
                    switchValue: _isLocationSavingOn,
                    onSwitchChanged: (value) {
                      setState(() {
                        _isLocationSavingOn = value;
                      });
                    },
                  ),

                  SizedBox(height: 12),

                  // App Theme
                  _buildSettingItem(
                    icon: Image.asset(
                      'assets/images/theme.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey[500],
                    ),
                    title: 'App Theme',
                    isSwitch: true,
                    switchValue: _isDarkTheme,
                    onSwitchChanged: (value) {
                      setState(() {
                        _isDarkTheme = value;
                      });
                    },
                  ),

                  SizedBox(height: 12),

                  // Notifications
                  _buildSettingItem(
                    icon: Image.asset(
                      'assets/images/notification.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey[500],
                    ),
                    title: 'Notifications',
                    isSwitch: true,
                    switchValue: _notificationsEnabled,
                    onSwitchChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),

                  SizedBox(height: 12),

                  // Languages
                  _buildSettingItem(
                    icon: Image.asset(
                      'assets/images/language.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey[500],
                    ),
                    title: 'Languages',
                    isSwitch: false,
                    onTap: () {
                      context.go('/settings/language');
                    },
                  ),

                  SizedBox(height: 12),

                  // About Page
                  _buildSettingItem(
                    icon: Image.asset(
                      'assets/images/support.png',
                      width: 24,
                      height: 24,
                      color: Colors.grey[500],
                    ),
                    title: 'About Page',
                    isSwitch: false,
                    onTap: () {
                      // Handle about page navigation
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    // required IconData icon,
    required Widget icon,
    required String title,
    required bool isSwitch,
    bool? switchValue,
    Function(bool)? onSwitchChanged,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: icon,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            color: Colors.black87,
          ),
        ),
        trailing: isSwitch
            ? Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: switchValue ?? false,
                  onChanged: onSwitchChanged,
                  activeColor: Colors.white,
                  activeTrackColor: Color(0xFF34C759),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey[300],
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
            : Icon(Icons.chevron_right, color: Colors.grey[400], size: 24),
        onTap: isSwitch ? null : onTap,
      ),
    );
  }
}
