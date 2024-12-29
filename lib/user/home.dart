import 'package:d2/user%20profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/controller.dart';
import '../doctor category/allcategory.dart'; // Import AllDoctorCategoriesPage
import '../doctor category/category.dart';
import '../other/color.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary, // Use primary color
        title: Padding(
          padding: const EdgeInsets.only(left: 100.0),
          child: Text(
            "Home",
            style: TextStyle(color: AppColors.text),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set drawer icon to white
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary, // Set primary color as background of the DrawerHeader
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(

                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.icon,
                      child: Icon(
                        Icons.account_circle,
                        size: 50,
                        color: AppColors.textPrimary,
                      ),
                    ),onTap: (){
                      Get.to(()=>ProfileFormPage());
                  },
                  ),
                  SizedBox(height: 10),
                  Text(
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
            // Drawer Items
            ListTile(
              leading: Icon(Icons.person, color: AppColors.textPrimary),
              title: Text("Profile", style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
                controller.onProfileTapped();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history, color: AppColors.textPrimary),
              title: Text("Appointment History", style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
              //  controller.onAppointmentHistoryTapped();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.alarm, color: AppColors.textPrimary),
              title: Text("Reminder", style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
                controller.onReminderTapped();

              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: AppColors.textPrimary),
              title: Text("My Doctors", style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
              //  controller.onMyDoctorsTapped();
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.payment, color: AppColors.textPrimary),
              title: Text("Payment", style: TextStyle(color: AppColors.textPrimary)),
              onTap: () {
               // controller.onPaymentTapped();
                Navigator.pop(context);
              },
            ),
            ExpansionTile(
              leading: Icon(Icons.settings, color: AppColors.textPrimary),
              title: Text("Settings", style: TextStyle(color: AppColors.textPrimary)),
              children: [
                ListTile(
                  leading: Icon(Icons.logout, color: AppColors.textSecondary),
                  title: Text("Logout", style: TextStyle(color: AppColors.textSecondary)),
                  onTap: () {
                    controller.onLogoutTapped();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete_forever, color: AppColors.textSecondary),
                  title: Text("Delete Account", style: TextStyle(color: AppColors.textSecondary)),
                  onTap: () {
                   // controller.onDeleteAccountTapped();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search for medicines",
                  prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppColors.secondary),
                  ),
                ),
              ),
            ),
            // Image Options
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCard(
                    "Book In-Clinic Appointment",
                    "assets/clinik.jpg",
                    onTap: controller.onAppointmentTapped, // Bind function from controller
                  ),
                ],
              ),
            ),
            // Find a Doctor Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Find a Doctor for your Health Problem",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildCategory("General Physician", Icons.medical_services, onTap: () {
                  Get.to(() => CategoryPage(category: "General Physician"));
                }),
                _buildCategory("Skin & Hair", Icons.face, onTap: () {
                  Get.to(() => CategoryPage(category: "Skin & Hair"));
                }),
                _buildCategory("Women's Health", Icons.female, onTap: () {
                  Get.to(() => CategoryPage(category: "Women's Health"));
                }),
                _buildCategory("Dental Care", Icons.local_hospital, onTap: () {
                  Get.to(() => CategoryPage(category: "Dental Care"));
                }),
                _buildCategory("Child Specialist", Icons.child_care, onTap: () {
                  Get.to(() => CategoryPage(category: "Child Specialist"));
                }),
                _buildCategory("Ear, Nose, Throat", Icons.hearing, onTap: () {
                  Get.to(() => CategoryPage(category: "Ear, Nose, Throat"));
                }),
                _buildCategory("Mental Wellness", Icons.psychology, onTap: () {
                  Get.to(() => CategoryPage(category: "Mental Wellness"));
                }),
                _buildCategory("more", Icons.more_horiz, onTap: () {
                  Get.to(() => AllDoctorCategoriesPage());
                }),
              ],
            ),
            // Featured Services Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Open the BottomSheet
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => FeedbackForm(onFeedbackSubmitted: (feedback) {
                        controller.addFeedback(feedback);
                        Navigator.pop(context); // Close the BottomSheet
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Feedback", style: TextStyle(color: AppColors.text)),
                ),
              ),
            ),
            SizedBox(height: 20),
// Display Feedback in Horizontal Card View
            controller.feedbackList.isEmpty
                ? Center(
              child: Text(
                "No feedback yet.",
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            )
                : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.feedbackList.map((feedback) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      width: 200,
                      child: Text(
                        feedback,
                        style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String imagePath, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap, // Trigger the onTap callback when the card is tapped
      child: Container(
        width: 150,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.cardBackground,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.primary,
            child: Icon(icon, color: AppColors.icon, size: 30),
          ),
          SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
class FeedbackForm extends StatelessWidget {
  final Function(String) onFeedbackSubmitted;

  FeedbackForm({required this.onFeedbackSubmitted});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedbackController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Submit Feedback",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 10),
          TextField(
            controller: feedbackController,
            decoration: InputDecoration(
              labelText: "Your Feedback",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final feedback = feedbackController.text.trim();
              if (feedback.isNotEmpty) {
                onFeedbackSubmitted(feedback);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Submit", style: TextStyle(color: AppColors.text)),
          ),
        ],
      ),
    );
  }
}
