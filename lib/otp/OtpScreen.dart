
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bottomnav/bottomnav.dart';
import '../other/color.dart';

class OTPScreen extends StatefulWidget{
  String verificationid;
  OTPScreen({required  this.verificationid});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();
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

      body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Enter OTP ",
          style: TextStyle(
              fontSize: size.width * 0.05, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: size.height * 0.02),
        TextField(controller: otpController,),
        SizedBox(height: size.height * 0.03),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: Size(double.infinity, size.height * 0.05),
          ),
          onPressed: () async {

            try{

              PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.verificationid, smsCode: otpController.text.toString());
              FirebaseAuth.instance.signInWithCredential(credential)
                  .then((val){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>bottomnav()));
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


    );
  }
}