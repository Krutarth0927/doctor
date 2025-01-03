import 'package:d2/doctor%20category/allcategory.dart';
import 'package:d2/doctor%20category/category.dart';
import 'package:d2/other/color.dart';
import 'package:d2/user/home.dart';
import 'package:flutter/material.dart';
class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key,});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _SelectedIndex = 0;

  void _navigationBottomBar(int index) {
    setState(() {
      _SelectedIndex = index;
    });
  }

  final List _pages = [
    HomePage(),
    AllDoctorCategoriesPage(),
    DoctorCardPage(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_SelectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.textPrimary,
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: AppColors.text,
            unselectedItemColor: AppColors.textPrimary,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _SelectedIndex,
            onTap: _navigationBottomBar,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                ),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
              ),

            ],
          ),
        ),
      ),
    );
  }
}
