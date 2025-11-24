import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required Color kIconColor,
    required IconData icon,
    String imagePath =""
  }):
      _icon =  icon ,
    _kIconColor = kIconColor,
  _imagePath = imagePath


  ;

  final Color _kIconColor;
  final IconData  _icon;
  final String _imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
           CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(_imagePath),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: _kIconColor, width: 1.6),
                ),
                child:  Icon(
                 _icon,
                  color: _kIconColor,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}