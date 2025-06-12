import 'package:flutter/material.dart';
import 'package:parking_wizard/ui/navigationTile/language_tile.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = 1;

  final List<Map<String, String>> languages = [
    {'flag': '🇰🇭', 'name': 'Khmer', 'region': 'Cambodia'},
    {'flag': '🇬🇧', 'name': 'English', 'region': 'UK'},
    {'flag': '🇹🇭', 'name': 'Thai', 'region': 'Thailand'},
    {'flag': '🇮🇳', 'name': 'Hindi', 'region': 'India'},
    {'flag': '🇻🇳', 'name': 'Vietnamese', 'region': 'Vietnam'},
    {'flag': '🇰🇷', 'name': 'Korean', 'region': 'Korea'},
    {'flag': '🇯🇵', 'name': 'Japanese', 'region': 'Japan'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Icon(Icons.arrow_back, size: 28),
                  ),
                ),
              ),

              // Header image
              ClipRRect(
                child: Image.asset(
                  'assets/images/image_setting_page.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),

              // Language card with list
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
                      Row(
                        children: const [
                          Icon(Icons.language),
                          SizedBox(width: 8),
                          Text(
                            'Languages',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.check_box, color: Colors.blue),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Language list
                      ListView.builder(
                        shrinkWrap: true, // <- Important for nested ListView
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          final lang = languages[index];
                          return LanguageTile(
                            flag: lang['flag']!,
                            name: lang['name']!,
                            region: lang['region']!,
                            selected: index == selectedIndex,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
