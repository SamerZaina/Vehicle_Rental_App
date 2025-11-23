import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/screens/login/forget_password.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/theme/theme.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';

import '../../utils/constants/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark ? RAppbarTheme.darkAppBarTheme(
        actions: [
          CircleAvatar(
            backgroundColor: RColors.primary,
            radius: 30.r,
            child: Image.asset(RImages.facebookIcon),
          ) ,
          
        ]
      )  : RAppbarTheme.lightAppBarTheme(
          actions: [
            Container(
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: CircleAvatar(
                backgroundColor: RColors.primary40,
                radius: 30.r,
                child: Image.asset('assets/images/women.png'),
              ),
            ) ,
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: BoxBorder.all(
                  width: 1.w ,
                  color: RColors.grey
                )
              ),
              width: 40.w,
              height: 40.h,
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Icon(CupertinoIcons.bell ,
                  color: RColors.darkerGrey
              ),
            ) ,
          ]
      ),
      body: SizedBox(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0.h, 25.w, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            width: 1.w
                          )
                        ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          width: 1,
                          color: RColors.grey,
                        )
                      )
                      ) ,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
