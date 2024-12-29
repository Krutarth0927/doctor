import 'package:d2/other/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/usercontroller.dart';
class ProfileFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary, // Retain the primary background
          iconTheme: IconThemeData(color: AppColors.text), // Set back arrow to white
          title: Text(
            "Profile Details",
            style: TextStyle(color: AppColors.text), // Title text color set to white
          ),
          bottom: TabBar(
            indicatorColor: AppColors.text, // Indicator color as white
            labelColor: AppColors.text, // Active tab text color as white
            unselectedLabelColor: AppColors.text, // Slightly dimmed for unselected tabs
            tabs: [
              Tab(text: "Personal"),
              Tab(text: "Medical"),
              Tab(text: "Lifestyle"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PersonalForm(),
            MedicalForm(),
            LifestyleForm(),
          ],
        ),
      ),
    );
  }
}


// PersonalForm with GetX
class PersonalForm extends StatelessWidget {
  final controller = Get.put(PersonalFormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Name"),
                  onChanged: (value) => controller.name.value = value,
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.photo),
                  label: Text("Add Photo"),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Contact Number"),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) => controller.contactNumber.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Date of Birth"),
                  onChanged: (value) => controller.dob.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Blood Group"),
                  onChanged: (value) => controller.bloodGroup.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Height (cm)"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.height.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Weight (kg)"),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => controller.weight.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Gender"),
                  onChanged: (value) => controller.gender.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Location"),
                  onChanged: (value) => controller.location.value = value,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.text,
              ),
              onPressed: controller.saveDetails,
              child: Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}

// MedicalForm with GetX
class MedicalForm extends StatelessWidget {
  final controller = Get.put(MedicalFormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Allergies"),
                  onChanged: (value) => controller.allergies.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Current Medications"),
                  onChanged: (value) => controller.currentMedications.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Past Medications"),
                  onChanged: (value) => controller.pastMedications.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Chronic Diseases"),
                  onChanged: (value) => controller.chronicDiseases.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Surgeries"),
                  onChanged: (value) => controller.surgeries.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Injuries"),
                  onChanged: (value) => controller.injuries.value = value,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.text,
              ),
              onPressed: controller.saveDetails,
              child: Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}

// LifestyleForm with GetX
class LifestyleForm extends StatelessWidget {
  final controller = Get.put(LifestyleFormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Smoking Habit"),
                  onChanged: (value) => controller.smokingHabit.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Alcohol Consumption"),
                  onChanged: (value) => controller.alcoholConsumption.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Food Preferences"),
                  onChanged: (value) => controller.foodPreferences.value = value,
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(labelText: "Occupation"),
                  onChanged: (value) => controller.occupation.value = value,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.text,
              ),
              onPressed: controller.saveDetails,
              child: Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primary,
          child: IconButton(
            icon: Icon(Icons.account_circle, size: 50, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileFormPage()),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
