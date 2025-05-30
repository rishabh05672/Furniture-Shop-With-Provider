import 'package:flutter/material.dart';
import 'package:furniture_shop_app/main_screen.dart';
import 'package:furniture_shop_app/providers/auth_provider.dart';
import 'package:furniture_shop_app/screens/auth/forgot_password_screen.dart';
import 'package:furniture_shop_app/screens/auth/sign_up_screen.dart';
import 'package:furniture_shop_app/screens/config/constants.dart';
import 'package:furniture_shop_app/widgets/auth_widgets.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).signIn(_emailController.text, _passwordController.text);

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  "Welcome Back!",
                  style: AppConstants.headingStyle.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Sign in to continue shopping",
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!value.contains("@")) {
                            return "Please enter a valid mail";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      AuthTextField(
                        label: "Password",
                        hint: "Enter your password",
                        isPassword: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 6) {
                            return "Password must be atleast 6 characters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12),
                      //Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
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
                          return const SizedBox.shrink();
                        },
                      ),
                      Consumer<AuthProvider>(
                        builder:
                            (context, auth, child) => AuthButton(
                              text: "Sign In",
                              onPressed: _signIn,
                              isLoading: auth.isLoading,
                            ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don\t have an account?",
                      style: AppConstants.bodyStyle.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
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
