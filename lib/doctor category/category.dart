import 'package:flutter/material.dart';

import '../other/color.dart';
class CategoryPage extends StatelessWidget {
  final String? category;

  CategoryPage({this.category}); // Make it nullable

  @override
  Widget build(BuildContext context) {
    // Ensure category is not null before using it
    var categoryName = category ?? "Default Category"; // Provide default if null

    var data = _getCategoryData(categoryName);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.text),
        backgroundColor: AppColors.primary,
        title: Text(
          categoryName,
          style: TextStyle(color: AppColors.text),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Doctors for $categoryName",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // Display data related to the selected category
              for (var item in data)
                Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(item['name'] ?? 'No Name'),
                    subtitle: Text(item['specialty'] ?? 'No Specialty'),
                    leading: Icon(Icons.person),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _getCategoryData(String category) {
    switch (category) {
      case "General Physician":
        return [
          {"name": "Dr. John Doe", "specialty": "General Medicine"},
          {"name": "Dr. Jane Smith", "specialty": "Family Medicine"},
        ];
      case "Skin & Hair":
        return [
          {"name": "Dr. Emma Brown", "specialty": "Dermatology"},
          {"name": "Dr. Liam White", "specialty": "Cosmetic Dermatology"},
        ];
      case "Women's Health":
        return [
          {"name": "Dr. Olivia Green", "specialty": "Gynecology"},
          {"name": "Dr. Isabella Blue", "specialty": "Obstetrics"},
        ];
      case "Dental Care":
        return [
          {"name": "Dr. Sophie Black", "specialty": "Orthodontics"},
          {"name": "Dr. Samuel Gray", "specialty": "Pediatric Dentistry"},
        ];
      default:
        return [];
    }
  }
}
