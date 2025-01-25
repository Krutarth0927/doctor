import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Assuming this is defined elsewhere in your project
import '../other/color.dart';


class PersonalForm extends StatefulWidget {
  @override
  _PersonalFormState createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  File? _selectedImage;
  String? _selectedGender;
  DateTime? _selectedDateOfBirth;

  final TextEditingController name = TextEditingController();
  final TextEditingController contactNumber = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController bloodGroup = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController location = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDateOfBirth(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDateOfBirth = pickedDate;
        dob.text = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      });
    }
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
    );
  }

  Future<void> insertData() async {
    try {
      String uri = "https://easydoc.clotheeo.in/apis/insert_user.php";
      var res = await http.post(Uri.parse(uri), body: {
        "name": name.text,
        "phone": contactNumber.text,
        "dob": dob.text,
        "blood_group": bloodGroup.text,
        "height": height.text,
        "weight": weight.text,
        "gender": gender.text,
        "location": location.text,
      });

      var response = jsonDecode(res.body);
      if (response["success"] == "true") {
        print("Record inserted successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data saved successfully!")),
        );
        // Clear fields
        name.clear();
        contactNumber.clear();
        dob.clear();
        bloodGroup.clear();
        height.clear();
        weight.clear();
        gender.clear();
        location.clear();
        setState(() {
          _selectedImage = null;
          _selectedGender = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to insert data.")),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred.")),
      );
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: _inputDecoration("Name"),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text("Add Photo"),
                  ),
                  if (_selectedImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.file(
                        _selectedImage!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  TextField(
                    controller: contactNumber,
                    decoration: _inputDecoration("Contact Number"),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dob,
                    decoration: _inputDecoration("Date of Birth").copyWith(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () => _pickDateOfBirth(context),
                      ),
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: bloodGroup,
                    decoration: _inputDecoration("Blood Group"),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: height,
                    decoration: _inputDecoration("Height (cm)"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: weight,
                    decoration: _inputDecoration("Weight (kg)"),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  const Text("Gender:"),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Male",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                            gender.text = value!;
                          });
                        },
                      ),
                      const Text("Male"),
                      Radio<String>(
                        value: "Female",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                            gender.text = value!;
                          });
                        },
                      ),
                      const Text("Female"),
                      Radio<String>(
                        value: "Other",
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                            gender.text = value!;
                          });
                        },
                      ),
                      const Text("Other"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: location,
                    decoration: _inputDecoration("Location"),
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
                onPressed: insertData,
                child: const Text("Confirm"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
