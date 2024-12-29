import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class PersonalFormController extends GetxController {
  var name = ''.obs;
  var contactNumber = ''.obs;
  var dob = ''.obs;
  var bloodGroup = ''.obs;
  var height = ''.obs;
  var weight = ''.obs;
  var gender = ''.obs;
  var location = ''.obs;

  void saveDetails() {
    Get.snackbar("Success", "Personal details saved!",
        snackPosition: SnackPosition.TOP);
  }

  // Rx<File?> selectedImage = Rx<File?>(null);
  //
  // Future<void> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     selectedImage.value = File(image.path);
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
