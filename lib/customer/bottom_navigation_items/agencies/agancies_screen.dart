import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/widgets/RAppbar.dart';

import '../../../utils/constants/colors.dart';
import 'agancies_items.dart';

class AganciesScreen extends StatefulWidget {
  const AganciesScreen({super.key});

  @override
  State<AganciesScreen> createState() => _AganciesScreenState();
}

class _AganciesScreenState extends State<AganciesScreen> {
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: dark ?RAppbarTheme.darkAppBarTheme(
          leadingWidth: 62.w,
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: BoxBorder.all(
                    width: 1.w ,
                    color: RColors.grey
                )
            ),
            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
            child: IconButton(
              onPressed: (){},
              color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
            ),
          ) ,
          title: Text('المعارض' ,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold
            ),),
          actions: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: BoxBorder.all(
                      width: 1.w ,
                      color: RColors.grey
                  )
              ),
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: IconButton(
                  onPressed: (){},
                  color: RColors.darkerGrey, icon:Icon( CupertinoIcons.search),
              ),
            ) ,
          ]
      ) : RAppbarTheme.lightAppBarTheme(
        leadingWidth: 62.w,
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: BoxBorder.all(
                  width: 1.w ,
                  color: RColors.grey
              )
          ),
          margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
          child: IconButton(
            onPressed: (){},
            color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
          ),
        ) ,
        title: Text('المعارض' ,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontSize:20.sp,
          fontWeight: FontWeight.bold
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(9.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: RColors.darkGrey),
              ),
              child: IconButton(
                icon:  Icon(
                 CupertinoIcons.search,
                  size: 20,
                  color: Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ]
      ) ,
      body:Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                         width: 400.w,
                         height: 135.h,
                         margin: EdgeInsets.fromLTRB(0,3, 0, 0),
                         child: Card(
                           elevation: 1.5,
                             shadowColor: RColors.primary40,
                             color: dark? RColors.black :RColors.white,
                             shape: OutlineInputBorder(
                                 borderRadius: BorderRadius.circular(20),
                                 borderSide: BorderSide(
                                   width: 1.2.w,
                                   color: dark ?RColors.primary40: RColors.grey,
                                 )
                             ),
                           child: Stack(
                             children: [
                               Column(
                                 children: [
                                   Row(
                                     children: [
                                       Container(
                                        margin: EdgeInsets.fromLTRB(0, 7, 3,0) ,
                                         child: GestureDetector(
                                           onTap: ()=> Get.to(AganciesItems()),
                                           child: Card(
                                             shadowColor: RColors.primary,
                                             color:dark ? RColors.darkGrey : RColors.primaryBackground,
                                             elevation: 2,
                                             shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(20.r),
                                               side: BorderSide(
                                                   color: RColors.primary70
                                               ),
                                             ),
                                             child: Padding(
                                               padding: EdgeInsets.all(5.w.h),
                                               child: ClipRRect(
                                                 borderRadius: BorderRadius.circular(20.r),
                                                 child: Image.asset(
                                                  RImages.car2,
                                                   width: 102.w,
                                                   height: 95.h,
                                                   fit: BoxFit.cover,
                                                 ),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                       SizedBox(width: 5.w),
                                       Expanded(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Text(
                                             'اسم المعرض' ,
                                               style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                 fontWeight: FontWeight.bold
                                               )
                                             ),
                                             SizedBox(height: 4.h),
                                             Text(
                                               'مكان المعرض',
                                               style: TextStyle(
                                                 fontWeight: FontWeight.w400,
                                                 fontSize: 16.sp,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   )
                                 ],
                                 )
                             ],
                           ),
                         ),
                       );}


                    ),
            ],
          ),
        ),
      )


    );
  }
}
