import 'package:flutter/material.dart';
import 'package:furniture_shop_app/providers/auth_provider.dart';
import 'package:furniture_shop_app/screens/config/constants.dart';
import 'package:furniture_shop_app/widgets/auth_widgets.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).resetPassword(_emailController.text);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password reset link sent to your email"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
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
                  "Forgot Password ?",
                  style: AppConstants.headingStyle.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Enter your email to reset your password",
                  style: AppConstants.bodyStyle.copyWith(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                        label: "Email",
                        hint: "Enter your email",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
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
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) {
                          return AuthButton(
                            text: "Reset Password",
                            onPressed: _resetPassword,
                            isLoading: auth.isLoading,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember your password?",
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
                          fontWeight: FontWeight.w600,
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
