import 'package:flutter/material.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

import '../../utils/constants/colors.dart';

class FavouriteIcon extends StatelessWidget {

    const FavouriteIcon({
       super.key,
       required this.icon,
       required this.height,
       required this.width,
       this.size = 16,
       this.onPressed,
       this.color,
       this.backgroundColor
});

   final double? width,height,size;
   final IconData icon;
   final Color? color;
   final Color? backgroundColor;
   final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
           color: RHelperFunctions.isDarkMode(context)? RColors.dark :RColors.white,
                borderRadius: BorderRadius.circular(20),
        border: BoxBorder.all(
          color: RColors.grey ,
          width: 1
        )
      ),
      child: Center(
        child: IconButton(
        onPressed: onPressed, icon: Icon(icon, color: color, size: size,)),
      ),
    );
  }
}

