import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart';
import 'package:luna/pages/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.black, // you control your primary manually
            scaffoldBackgroundColor: Colors.white,
            colorScheme: const ColorScheme.light(), // basic light scheme
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.black,
            colorScheme: const ColorScheme.dark(), // basic dark scheme
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const WelcomePage(),
        );
      },
    );
  }
}
