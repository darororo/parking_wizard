import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  final String flag;
  final String name;
  final String region;
  final bool selected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.flag,
    required this.name,
    required this.region,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(flag, style: const TextStyle(fontSize: 24)),
      title: Text(name),
      subtitle: Text(region),
      onTap: onTap,
    );
  }
}