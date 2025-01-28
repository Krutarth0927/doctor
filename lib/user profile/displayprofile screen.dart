import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../other/color.dart';
import 'package:http/http.dart' as http;

class Displayprofilescreen extends StatefulWidget {
  const Displayprofilescreen({super.key});

  @override
  State<Displayprofilescreen> createState() => _DisplayProfileScreenState();
}

class _DisplayProfileScreenState extends State<Displayprofilescreen> {

  var isLoading = false;

   TextEditingController nameController = TextEditingController();
   TextEditingController contactController = TextEditingController();
   TextEditingController dobController = TextEditingController();
   TextEditingController bloodGroupController = TextEditingController();
   TextEditingController heightController = TextEditingController();
   TextEditingController weightController = TextEditingController();
   TextEditingController genderController = TextEditingController();
   TextEditingController locationController = TextEditingController();


  @override
  void initState() {
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: AppColors.text),
        ),
        backgroundColor: AppColors.primary,
        title: const Text(
          "Personal Form",
          style: TextStyle(color: AppColors.text),
        ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter your contact number',
                labelText: 'Contact Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(
                hintText: 'Enter your date of birth',
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: bloodGroupController,
              decoration: const InputDecoration(
                hintText: 'Enter your blood group',
                labelText: 'Blood Group',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your height (in cm)',
                labelText: 'Height',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your weight (in kg)',
                labelText: 'Weight',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(
                hintText: 'Enter your gender',
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(
                hintText: 'Enter your location',
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle the update functionality here
                  updateProfile();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: AppColors.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void fetchUser() async{
    isLoading = true;
     Uri url = Uri.parse("https://easydoc.clotheeo.in/apis/get_user_profile.php");
     var response = await http.post(url,body: jsonEncode({
         "id": 1
     }));

     // print(response.body);
     if(response.statusCode==200) {
       var responsebody = json.decode(response.body);

       var data = responsebody['data'];

       nameController.text = data[0]['name'];

       contactController.text = data[0]['phone'];
       dobController.text = data[0]['dob'];
       bloodGroupController.text = data[0]['blood_group'];
       heightController.text = data[0]['height'];
       weightController.text = data[0]['weight'];
       genderController.text = data[0]['gender'];
       locationController.text = data[0]['location'];
       setState(() {

       });
     }
     else{
       "not data";
     }
     isLoading = false;

}

  void updateProfile()async{

    isLoading = true;
    Uri uri  = Uri.parse("https://easydoc.clotheeo.in/apis/update_user.php");
    final response = await http.post(uri,body: jsonEncode({
        "id": 1,
        "password": "newPassword123",
        "name": "Jagdishm",
        "phone": "1234567890",
        "dob": "1990-01-01",
        "blood_group": "O+",
        "height": 175,
        "weight": 70,
        "gender": "Male",
        "location": "New York"
    }));

        if(response.statusCode==201){
      fetchUser();
    }

    isLoading = false;
    setState(() {

    });
  }
}
