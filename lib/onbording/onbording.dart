import 'package:d2/otp/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d2/other/color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _logoAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _buttonAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Animated Logo
            AnimatedBuilder(
              animation: _logoAnimation,
              builder: (context, child) {
                return Positioned(
                  top: screenHeight * 0.3 * _logoAnimation.value,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      "assets/The easy Care Logo-Photoroom.png",
                      height: screenHeight * 0.4,
                      width: screenWidth * 0.8,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
            ),
            // Animated Button
            AnimatedBuilder(
              animation: _buttonAnimation,
              builder: (context, child) {
                return Positioned(
                  bottom: screenHeight * 0.1 * _buttonAnimation.value,
                  left: screenWidth * 0.2,
                  right: screenWidth * 0.2,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const login());
                    },
                    child: Container(
                      height: screenHeight * 0.06,
                      width: screenWidth * 0.6,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.textPrimary,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
