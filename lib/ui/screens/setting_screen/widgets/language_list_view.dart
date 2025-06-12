import 'package:flutter/widgets.dart';
import 'package:parking_wizard/ui/screens/setting_screen/widgets/language_tile.dart';

class LanguageListView extends StatelessWidget {
  const LanguageListView({super.key});

  @override
  Widget build(BuildContext context) {
  int _selectedIndex = 1;

  final List<Map<String, String>> languages = [
    {'flag': '🇰🇭', 'name': 'Khmer', 'region': 'Cambodia'},
    {'flag': '🇬🇧', 'name': 'English', 'region': 'UK'},
    {'flag': '🇹🇭', 'name': 'Thai', 'region': 'Thailand'},
    {'flag': '🇮🇳', 'name': 'Hindi', 'region': 'India'},
    {'flag': '🇻🇳', 'name': 'Vietnamese', 'region': 'Vietnam'},
    {'flag': '🇰🇷', 'name': 'Korean', 'region': 'Korea'},
    {'flag': '🇯🇵', 'name': 'Japanese', 'region': 'Japan'},
  ];

    return ListView(children: [
     LanguageTile(flag: 'ABC', name: 'ABC', region: 'ABC', selected: false, onTap: () {}),
    ],);
  }
}