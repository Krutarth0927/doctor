import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../other/color.dart';
import 'doctorbooking.dart';

class AllDoctorCategoriesPage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // Get device screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "All Doctor Categories",
          style: TextStyle(color: AppColors.text),
        ),
        iconTheme: const IconThemeData(color: AppColors.text),
      ),
      body: Obx(() {
        // If categories are still loading, show a loading spinner
        if (controller.doctorCategories.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: EdgeInsets.all(screenWidth * 0.05), // Dynamic padding
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 500 ? 3 : 2, // Adjust columns based on screen width
            crossAxisSpacing: screenWidth * 0.08, // Dynamic spacing
            mainAxisSpacing: screenHeight * 0.02, // Dynamic spacing
            childAspectRatio: screenWidth > 600 ? 0.9 : 0.8, // Adjust aspect ratio for larger screens
          ),
          itemCount: controller.doctorCategories.length,
          itemBuilder: (context, index) {
            final category = controller.doctorCategories[index];
            return _buildCategoryCard(category["title"], category["image"], screenWidth);
          },
        );
      }),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath, double screenWidth) {
    return Card(
      color: AppColors.text,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Fixed size for the image container
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              height: screenWidth * 0.20, // Dynamic height based on screen width
              width: double.infinity, // Full width of the card
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain, // Use cover for better scaling
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, // Dynamic horizontal padding
              vertical: screenWidth * 0.02, // Dynamic vertical padding
            ),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => DoctorBookingPage(), arguments: {"title": title, "image": imagePath});
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.text, backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "ADD",
                style: TextStyle(color: AppColors.text, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
