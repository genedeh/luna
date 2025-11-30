import 'package:flutter/material.dart';
import 'package:luna/data/notifiers.dart' show isDarkModeNotifier;
import 'package:luna/widgets/form_widgets/input/email_field_widget.dart';
import 'package:luna/widgets/form_widgets/input/password_field_widget.dart';
import 'package:luna/widgets/form_widgets/input/username_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController(
    text: 'user',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'example.user@gmail.com',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'examplePassword',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
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
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              height: 700,
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
                          "Get Started",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: 12),
                      ],
                    ),
                    SizedBox(height: 32),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          UsernameField(controller: usernameController),
                          EmailField(controller: emailController),
                          PasswordField(controller: passwordController),
                          SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // form is valid → submit
                                }
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
  }
}
