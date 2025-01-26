import 'dart:convert';
import 'package:d2/doctor%20category/CategotywiseDoctors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/controller.dart';
import '../other/color.dart';

class AllDoctorCategoriesPage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
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
        if (controller.doctorCategories.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: EdgeInsets.all(screenWidth * 0.05),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: screenWidth > 500 ? 3 : 2,
            crossAxisSpacing: screenWidth * 0.07,
            mainAxisSpacing: screenHeight * 0.02,
            childAspectRatio: screenWidth > 600 ? 0.9 : 0.8,
          ),
          itemCount: controller.doctorCategories.length,
          itemBuilder: (context, index) {
            final category = controller.doctorCategories[index];
            return _buildCategoryCard(category["title"], category["image"], screenWidth,context);
          },
        );
      }),
    );
  }

  Widget _buildCategoryCard(String title, String imagePath, double screenWidth,BuildContext context) {
    return Card(
      color: AppColors.text,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Container(
              height: screenWidth * 0.20,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.02,
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
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CategotywicseDoctors(category: title),));
              // //  final response = await fetchDoctors(title);
              //   if (response != null) {
              //
              //     // Get.to(() => CategotywicseDoctors(category: title,));
              //   } else {
              //     Get.snackbar("Error", "Failed to fetch doctors");
              //   }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.text, backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "VIEW",
                style: TextStyle(color: AppColors.text, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<dynamic>?> fetchDoctors(String category) async {
    try {
      final response = await http.post(
        Uri.parse('https://easydoc.clotheeo.in/apis/doctors_of_hospital.php'),
        body: {'category': category},
      );
      print('API Response: ${response.body}'); // Debugging line
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return data; // Ensure it’s a list
        } else {
          print('Unexpected API response format');
          return null;
        }
      } else {
        print('Error: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
  }

  class DoctorListPage extends StatelessWidget {
  final List<dynamic> doctors;

  const DoctorListPage({Key? key, required this.doctors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors List"),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          final doctor = doctors[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(doctor['image']),
              ),
              title: Text(doctor['name']),
              subtitle: Text(doctor['specialization']),
            ),
          );
        },
      ),
    );
  }
}
