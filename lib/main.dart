import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_wizard/routes/router.dart';

// Ensure LocationProvider is defined in the imported file, or define it below if missing.
class LocationProvider extends ChangeNotifier {
  // Add your provider logic here
}

final locationProvider = ChangeNotifierProvider<LocationProvider>((ref) => LocationProvider());

void main() {
  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF407bff)),
      ),
    );
  }
}