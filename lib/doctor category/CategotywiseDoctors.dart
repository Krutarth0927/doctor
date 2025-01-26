import 'dart:convert';
import 'package:d2/other/color.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'doctorbooking.dart';

class CategorywiseDoctors extends StatefulWidget {
  final String category;
  const CategorywiseDoctors({Key? key, required this.category}) : super(key: key);

  @override
  State<CategorywiseDoctors> createState() => _CategorywiseDoctorsState();
}

class _CategorywiseDoctorsState extends State<CategorywiseDoctors> {
  bool _isLoading = false;
  List<Map<String, String>> doctors = [];
  var alldoctor = [];

  @override
  void initState() {
    super.initState();
    categoryDoctor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.text),
        backgroundColor: AppColors.primary,
        title: Text('Doctors in ${widget.category}',style: TextStyle(color: AppColors.text),),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : alldoctor.isEmpty
          ? const Center(child: Text("No doctors found."))
          : ListView.builder(
        itemCount: alldoctor.length,
        itemBuilder: (context, index) {

          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorBookingPage(doctorId: alldoctor[index]['ID'],)));
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.person), // Removed image
                title: Text(alldoctor[index]['name'] ?? "No Name"),
                subtitle: Text(alldoctor[index]['phone'] ?? "No Phone"),
              ),
            ),
          );
        },
      ),
    );
  }

  void categoryDoctor() async {
    print("categoryDoctor called");
    setState(() {
      _isLoading = true;
    });

    Uri uri = Uri.parse("https://easydoc.clotheeo.in/apis/doctors_categorywise.php");
    try {
      var response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"category": widget.category}),
      );

      // print("Response Status Code: ${response.statusCode}");
      // print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        setState(() {

          alldoctor = data['data'];
        });

        print(alldoctor);


        // if (data is List) {
        //   setState(() {
        //
        //     // doctors = data.map<Map<String, String>>((doctor) {
        //     //   return {
        //     //     'phone': doctor['phone'] ?? '',
        //     //     'name': doctor['name'] ?? '',
        //     //   };
        //     // }).toList();
        //   });
        // } else {
        //   print("Unexpected data format: $data");
        // }
      } else {
        print("Error: ${response.statusCode}, Response: ${response.body}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
