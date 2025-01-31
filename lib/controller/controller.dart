import 'package:d2/doctor%20category/allcategory.dart';
import 'package:d2/menu/reminder.dart';
import 'package:d2/user%20profile/displayprofile%20screen.dart';
import 'package:d2/user%20profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  RxBool isLoading = false.obs;


  var currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }
  // Example function to simulate an action (e.g., onTap behavior)
  void onProfileTapped() {
   Get.to(()=>Displayprofilescreen());
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
    {"title": "Dermatologist", "image": "assets/categories/Dermatologist.png"},
    {"title": "Neurologist", "image": "assets/categories/Neurologist.png"},
    {"title": "Gastroenterologist", "image": "assets/categories/Gastroenterologist.png"},
    {"title": "Radiologist", "image": "assets/categories/Radiologist.png"},
    {"title": "Psychiatrist", "image": "assets/categories/Psychiatrist.png"},
    {"title": "Pediatrician", "image": "assets/categories/Pediatrician.png"},
    {"title": "Orthopaedist", "image": "assets/categories/Orthopedist.png"},
    {"title": "Pathology", "image": "assets/categories/Pathology.png"},
    {"title": "Family Physicians", "image": "assets/categories/Family_Physicians.png"},
    {"title": "Nephrologists", "image": "assets/categories/Nephrologist.png"},
    {"title": "Gynecologists", "image": "assets/categories/Gynecologists.png"},
    {"title": "Plastic Surgeons", "image": "assets/categories/Plastic_Surgeons.png"},
    {"title": "General Surgeons", "image": "assets/categories/General_Surgeons.png"},
    {"title": "Urologists", "image": "assets/categories/Urologists.png"},


  ].obs;


  // You can also add methods to manage the categories if needed
  void addCategory(Map<String, dynamic> newCategory) {
    doctorCategories.add(newCategory);
  }

  void removeCategory(Map<String, dynamic> category) {
    doctorCategories.remove(category);
  }


}


