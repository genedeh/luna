import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart';
import 'package:luna/widgets/notes_layout.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: isDarkModeNotifier,
          builder: (context, isDarkMode, child) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage(
                          isDarkMode
                              ? 'assets/images/logo_light.png'
                              : 'assets/images/logo_dark.png',
                        ),
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              isDarkModeNotifier.value =
                                  !isDarkModeNotifier.value;
                            },
                            icon: ValueListenableBuilder(
                              valueListenable: isDarkModeNotifier,
                              builder: (context, isDarkMode, child) {
                                return Icon(
                                  isDarkMode
                                      ? Icons.dark_mode_rounded
                                      : Icons.light_mode_rounded,
                                  size: 35,
                                );
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.settings_rounded, size: 35),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Expanded(child: NotesLayout()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
