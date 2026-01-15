import 'package:firebase_crud_practice/screens/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = .new();
  final TextEditingController _passwordTEController = .new();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            child: Column(
              spacing: 10,
              mainAxisAlignment: .center,
              crossAxisAlignment: .center,
              children: [
                Text("Sign In", style: TextTheme.of(context).titleLarge),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailTEController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordTEController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    border: OutlineInputBorder(),
                  ),
                ),
                FilledButton(
                  style: .new(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: .circular(10)),
                    ),
                    fixedSize: WidgetStatePropertyAll(
                      Size(double.maxFinite, 50),
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Sign In"),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account ?",
                    style: .new(color: Colors.black),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                        text: "Sign Up",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
