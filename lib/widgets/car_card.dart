import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';
import 'favourite_icon.dart';

class CarCard extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String location;
  final String seats;
  final String price;

  const CarCard({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.location,
    required this.seats,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Container(
      width: 190.w,
      margin: const EdgeInsets.fromLTRB(3, 15, 3, 0),
      decoration: BoxDecoration(
        color: dark ? RColors.black:Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dark ? RColors.primary40:Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: RColors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )
                ),
                child: ClipRRect(
                  child: Image.asset(
                    image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child:
                  FavouriteIcon(icon: CupertinoIcons.heart, height: 25.h, width: 25.w ,size: 12.sp,)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(rating),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.event_seat,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(seats),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.attach_money,
                        size: 18, color: Colors.black),
                    Text(
                      price,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CarCardBookButton extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String location;
  final String seats;
  final String price;

  const CarCardBookButton({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.location,
    required this.seats,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Container(
      width: 190.w,
      margin: const EdgeInsets.fromLTRB(3, 15, 3, 0),
      decoration: BoxDecoration(
        color: dark ? RColors.black:Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: dark ? RColors.primary40:Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: RColors.grey.withOpacity(0.7),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )
                ),
                child: ClipRRect(
                  child: Image.asset(
                    image,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  right: 10,
                  top: 10,
                  child:
                  FavouriteIcon(icon: CupertinoIcons.heart, height: 25.h, width: 25.w ,size: 12.sp,)
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.star, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(rating),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    location,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Container(
                    width: 70.w,
                    height: 24.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RColors.primary,
                        padding: EdgeInsets.zero
                      ),
                        onPressed: (){},
                        child: Text('احجز الآن',
                        style: TextStyle(
                          color: RColors.white ,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold
                        ),)),
                  )
              ,
                Row(
                  children: [
                    const Icon(Icons.attach_money,
                        size: 18, color: Colors.black),
                    Text(
                      price,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}