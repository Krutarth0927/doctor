import 'dart:convert';

import 'package:d2/other/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:get/get.dart';


class PersonalFormController extends GetxController {



  // void saveDetails() async {
  //   final url = Uri.parse("http://localhost/doctor/save_details.php"); // Adjust IP or port as needed
  //   final body = {
  //     "name": name.value,
  //     "contact_number": contactNumber.value,
  //     "dob": dob.value,
  //     "blood_group": bloodGroup.value,
  //     "height": height.value,
  //     "weight": weight.value,
  //     "gender": gender.value,
  //     "location": location.value,
  //   };
  //
  //   try {
  //     final response = await http.post(url, body: json.encode(body), headers: {
  //       "Content-Type": "application/json",
  //     });
  //
  //     if (response.statusCode == 200) {
  //       final result = json.decode(response.body);
  //       if (result['status'] == 'success') {
  //         Get.snackbar("Success", result['message'],
  //             snackPosition: SnackPosition.TOP);
  //       } else {
  //         Get.snackbar("Error", result['message'],
  //             snackPosition: SnackPosition.TOP);
  //       }
  //     } else {
  //       Get.snackbar("Error", "Failed to connect to the server",
  //           backgroundColor: AppColors.textSecondary,
  //           colorText: AppColors.text,
  //           snackPosition: SnackPosition.TOP);
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "An error occurred: $e",
  //         backgroundColor: AppColors.textSecondary,
  //         colorText: AppColors.text,
  //         snackPosition: SnackPosition.TOP);
  //   }
  // }
}
// MedicalFormController for managing medical details
class MedicalFormController extends GetxController {
  var allergies = ''.obs;
  var currentMedications = ''.obs;
  var pastMedications = ''.obs;
  var chronicDiseases = ''.obs;
  var surgeries = ''.obs;
  var injuries = ''.obs;

  void saveDetails() {
    Get.snackbar("Success", "Medical details saved!",
        snackPosition: SnackPosition.BOTTOM);
  }
}

// LifestyleFormController for managing lifestyle details
class LifestyleFormController extends GetxController {
  var smokingHabit = ''.obs;
  var alcoholConsumption = ''.obs;
  var foodPreferences = ''.obs;
  var occupation = ''.obs;

  void saveDetails() {
    Get.snackbar("Success", "Lifestyle details saved!",
        snackPosition: SnackPosition.BOTTOM);
  }
}
