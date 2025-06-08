import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  final String title;
  const SettingScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('This is setting page'),
            Icon(Icons.access_time_filled_rounded),
          ],
        ),
      ),
    );
  }
}
