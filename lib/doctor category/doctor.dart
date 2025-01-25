import 'dart:convert';
import 'package:d2/other/color.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(doctorca());
}

class doctorca extends StatefulWidget {
  @override
  State<doctorca> createState() => _doctorcaState();
}

class _doctorcaState extends State<doctorca> {
  List<dynamic> hospitals = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchHospitals();
  }

  Future<void> fetchHospitals() async {
    const String apiUrl =
        "https://easydoc.clotheeo.in/apis/fetch_all_hospital.php";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['hospitals'] != null) {
          setState(() {
            hospitals = data['hospitals']; // Assuming the API returns a 'hospitals' key
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = "No hospitals data available";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "Failed to load hospitals";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching data: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.text, // Assuming you have a white color for text
            ),
          ),
          backgroundColor: AppColors.primary, // Example primary color
          title: Text(
            "Top Hospitals",
            style: TextStyle(color: AppColors.text), // Assuming you have white text color
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : hospitals.isEmpty
            ? const Center(child: Text("No hospitals available"))
            : ListView.builder(
          itemCount: hospitals.length,
          itemBuilder: (context, index) {
            final hospital = hospitals[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipOval(
                      child: Image.network(
                        hospital["image"] ?? '',
                        height: 70,
                        width: 70,
                        fit: BoxFit.fill,
                        errorBuilder:
                            (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 70),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            hospital["name"] ?? "Unknown Hospital",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            hospital["type"] ?? "Unknown Type",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                hospital["rating"]?.toString() ?? "N/A",
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "${hospital["reviews"] ?? 0} reviews",
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
