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
  String darkHexBg = '#171616';
  late String hexValueString;

  int colorInt = 0xFF171717; // Default to dark color

  @override
  void initState() {
    super.initState();
    hexValueString = darkHexBg.replaceFirst('#', '0xFF');
    colorInt = int.tryParse(hexValueString) ?? 0xFF171717;
  }

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
            scaffoldBackgroundColor: Colors.grey.shade200,
            colorScheme: const ColorScheme.light(), // basic light scheme
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Color(colorInt),
            colorScheme: const ColorScheme.dark(), // basic dark scheme
          ),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: const WelcomePage(),
        );
      },
    );
  }
}
