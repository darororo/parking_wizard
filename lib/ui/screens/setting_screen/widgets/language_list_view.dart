import 'package:flutter/widgets.dart';
import 'package:parking_wizard/ui/screens/setting_screen/widgets/language_tile.dart';

class LanguageListView extends StatelessWidget {
  const LanguageListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> languages = [
      {'flag': '🇰🇭', 'name': 'Khmer', 'region': 'Cambodia'},
      {'flag': '🇬🇧', 'name': 'English', 'region': 'UK'},
    ];

    return ListView(
      children: languages.map((lang) {
        return LanguageTile(
          flag: lang['flag'] ?? '',
          name: lang['name'] ?? '',
          region: lang['region'] ?? '',
          selected: false,
          onTap: () {},
        );
      }).toList(),
    );
  }
}
