import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/screens/agency_bottom_navigation_item/agency_profile.dart';
import 'package:vehicle_rental_app/screens/agency_bottom_navigation_item/home.dart';
import 'package:vehicle_rental_app/screens/agency_bottom_navigation_item/my_vehicle.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    MyVehicle(),
    AgencyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
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
              backgroundColor: RColors.primary,       // Nav bar background
              selectedItemColor: RColors.white,       // Selected icon color
              unselectedItemColor: Colors.white70,    // Unselected icon color
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,             // hide labels
              showUnselectedLabels: false,           // hide labels
              iconSize: 28,
              elevation: 0,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home),
                  label: "", // label can be empty
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car_outlined),
                  activeIcon: Icon(Icons.directions_car),
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
