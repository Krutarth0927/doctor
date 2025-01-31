import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../other/color.dart';
import 'package:intl/intl.dart';

class Displayprofilescreen extends StatefulWidget {
  const Displayprofilescreen({super.key});

  @override
  State<Displayprofilescreen> createState() => _DisplayProfileScreenState();
}

class _DisplayProfileScreenState extends State<Displayprofilescreen> {
  var isLoading = false;
  String selectedGender = "Male"; // Default value for gender

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextField(nameController, "Name", "Enter your name"),
            buildTextField(contactController, "Contact Number", "Enter your contact number", keyboardType: TextInputType.phone),
            buildDateField(),
            buildTextField(bloodGroupController, "Blood Group", "Enter your blood group"),
            buildTextField(heightController, "Height", "Enter your height (in cm)", keyboardType: TextInputType.number),
            buildTextField(weightController, "Weight", "Enter your weight (in kg)", keyboardType: TextInputType.number),
            buildGenderField(),
            buildTextField(locationController, "Location", "Enter your location"),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: updateProfile,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                child: const Text('Update', style: TextStyle(color: AppColors.text)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, String hint, {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildDateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: dobController,
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Select your date of birth',
          labelText: 'Date of Birth',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            setState(() {
              dobController.text = formattedDate;
            });
          }
        },
      ),
    );
  }

  Widget buildGenderField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Row(
          children: [
            Radio(
              value: "Male",
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value.toString();
                });
              },
            ),
            const Text("Male"),
            Radio(
              value: "Female",
              groupValue: selectedGender,
              onChanged: (value) {
                setState(() {
                  selectedGender = value.toString();
                });
              },
            ),
            const Text("Female"),
          ],
        ),
      ],
    );
  }

  void fetchUser() async {
    setState(() => isLoading = true);
    Uri url = Uri.parse("https://easydoc.clotheeo.in/apis/get_user_profile.php");
    var response = await http.post(url, body: jsonEncode({"id": 1}));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)['data'][0];
      setState(() {
        nameController.text = data['name'];
        contactController.text = data['phone'];
        dobController.text = data['dob'];
        bloodGroupController.text = data['blood_group'];
        heightController.text = data['height'];
        weightController.text = data['weight'];
        selectedGender = data['gender'];
        locationController.text = data['location'];
      });
    }
    setState(() => isLoading = false);
  }

  void updateProfile() async {
    setState(() => isLoading = true);
    Uri uri = Uri.parse("https://easydoc.clotheeo.in/apis/update_user.php");
    await http.post(uri, body: jsonEncode({
      "id": 1,
      "password": "newPassword123",
      "name": nameController.text.trim(),
      "phone": contactController.text.trim(),
      "dob": dobController.text,
      "blood_group": bloodGroupController.text.trim(),
      "height": heightController.text.trim(),
      "weight": weightController.text.trim(),
      "gender": selectedGender,
      "location": locationController.text.trim(),
    }));
    fetchUser();
    setState(() => isLoading = false);
  }
}
