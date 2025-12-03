import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class PaymentConfirmation extends StatefulWidget {
  const PaymentConfirmation({super.key});

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),

        child: Column(
        children: [
          SizedBox(
            width: 390.w,
            height: 200.h,
            child: Image.asset(RImages.car4),
            ),
        SizedBox(height: RSizes.defaultSpace,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'مرسيدس موديل 5',
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),),
              ],
            ),
            SizedBox(height: RSizes.spaceBtwItems * 0.5.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'سيارة مرسيدس بسرعة عالية جدا بسعر التوفير من موديل 5 ويجعل محدا حوش',
                    style:Theme.of(context).textTheme.bodyMedium,
                  ),
                ) ,
                SizedBox(width: 20.w,),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.star_fill,size: 15.sp, color: Colors.orange,),
                        SizedBox(width:3.w,),
                        Text('5.2'),
                      ],
                    ),
                    Text('(+100تقييم)' ,
                      style: TextStyle(color: RColors.darkGrey),),

                  ],
                )
              ],),
            SizedBox(height: RSizes.spaceBtwSections,),
            Divider(height: 2.h,thickness: 1.w,color: RColors.grey,),
            SizedBox(height: RSizes.spaceBtwItems,),
            Text(
              'معلومات الحجز',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),),
            // booking info
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle,size: 8,color: RColors.darkGrey,),
                           SizedBox(width: 3,),
                          Text('رقم الحجز' ,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: RColors.darkGrey,
                            fontSize: 14.sp
                          ),),
                        ],
                      ) ,
                      Text('1265' ,
                        style: TextStyle(
                            color: RColors.darkGrey,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems*0.5),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle,size: 8,color: RColors.darkGrey,),
                          SizedBox(width: 3,),
                          Text('الاسم' ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: RColors.darkGrey,
                                fontSize: 14.sp
                            ),),
                        ],
                      ) ,
                      Text('رؤى ابوفول' ,
                        style: TextStyle(
                            color: RColors.darkGrey,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems*0.5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle,size: 8,color: RColors.darkGrey,),
                          SizedBox(width: 3,),
                          Text('تاريخ الاستلام' ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: RColors.darkGrey,
                                fontSize: 14.sp
                            ),),
                        ],
                      ) ,
                      Text('15/11/2025 10:30صباحا' ,
                        style: TextStyle(
                            color: RColors.darkGrey,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems*0.5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle,size: 8,color: RColors.darkGrey,),
                          SizedBox(width: 3,),
                          Text('تاريخ الارجاع' ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: RColors.darkGrey,
                                fontSize: 14.sp
                            ),),
                        ],
                      ) ,
                      Text('15/11/2025 10:30صباحا ',
                        style: TextStyle(
                            color: RColors.darkGrey,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems*0.5),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle,size: 8,color: RColors.darkGrey,),
                          SizedBox(width: 3,),
                          Text('الموقع' ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: RColors.darkGrey,
                                fontSize: 14.sp
                            ),),
                        ],
                      ) ,
                      Text('غزة' ,
                        style: TextStyle(
                            color: RColors.darkGrey,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems,),
                  Divider(height: 2.h,thickness: 1.w,color: RColors.grey,),

                ],


              ),
            ),
            SizedBox(height: RSizes.spaceBtwItems*0.5.h,),
            Text(
              'الدفع',
              style: Theme
                  .of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),),
            // payment info
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('رمز الحجز' ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: RColors.darkGrey,
                            fontSize: 14.sp
                        ),) ,
                      Text('1265' ,
                        style: TextStyle(
                            color: RColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems*0.5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('المبلغ' ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: RColors.darkGrey,
                            fontSize: 14.sp
                        ),) ,
                      Text('145\$' ,
                        style: TextStyle(
                            color: RColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems*0.5,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('رسوم الخدمة' ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: RColors.darkGrey,
                            fontSize: 14.sp
                        ),) ,
                      Text('15\$' ,
                        style: TextStyle(
                            color: RColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp

                        ),) ,

                    ],
                  ),
                  SizedBox(height: RSizes.spaceBtwItems*0.5,) ,
                  Divider(
                    height: 2,
                    thickness: 1,
                    color: RColors.grey,
                    indent:40,
                    endIndent: 40,
                  ) ,
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'المبلغ الاجمالي',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),),
                        Text(
                          '160\$',
                          style: Theme
                              .of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('دفع عبر' ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: RColors.darkGrey,
                            fontSize: 14.sp
                        ),),
                      Image.asset(RImages.paypal, width: 20.w, height: 20.h,)
                    ],
                  )
                ],
              ),
            )
        ],
      )
])
    );
  }
}
