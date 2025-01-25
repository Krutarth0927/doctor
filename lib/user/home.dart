import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../doctor category/AllDoctorsofHospital.dart';
import '../doctor category/allcategory.dart';
import '../doctor category/doctor.dart';
import '../other/color.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> items = [
    {
      'image': 'assets/categories/Gastroenterologist.png', // Use the image asset path
      'name': 'Gastroenterologist',
      'route': AllDoctorCategoriesPage()
    },
    {
      'image': 'assets/categories/Nephrologist.png', // Use the image asset path
      'name': 'Nephrologists',
      'route': AllDoctorCategoriesPage()
    },
    {
      'image': 'assets/categories/Pathology.png', // Use the image asset path
      'name': 'Pathology',
      'route': AllDoctorCategoriesPage()
    },
    {
      'image': 'assets/categories/Orthopedist.png', // Use the image asset path
      'name': 'Orthopaedist',
      'route': AllDoctorCategoriesPage()
    },
    {
      'image': 'assets/categories/Radiologist.png', // Use the image asset path
      'name': 'Radiologist',
      'route': AllDoctorCategoriesPage()
    },
    {
      'image': 'assets/categories/more.png', // Use the image asset path
      'name': 'More',
      'route': AllDoctorCategoriesPage()
    },
  ];

  final List<Map<String, String>> topHospitals = [
    {
      "name": "Marsh Hospital",
      "type": "Consultant - Physiotherapy",
      "rating": "4.9",
      "reviews": "57 Reviews",
      "image": "assets/hospital/1.jpg", // Replace with actual image path
    },
    {
      "name": "The Skin Hub",
      "type": "Consultant - Skin Care",
      "rating": "4.8",
      "reviews": "45 Reviews",
      "image": "assets/hospital/2.jpg", // Replace with actual image path
    },
    {
      "name": "Healthy Smiles Dental",
      "type": "Consultant - Dental Care",
      "rating": "4.7",
      "reviews": "32 Reviews",
      "image": "assets/hospital/3.jpg", // Replace with actual image path
    },
    {
      "name": "City Heart Clinic",
      "type": "Consultant - Cardiology",
      "rating": "4.6",
      "reviews": "40 Reviews",
      "image": "assets/hospital/4.jpg", // Replace with actual image path
    },
    {
      "name": "Vision Eye Care",
      "type": "Consultant - Ophthalmology",
      "rating": "4.8",
      "reviews": "50 Reviews",
      "image": "assets/hospital/1.jpg", // Replace with actual image path
    },
  ];
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

        if (data['data'] != null) {
          setState(() {
            hospitals = data['data']; // Assuming the API returns a 'hospitals' key
            print(hospitals);
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
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(190), // Custom AppBar height
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primary,
            iconTheme: const IconThemeData(color: AppColors.text),
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Image.asset(
                    'assets/The easy Care Logo-Photoroom.png', // Replace with your logo path
                    height: 270,
                    width: 270,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            actions: [
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 14.0),
                          decoration: BoxDecoration(
                            color: AppColors.textPrimary,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            color: AppColors.text,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search doctor or hospital",
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.textSecondary),
                    filled: true,
                    fillColor: AppColors.text,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: AppColors.secondary),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Navigate to profile page
                    },
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.icon,
                      child: Icon(Icons.account_circle,
                          size: 50, color: AppColors.textPrimary),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Welcome, User!",
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
                Icons.person, "Profile", () => controller.onProfileTapped()),
            _buildDrawerItem(Icons.history, "Appointment History", () {}),
            _buildDrawerItem(
                Icons.alarm, "Reminder", () => controller.onReminderTapped()),
            _buildDrawerItem(Icons.person_outline, "My Doctors", () {}),
            _buildDrawerItem(Icons.payment, "Payment", () {}),
            ExpansionTile(
              leading: const Icon(Icons.settings, color: AppColors.textPrimary),
              title: const Text("Settings",
                  style: TextStyle(color: AppColors.textPrimary)),
              children: [
                _buildDrawerItem(
                    Icons.logout, "Logout", () => controller.onLogoutTapped()),
                _buildDrawerItem(Icons.delete_forever, "Delete Account", () {}),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => AllDoctorCategoriesPage());
                  },
                  child: const Text(
                    "Show All",
                    style:
                        TextStyle(fontSize: 18, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14.0,
                crossAxisSpacing: 14.0,
                childAspectRatio: 0.8,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Navigate to the specific page based on the route defined in the item
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => items[index]['route']),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          items[index]['image'], // Use image path from items list
                          fit: BoxFit.contain,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        items[index]['name'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Top Hospitals",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => doctorca());
                  },
                  child: const Text(
                    "Show All",
                    style:
                        TextStyle(fontSize: 18, color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage))
            : hospitals.isEmpty
            ? const Center(child: Text("No hospitals available"))
            : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: hospitals.length,
          itemBuilder: (context, index) {
            final hospital = hospitals[index];
            return InkWell(
              onTap: () {
                var id = hospital['ID'];
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AllDoctorsofHospital(id: id),
                ));
              },
              child: Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ClipOval(
                      //   child: hospital["image"] != null
                      //       ? Image.network(
                      //     hospital["image"]!,
                      //     height: 70,
                      //     width: 70,
                      //     fit: BoxFit.fill,
                      //     errorBuilder: (context, error, stackTrace) =>
                      //     const Icon(Icons.error, size: 70),
                      //   )
                      //       : const Icon(Icons.error, size: 70),
                      // ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
              ),
            );
          },
        ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Free Medical Camps',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25), // Apply rounded corners
                      child: Container(
                        height: 170,
                        width: 310,
                        child: Image.asset(
                          'assets/hospital/1.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: const TextStyle(color: AppColors.textPrimary)),
      onTap: onTap,
    );
  }
}
