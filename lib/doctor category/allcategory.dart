import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../other/color.dart';
import '../doctor category/category.dart'; // Import the CategoryPage

class AllDoctorCategoriesPage extends StatelessWidget {
  // GetX Controller instance
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          "All Doctor Categories",
          style: TextStyle(color: AppColors.text),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        // Obx listens to changes in the RxList
        return ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: controller.doctorCategories.length,
          itemBuilder: (context, index) {
            final category = controller.doctorCategories[index];
            return _buildCategoryCard(category["title"], category["icon"]);
          },
        );
      }),
    );
  }

  // Create the category card
  Widget _buildCategoryCard(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Navigate to CategoryPage with the category title
        Get.to(() => CategoryPage(category: title));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        margin: EdgeInsets.only(bottom: 16.0), // Adds spacing between cards
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primary,
                child: Icon(icon, color: AppColors.icon, size: 30),
              ),
              SizedBox(width: 16), // Space between icon and title
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
