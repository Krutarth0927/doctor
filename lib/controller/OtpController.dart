import 'package:d2/controller/AuthenticationReposetory.dart';
import 'package:d2/user/home.dart';
import 'package:get/get.dart';

class OtpController extends GetxController{
  static OtpController get instance => Get.find();

  void verifyOtp(String str) async{
    var verified = await AuthenticationReposetory.instance.varifyOTP(str);
    if(verified){
      Get.offAll(HomePage());
    }else{
     Get.back();
    }
  }

}