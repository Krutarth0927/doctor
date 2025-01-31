import 'package:d2/bottomnav/bottomnav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:d2/other/color.dart';


import '../user profile/profile.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _LoginState();
}

class _LoginState extends State<login> {
  // TextEditingController for phone number input
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Mobile Number Enter",
          style: TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your mobile number",
                style: TextStyle(
                    fontSize: size.width * 0.05, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.015,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textPrimary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Text("+91"),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        hintText: "9484776059",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              const Center(
                child: Text(
                  "By continuing, you agree to our Terms & Conditions",
                  style: TextStyle(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(double.infinity, size.height * 0.07),
                ),
                onPressed: () async{
                  try {
                    FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted: (
                            PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException ex) {},
                        codeSent: (String verificationid, int? resendtoken) {
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) =>
                              OTPScreen(verificationid: verificationid,
                                phone: _phoneController.text.toString(),)));
                        },
                        codeAutoRetrievalTimeout: (String verificationid) {},
                        phoneNumber: _phoneController.text.toString());

                    print("Phone Number: ${_phoneController.text}");
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (_) =>
                    //           OTPScreen(phone: _phoneController.text, verificationid: '',)),
                    // );
                  }catch(e){
                    print(e.toString());
                  }
                },
                child: Text(

                  "Continue",
                  style: TextStyle(
                      color: AppColors.text, fontSize: size.width * 0.05),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPScreen extends StatelessWidget {
  final String phone;
  String verificationid;
  OTPScreen({required this.phone,required this.verificationid});

  final List<TextEditingController> _otpController =
      List.generate(6, (index) => TextEditingController());

  // @override
  // void dispose() {
  //   for (var controller in _otpControllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "OTP Screen",
          style: TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter the 6-digit OTP sent to",
                style: TextStyle(
                    fontSize: size.width * 0.05, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: size.height * 0.02),
              Text(phone),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                  (index) => Container(
                    width: size.width * 0.13,
                    height: size.width * 0.13,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textSecondary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _otpController[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Row(
                children: [
                  const Text("Didn't receive the code?"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Resend"),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: Size(double.infinity, size.height * 0.05),
                ),
                onPressed: () async {

                  try{
                    String otp = _otpController
                        .map((controller) => controller.text)
                        .join();
                    PhoneAuthCredential credential = await PhoneAuthProvider.credential(verificationId: verificationid, smsCode: otp);
                    FirebaseAuth.instance.signInWithCredential(credential)
                    .then((val){
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>PersonalForm()));
                    });

                  }catch(e){

                    print(e.toString());
                  }



                  // print("Entered OTP: $otp");
                  // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>PersonalForm()));
                },
                child: Text(
                  "Continue",
                  style: TextStyle(
                      color: AppColors.text, fontSize: size.width * 0.04),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
