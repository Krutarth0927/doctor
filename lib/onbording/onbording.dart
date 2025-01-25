import 'package:d2/otp/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d2/other/color.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) {
            return Stack(
              children: [
                // Animated Logo
                AnimatedBuilder(
                  animation: controller.logoAnimation,
                  builder: (context, child) {
                    return Positioned(
                      top: screenHeight * 0.3 * controller.logoAnimation.value,
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
                  animation: controller.buttonAnimation,
                  builder: (context, child) {
                    return Positioned(
                      bottom:
                      screenHeight * 0.1 * controller.buttonAnimation.value,
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
            );
          },
        ),
      ),
    );
  }
}

class SplashController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> logoAnimation;
  late Animation<double> buttonAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    logoAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    );

    buttonAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
