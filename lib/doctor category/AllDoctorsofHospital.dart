import 'package:d2/doctor%20category/doctorbooking.dart';
import 'package:d2/other/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllDoctorsofHospital extends StatefulWidget {
  final String id;

  AllDoctorsofHospital({required this.id});

  @override
  State<AllDoctorsofHospital> createState() => _AllDoctorsofHospitalState();
}

class _AllDoctorsofHospitalState extends State<AllDoctorsofHospital> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: AppColors.text
        ),
        title: Text('Doctors of Hospital ${widget.id}',style: TextStyle(color: AppColors.text),),
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder(
        future: fetchDoctors(widget.id), // Function to fetch doctors for the given hospital ID
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text("No doctors available"));
          } else {
            List doctors = snapshot.data as List;
            return ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                final doctor = doctors[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: GestureDetector(
                    onTap: (){
                      print("===============================================================================");
                      print(doctor['ID']);
                      Get.to(()=> DoctorBookingPage(doctorId: doctor['ID']));
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        // backgroundImage: NetworkImage(
                        //   doctor['image'] != null
                        //       ? "https://easydoc.clotheeo.in${doctor['image'].replaceAll('..', '')}"
                        //       : '',
                        // ),
                        // onBackgroundImageError: (_, __) => const Icon(Icons.error),
                      ),
                      title: Text(doctor["name"] ?? "Unknown Doctor"),
                      subtitle: Text(
                        doctor["category"] ?? "Specialty not available",
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List> fetchDoctors(String hospitalId) async {
    final url =
    Uri.parse('https://easydoc.clotheeo.in/apis/doctors_of_hospital.php');
    try {
      final response = await http.post(
        url,
        body: jsonEncode({'hid': hospitalId}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
          print(data['data']);
          return data['data']; // Assuming the API returns a key `data` with doctor details

      } else {
        throw Exception('Failed to load doctors. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load doctors: $e');
    }
  }
}
