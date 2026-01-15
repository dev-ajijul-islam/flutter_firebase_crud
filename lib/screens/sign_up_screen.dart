import 'package:firebase_crud_practice/screens/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameTECOntroller = .new();
  final TextEditingController _emailTECOntroller = .new();
  final TextEditingController _psswordTECOntroller = .new();
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
                Text("Sign Up", style: TextTheme.of(context).titleLarge),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nameTECOntroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                TextFormField(
                  controller: _nameTECOntroller,
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
                  controller: _nameTECOntroller,
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
                  child: Text("Sign Up"),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "Already have n account ?",
                    style: .new(color: Colors.black),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                        text: "Sign In",
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
