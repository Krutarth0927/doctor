import 'dart:convert';

import 'package:d2/other/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/usercontroller.dart';
import 'package:http/http.dart'as http;

class ProfileFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary, // Retain the primary background
          iconTheme: const IconThemeData(
              color: AppColors.text), // Set back arrow to white
          title: const Text(
            "Profile Details",
            style: TextStyle(
                color: AppColors.text), // Title text color set to white
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.text, // Indicator color as white
            labelColor: AppColors.text, // Active tab text color as white
            unselectedLabelColor:
                AppColors.text, // Slightly dimmed for unselected tabs
            tabs: [
              Tab(text: "Personal"),
              Tab(text: "Medical"),
              Tab(text: "Lifestyle"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PersonalForm(),
            MedicalForm(),
            LifestyleForm(),
          ],
        ),
      ),
    );
  }
}

// PersonalForm with GetX
class PersonalForm extends StatelessWidget {
 // final controller = Get.put(PersonalFormController());
 //
 //  TextEditingController name= TextEditingController();
 //  TextEditingController contactNumber= TextEditingController();
 //  TextEditingController dob= TextEditingController();
 //  TextEditingController bloodGroup= TextEditingController();
 //  TextEditingController height= TextEditingController();
 //  TextEditingController weight= TextEditingController();
 //  TextEditingController gender= TextEditingController();
 //  TextEditingController location= TextEditingController();
 //
 //  Future<void> insetred() async{
 //    if(name.text != " "||contactNumber.text != " " || dob.text != " " ||bloodGroup.text != " " || height.text != " " || weight.text != " " || gender.text != " "  || location.text != "")
 //    {
 //      try{
 //        String  uri ="http://localhost/doctor/insert_record.php ";
 //        var  res = await http.post(Uri.parse(uri),body:{
 //          "name" : name.text,
 //          "contactNumber" : contactNumber.text,
 //          "dob" : dob.text,
 //          "bloodGroup" : bloodGroup.text,
 //          "height" : height.text,
 //          "weight" : weight.text,
 //          "gender" : gender.text,
 //          "location" : location.text,
 //        });
 //
 //        var responce = jsonDecode(res.body);
 //
 //        if(responce["success"]=="true"){
 //          print("recoder inserted");
 //          name.text="";
 //          contactNumber.text="";
 //          dob.text="";
 //          bloodGroup.text="";
 //          height.text="";
 //          weight.text="";
 //          gender.text="";
 //          location.text="";
 //
 //        }else{
 //          print("some issuess");
 //        }
 //      }catch(e){
 //        print(e);
 //
 //      }
 //
 //    }else{
 //      print("please fill  all field ");
 //    }
 //  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Personal Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Name"),
                 //  controller: name,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.photo),
                    label: const Text("Add Photo"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration:
                    const InputDecoration(labelText: "Contact Number"),
                    keyboardType: TextInputType.phone,
                 //  controller: contactNumber,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration:
                    const InputDecoration(labelText: "Date of Birth"),
                 //  controller: dob,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(labelText: "Blood Group"),
              // controller: bloodGroup,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration:
                    const InputDecoration(labelText: "Height (cm)"),
                    keyboardType: TextInputType.number,
               //  controller: height,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(labelText: "Weight (kg)"),
                    keyboardType: TextInputType.number,
                //   controller: weight,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(labelText: "Gender"),
                   //controller: gender,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: const InputDecoration(labelText: "Location"),
                //  controller: location,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.text,
                ),
                onPressed: (){
                //  insetred();
    },
                child: const Text("Confirm"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MedicalForm with GetX
class MedicalForm extends StatelessWidget {
  final controller = Get.put(MedicalFormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Allergies"),
                  onChanged: (value) => controller.allergies.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Current Medications"),
                  onChanged: (value) =>
                      controller.currentMedications.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Past Medications"),
                  onChanged: (value) =>
                      controller.pastMedications.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Chronic Diseases"),
                  onChanged: (value) =>
                      controller.chronicDiseases.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(labelText: "Surgeries"),
                  onChanged: (value) => controller.surgeries.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(labelText: "Injuries"),
                  onChanged: (value) => controller.injuries.value = value,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.text,
              ),
              onPressed: controller.saveDetails,
              child: const Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}

// LifestyleForm with GetX
class LifestyleForm extends StatelessWidget {
  final controller = Get.put(LifestyleFormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: "Smoking Habit"),
                  onChanged: (value) => controller.smokingHabit.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Alcohol Consumption"),
                  onChanged: (value) =>
                      controller.alcoholConsumption.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration:
                      const InputDecoration(labelText: "Food Preferences"),
                  onChanged: (value) =>
                      controller.foodPreferences.value = value,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(labelText: "Occupation"),
                  onChanged: (value) => controller.occupation.value = value,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.text,
              ),
              onPressed: controller.saveDetails,
              child: const Text("Confirm"),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primary,
          child: IconButton(
            icon:
                const Icon(Icons.account_circle, size: 50, color: AppColors.text),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileFormPage()),
              );
            },
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}
