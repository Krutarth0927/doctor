import 'package:d2/otp/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d2/other/color.dart';
import '../controller/controller.dart';


class OnboardingScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              onPageChanged: controller.onPageChanged,
              children: [
                OnboardingPage(
                  image: "assets/1.png",
                  title: "Video consult top doctors from the comfort of your home",
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
                OnboardingPage(
                  image: "assets/2.png",
                  title: "1 Crore Indians connect with doctors every year on Practo",
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                ),
              ],
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              left: 0,
              right: 0,
              child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                      (index) => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                    height: screenHeight * 0.012,
                    width: controller.currentPage.value == index
                        ? screenWidth * 0.05
                        : screenWidth * 0.03,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index
                          ? AppColors.icon
                          : AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              )),
            ),
            Positioned(
              bottom: screenHeight * 0.01,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => login());
                  },
                  child: Obx(() => AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    height: screenHeight * 0.07,
                    width: controller.currentPage.value == 1
                        ? screenWidth * 0.6
                        : screenWidth * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.textPrimary,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
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
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;
  final double screenHeight;
  final double screenWidth;

  OnboardingPage({
    required this.image,
    required this.title,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: screenHeight * 0.4,
          width: screenWidth * 0.8,
          fit: BoxFit.contain,
        ),
        SizedBox(height: screenHeight * 0.03),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenHeight * 0.022,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}
