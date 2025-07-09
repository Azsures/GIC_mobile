import 'package:flutter/material.dart';
import 'Views/home_screen.dart'; // We will create this file next

// A ValueNotifier to hold the current theme mode. This is a simple way
// to manage state that can be accessed throughout the app.
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() {
  runApp(const GICApp());
}

class GICApp extends StatelessWidget {
  const GICApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ValueListenableBuilder rebuilds the widget tree below it when the
    // themeNotifier's value changes.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, child) {
        return MaterialApp(
          // Removes the debug banner from the top right corner
          debugShowCheckedModeBanner: false,
          title: 'GIC',
          // Define the light theme
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.indigo,

            scaffoldBackgroundColor: Colors.grey[100],
            cardColor: Colors.white,
            //useMaterial3: true
          ),
          // Define the dark theme
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.teal,

            scaffoldBackgroundColor: const Color(0xFF121212),
            cardColor: const Color(0xFF1E1E1E),
            //useMaterial3: true,
          ),
          // Set the current theme mode based on the notifier's value
          themeMode: currentMode,
          home: const HomeScreen(),
        );
      },
    );
  }
}
