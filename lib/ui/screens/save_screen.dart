import 'package:flutter/material.dart';

class SaveScreen extends StatelessWidget {
  final String title;
  const SaveScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [const Text('This is save page')],
        ),
      ),
    );
  }
}
