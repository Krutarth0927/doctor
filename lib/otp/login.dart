import 'package:d2/other/color.dart';
import 'package:d2/user/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Mobile Number Enter",style: TextStyle(color: AppColors.text),),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your mobile number",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 18),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textPrimary),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Text("+91"),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
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
            Spacer(),
            Center(
              child: Text(
                "By continuing, you agree to our Terms & Conditions",
                style: TextStyle(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => OTPScreen()),
                );
              },
              child: Text("Continue",style: TextStyle(color: AppColors.text,fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Screen",style: TextStyle(color: AppColors.text),),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the 6-digit OTP sent to",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text("+919484776059"),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textSecondary),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: TextField(

                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text("Didn't receive the code?"),
                TextButton(onPressed: () {

                }, child: Text("Resend")),


              ],
            ),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                Get.to(()=>HomePage());
              },
              child: Text("Continue",style: TextStyle(color: AppColors.text,fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}