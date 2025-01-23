import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationReposetory extends GetxController{
  static AuthenticationReposetory get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  var varificationId = ''.obs;

  Future<void> phoneAuthentication(String phoneNo) async{
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credentials) async {
          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (e){
          if(e.code == 'invalid-phone-number'){
            Get.snackbar("Error", "The Phone number is not valid");
          }else{
            Get.snackbar("Error", e.toString());
          }
        },
        codeSent: (varificationId,validationToken){
          this.varificationId.value = varificationId;

        },
        codeAutoRetrievalTimeout: (varificationId){
          this.varificationId.value = varificationId;
        });
  }

  Future<bool> varifyOTP(String otp)async{
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: varificationId.value, smsCode: varificationId.value));
    return credentials.user !=null ? true : false;

  }

}