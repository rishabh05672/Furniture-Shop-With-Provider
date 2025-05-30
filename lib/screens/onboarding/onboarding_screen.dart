import 'package:flutter/material.dart';
import 'package:furniture_shop_app/main_screen.dart';
import 'package:furniture_shop_app/providers/app_state_provider.dart';
import 'package:furniture_shop_app/screens/config/constants.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      image: "assets/images/onboarding1.png",
      title: "Discover Unique Furniture",
      description: "Find the perfect pieces to make your home truly yours",
    ),
    OnboardingPage(
      image: "assets/images/onboarding2.png",
      title: "Quality and Comfort",
      description:
          "Experience comfort with our high-quality furniture selection",
    ),
    OnboardingPage(
      image: "assets/images/onboarding3.png",
      title: "Fast Delivery",
      description: "Get your furniture delivered right to your doorstep",
    ),
  ];

  Widget _buildPage(OnboardingPage page) {
    return Container(
      color: Color(0xfffff3d9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            page.image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.contain,
          ),

          Spacer(),

          Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  page.title,
                  textAlign: TextAlign.center,
                  style: AppConstants.headingStyle.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  page.description,
                  textAlign: TextAlign.center,
                  style: AppConstants.bodyStyle.copyWith(
                    color: Colors.grey[600],
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),

          //Skip Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: TextButton(
              onPressed: _completeOnboarding,
              child: Text(
                //textAlign: TextAlign.right,
                "Skip",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        _pages.length,
                        (index) => Container(
                          width: 8,
                          height: 8,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                _currentPage == index
                                    ? AppConstants.primaryColor
                                    : Colors.grey[300],
                          ),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.defaultBorderRadius,
                        ),
                      ),
                    ),
                    onPressed: _onNextPage,
                    child: Text(
                      _currentPage == _pages.length - 1
                          ? "Get Started"
                          : "Next",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() async {
    await Provider.of<AppStateProvider>(
      context,
      listen: false,
    ).setOnboardingComplete();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
    );
  }

  void _onNextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }
}

class OnboardingPage {
  final String image;
  final String title;
  final String description;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });
}
