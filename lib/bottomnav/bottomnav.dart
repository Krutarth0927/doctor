import 'package:d2/other/color.dart';
import 'package:d2/user%20profile/displayprofile%20screen.dart';
import 'package:d2/user/home.dart';
import 'package:flutter/material.dart';
import '../doctor category/doctorbooking.dart';
import '../doctor category/doctor.dart';
import '../user profile/profile.dart';

void main() {
  runApp(bottomnav());
}

class bottomnav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavExample(),
    );
  }
}


class BottomNavExample extends StatefulWidget {
  @override
  _BottomNavExampleState createState() => _BottomNavExampleState();
}

class _BottomNavExampleState extends State<BottomNavExample> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    doctorca(),
    // DoctorBookingPage(),
     Displayprofilescreen(),
    Displayprofilescreen(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: AppColors.primary,
        selectedItemColor: AppColors.text,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/categories/stethoscope.png')),
            label: 'Doctor',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Appointment',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
