import 'package:flutter/material.dart';
import 'package:parking_wizard/ui/navigationTile/language_tile.dart';// <-- adjust path if needed

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int selectedIndex = 1; // default to English

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
      appBar: AppBar(title: const Text('Languages')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
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
    );
  }
}
