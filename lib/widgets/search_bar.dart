import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';
import '../utils/helpers/helper_functions.dart';

class searchBar extends StatelessWidget {
  const searchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.search , color: RColors.darkGrey,),
                filled: true,
                hint: Text(
                  RTexts.searchbar ,
                  style: TextStyle(
                      color: RColors.darkerGrey
                  ),
                ) ,

                fillColor: dark ?RColors.primary70 : RColors.white,
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
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      width: 1,
                      color: RColors.primary40,
                    )
                )
            ) ,
          ),
        ) ,
        SizedBox(width: RSizes.defaultSpace*0.8.w,),
        Container(
          margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
          width: 58.w,
          height: 58.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: dark ?RColors.primary70 : RColors.white,
              border: BoxBorder.all(
                  width: 1.w ,
                  color: RColors.grey
              )

          ),
          child: Icon(CupertinoIcons.slider_horizontal_3 , color:RColors.darkerGrey ,),
        )
      ],
    );
  }
}