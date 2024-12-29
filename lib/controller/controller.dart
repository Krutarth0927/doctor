import 'package:d2/doctor%20category/allcategory.dart';
import 'package:d2/menu/reminder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // Define any reactive state you want to manage
  RxBool isLoading = false.obs;


  var currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }
  // Example function to simulate an action (e.g., onTap behavior)
  void onProfileTapped() {
    print("Profile tapped");
  }

  void onSettingsTapped() {
    print("Settings tapped");
  }

  void onReminderTapped(){
    Get.to(()=>ReminderPage());
  }
  void onLogoutTapped() {
    print("Logout tapped");
  }

  void onCategoryTapped(String category) {
   Get.to(doctorCategories);
  }

  void onAppointmentTapped() {
   Get.to(AllDoctorCategoriesPage());
  }

  var feedbackList = <String>[].obs;

  void addFeedback(String feedback) {
    feedbackList.add(feedback);
  }

  RxList<Map<String, dynamic>> doctorCategories = [
    {"title": "General Physician", "icon": Icons.medical_services},
    {"title": "Skin & Hair", "icon": Icons.face},
    {"title": "Women's Health", "icon": Icons.female},
    {"title": "Dental Care", "icon": Icons.local_hospital},
    {"title": "Child Specialist", "icon": Icons.child_care},
    {"title": "Ear, Nose, Throat", "icon": Icons.hearing},
    {"title": "Mental Wellness", "icon": Icons.psychology},
    {"title": "Cardiology", "icon": Icons.favorite},
    {"title": "Orthopedics", "icon": Icons.accessibility},
  ].obs; // .obs makes the list reactive

  // You can also add methods to manage the categories if needed
  void addCategory(Map<String, dynamic> newCategory) {
    doctorCategories.add(newCategory);
  }

  void removeCategory(Map<String, dynamic> category) {
    doctorCategories.remove(category);
  }
}


