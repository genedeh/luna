import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart';
import 'package:luna/pages/auth/login_page.dart';
import 'package:luna/pages/auth/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: ValueListenableBuilder(
                  valueListenable: isDarkModeNotifier,
                  builder: (context, isDarkMode, child) {
                    return Image.asset(
                      isDarkMode
                          ? 'assets/images/welcome_dark.png'
                          : 'assets/images/welcome_light.jpeg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(24),
              height: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Luna",
                          style: TextStyle(
                            fontSize: 54,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 12),
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: ValueListenableBuilder(
                            valueListenable: isDarkModeNotifier,
                            builder: (context, isDarkMode, child) {
                              return Image.asset(
                                isDarkMode
                                    ? 'assets/images/logo_dark.png'
                                    : 'assets/images/logo_light.png',
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32),
                    Text(
                      "Your personal note-taking app that keeps your thoughts organized and accessible anytime, anywhere.",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24),
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return RegisterPage();
                                  },
                                ),
                              );
                            },
                            style: FilledButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Get Started",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LoginPage();
                                  },
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
