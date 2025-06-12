import 'package:flutter/material.dart';
import 'package:parking_wizard/ui/screens/language_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
            
            
            _buildSettingCard(
              ListTile(
                title: const Text('App Theme'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
            
            
            _buildSettingCard(
              ListTile(
                title: const Text('Notifications'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
            
           
            _buildSettingCard(
              ListTile(
                title: const Text('Language'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageScreen(),
                    ),
                  );
                },
              ),
            ),
            
            
            _buildSettingCard(
              ListTile(
                title: const Text('About Page'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
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