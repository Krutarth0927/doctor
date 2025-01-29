import 'package:d2/otp/OtpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../other/color.dart';

class PhoneAuth extends StatefulWidget{
  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // TODO: implement build
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
        "Mobile Number",
        style: TextStyle(color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        ),
      body: Column(children: [
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
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: "0000000000",
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.03),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: Size(double.infinity, size.height * 0.07),
          ),
          onPressed: () async{
            try {
              await FirebaseAuth.instance.verifyPhoneNumber(
                phoneNumber: '+916359439942',
                verificationCompleted: (PhoneAuthCredential credential) async {
                  await FirebaseAuth.instance.signInWithCredential(credential);
                },
                verificationFailed: (FirebaseAuthException e) {
                  print('Verification failed: ${e.message}');
                },
                codeSent: (String verificationId, int? resendToken) {
                  print('Code sent to phone $verificationId');
                },
                codeAutoRetrievalTimeout: (String verificationId) {
                  print('Code retrieval timeout');
                },
              );
            } catch (e) {
              print('Error: $e');
            }

          },
          child: Text(
            "Continue",
            style: TextStyle(
                color: AppColors.text, fontSize: size.width * 0.05),
          ),
        ),
      ],),
    );
  }
}