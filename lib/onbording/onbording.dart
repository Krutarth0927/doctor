import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d2/other/color.dart';
import '../controller/controller.dart';
import '../user/home.dart';
// Ensure you have the HomePage implemented

class OnboardingScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          PageView(
            onPageChanged: controller.onPageChanged,
            children: [
              OnboardingPage(
                image: "assets/1.png",
                title: "Video consult top doctors from the comfort of your home",
              ),
              OnboardingPage(
                image: "assets/2.png",
                title: "1 Crore Indians connect with doctors every year on Practo",
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: controller.currentPage.value == index ? 20 : 10,
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
            bottom: 20,
            left: 16,
            right: 16,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Get.to(() => HomePage());
                },
                child: Obx(() => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 50,
                  width: controller.currentPage.value == 1 ? 200 : 150,
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
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String title;

  OnboardingPage({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 300,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
        ),
      ],
    );
  }
}
