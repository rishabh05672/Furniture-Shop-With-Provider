// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:furniture_shop_app/main_screen.dart';
import 'package:furniture_shop_app/providers/app_state_provider.dart';
import 'package:furniture_shop_app/providers/auth_provider.dart';
import 'package:furniture_shop_app/screens/auth/sign_in_screen.dart';
import 'package:furniture_shop_app/screens/config/constants.dart';
import 'package:furniture_shop_app/screens/onboarding/onboarding_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        final appStateProvider = Provider.of<AppStateProvider>(
          context,
          listen: false,
        );
        final authProvider = Provider.of<AuthProvider>(context, listen: false);

        Widget nextScreen;

        if (!appStateProvider.hasSeenOnboaring) {
          nextScreen = const OnboardingScreen();
        } else if (!authProvider.isLoggedIn) {
          nextScreen = const SignInScreen();
        } else {
          nextScreen = const MainScreen();
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      }
    });

    _controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.chair_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  "Furniture Shop",
                  style: AppConstants.headingStyle.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Text(
                  "Make your home beautiful",
                  style: AppConstants.bodyStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
