import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../other/color.dart';

class Displayprofilescreen extends StatefulWidget {
  const Displayprofilescreen({super.key});

  @override
  State<Displayprofilescreen> createState() => _DisplayProfileScreenState();
}

class _DisplayProfileScreenState extends State<Displayprofilescreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
        title: const Text(
          "Personal Form",
          style: TextStyle(color: AppColors.text),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter your contact number',
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(
                hintText: 'Enter your date of birth',
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bloodGroupController,
              decoration: const InputDecoration(
                hintText: 'Enter your blood group',
                labelText: 'Blood Group',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your height (in cm)',
                labelText: 'Height',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your weight (in kg)',
                labelText: 'Weight',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(
                hintText: 'Enter your gender',
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                hintText: 'Enter your location',
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle the update functionality here
                  print("Profile Updated");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: AppColors.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
