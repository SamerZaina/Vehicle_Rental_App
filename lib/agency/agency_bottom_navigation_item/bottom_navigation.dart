import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/agency/agency_bottom_navigation_item/home.dart';


import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'agency_profile.dart';
import 'currentRentalvehicle.dart';
import 'my_vehicle.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<String> _titles = [
    "الرئيسية",
    "مركباتي",
    "المركبات المؤجرة",
    "الملف الشخصي",
  ];

  final List<Widget> _pages =  [
    Home(),
    MyVehicle(),
    CurrentRentalVehicle(),
    AgencyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RColors.white,

      /// Dynamic AppBar title
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: RColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: RColors.textPrimary,
          ),
        ),
      ),

      // Body
      body: _pages[_currentIndex],

      /// Bottom Navigation Bar
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 70,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 25,
                offset: const Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              backgroundColor: RColors.primary,
              selectedItemColor: RColors.white,
              unselectedItemColor: Colors.white70,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              iconSize: 28,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car_outlined),
                  activeIcon: Icon(Icons.directions_car),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.car_rental_outlined),
                  activeIcon: Icon(Icons.car_rental),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  activeIcon: Icon(Icons.person),
                  label: "",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
