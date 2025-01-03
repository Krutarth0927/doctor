import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bottom nevigation/nevigation.dart';
import '../controller/controller.dart';
import '../doctor category/allcategory.dart';


import '../other/color.dart';
import '../user profile/profile.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Center(
            child: Padding(
              padding: EdgeInsets.only(right: 35.0),
              child: Text(
                "Home",
                style: TextStyle(color: AppColors.text),
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: AppColors.text),
        ),

        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: AppColors.primary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => ProfileFormPage());
                      },
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.icon,
                        child: Icon(Icons.account_circle, size: 50,
                            color: AppColors.textPrimary),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Welcome, User!",
                      style: TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              _buildDrawerItem(
                  Icons.person, "Profile", () => controller.onProfileTapped()),
              _buildDrawerItem(Icons.history, "Appointment History", () {}),
              _buildDrawerItem(
                  Icons.alarm, "Reminder", () => controller.onReminderTapped()),
              _buildDrawerItem(Icons.person_outline, "My Doctors", () {}),
              _buildDrawerItem(Icons.payment, "Payment", () {}),
              ExpansionTile(
                leading: const Icon(Icons.settings, color: AppColors.textPrimary),
                title: const Text(
                    "Settings", style: TextStyle(color: AppColors.textPrimary)),
                children: [
                  _buildDrawerItem(
                      Icons.logout, "Logout", () => controller.onLogoutTapped()),
                  _buildDrawerItem(Icons.delete_forever, "Delete Account", () {}),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search for medicines",
                    prefixIcon: const Icon(
                        Icons.search, color: AppColors.textSecondary),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.secondary),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Find a Hospital for your Health Problem",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategory("City Hospital", "assets/hospital/1.jpg", () {
                      Get.to(() => AllDoctorCategoriesPage());
                    }),
                    _buildCategory("SkinCare Center", "assets/hospital/2.jpg", () {
                      Get.to(() => AllDoctorCategoriesPage());
                    }),
                    _buildCategory("Women's Health Clinic", "assets/hospital/3.jpg", () {
                      Get.to(() => AllDoctorCategoriesPage());
                    }),
                    _buildCategory("Dental World", "assets/hospital/4.jpg", () {
                      Get.to(() => AllDoctorCategoriesPage());
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildTopSection(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBottomCard(
                          Icons.video_call,
                          "Connect with doctors\nin 2 mins",
                          "Experts available 24/7",
                          AppColors.orange, // Icon color for this card
                        ),
                        _buildBottomCard(
                          Icons.family_restroom,
                          "Insure your family",
                          "Secure your loved ones",
                          AppColors.accent, // Icon color for this card
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _buildFeedbackForm(),
                      );
                    },
                    child: const Text(
                      "Provide Feedback", style: TextStyle(color: AppColors.text),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );

  }


  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: TextStyle(color: AppColors.textPrimary)),
      onTap: onTap,
    );
  }

  Widget _buildCategory(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 100, // Define the width for the square
              height: 100, // Define the height for the square
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8), // Slightly rounded corners
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, // Ensure the image covers the entire area
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
  Widget _buildTopSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Affordable Surgeries by Expert Surgeons",
            style: TextStyle(
              color: AppColors.text,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTopIcon(Icons.healing, "Piles"),
              _buildTopIcon(Icons.accessibility_new, "Gynecomastia"),
              _buildTopIcon(Icons.health_and_safety, "Knee\nReplacement"),
              const CircleAvatar(
                backgroundColor: AppColors.text,
                child: Text(
                  "50+",
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "All insurances accepted & No Cost EMI available",
            style: TextStyle(color: AppColors.text, fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.text),
            child: const Text(
              "Get Cost Estimate",
              style: TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.text, size: 35),
        const SizedBox(height: 8),
        Text(label, textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.text, fontSize: 10)),
      ],
    );
  }

  Widget _buildBottomCard(IconData icon, String title, String subtitle, Color iconColor) {
    return Expanded(
      child: SizedBox(
        height: 150,
        width: 100, // Set a fixed height for all cards
        child: Card(
          color: AppColors.text,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
              children: [
                Icon(icon, color: iconColor, size: 40), // Use dynamic icon color
                const SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Feedback Form",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
              hintText: "Your feedback",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            onPressed: () {
              Get.back();
            },
            child: const Text("Submit", style: TextStyle(color: AppColors.text)),
          ),
        ],
      ),
    );
  }
}
