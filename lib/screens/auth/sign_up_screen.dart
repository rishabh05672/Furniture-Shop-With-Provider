// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:furniture_shop_app/main_screen.dart';
import 'package:furniture_shop_app/providers/auth_provider.dart';
import 'package:furniture_shop_app/screens/config/constants.dart';
import 'package:furniture_shop_app/widgets/auth_widgets.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).signUp(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );

      if (success && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: AppConstants.headingStyle.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Sign up to get started",
                  style: AppConstants.headingStyle.copyWith(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                        label: "Full Name",
                        hint: "Enter your full name",
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      AuthTextField(
                        label: "Email",
                        hint: "Enter your E-mail",
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!value.contains("@")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      AuthTextField(
                        isPassword: true,
                        label: "Password",
                        hint: "Create your password",
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 6) {
                            return "Please enter at least 6 characters";
                          } else {
                            return null;
                          }
                        },
                      ),
                      AuthTextField(
                        isPassword: true,
                        label: "Confirm Password",
                        hint: "Enter your confirm password",
                        controller: _confirmPasswordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your confirm password";
                          }
                          if (value != _passwordController.text) {
                            return "Password do not match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32),
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          if (auth.errorMessage != null) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Text(
                                auth.errorMessage!,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),

                      //Sign Up Button
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          return AuthButton(
                            text: "Sign Up",
                            onPressed: _signUp,
                            isLoading: auth.isLoading,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                AuthDivider(),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: SocialAuthButton(
                        text: "Google",
                        icons: "assets/icons/google.png",
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: SocialAuthButton(
                        text: "Facebook",
                        icons: "assets/icons/facebook.png",
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppConstants.bodyStyle.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
