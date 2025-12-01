import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart' show isDarkModeNotifier;
import 'package:luna/pages/widget_tree.dart';
import 'package:luna/widgets/form_widgets/input/email_field_widget.dart';
import 'package:luna/widgets/form_widgets/input/password_field_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(
    text: 'example.user@gmail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'examplePassword',
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        final Color bgColor = isDarkMode ? Colors.black : Colors.white;
        return Scaffold(
          appBar: AppBar(backgroundColor: bgColor),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    color: bgColor,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        isDarkMode
                            ? 'assets/images/welcome_dark.png'
                            : 'assets/images/welcome_light.jpeg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(24),
                  height: 700,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Welcome Back",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 32),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              EmailField(controller: emailController),
                              PasswordField(controller: passwordController),
                              SizedBox(height: 32),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return WidgetTree();
                                          },
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  },
                                  style: FilledButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 16),
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
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
