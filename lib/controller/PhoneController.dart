import 'package:d2/controller/AuthenticationReposetory.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController{
  static PhoneController get instance => Get.find();
  void phoneAuthentication(String phoneno) {
    AuthenticationReposetory.instance.phoneAuthentication(phoneno);
  }
}