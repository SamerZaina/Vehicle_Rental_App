import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/payment/checkout_controller.dart';
import 'package:vehicle_rental_app/utils/constants/sizes.dart';
import 'package:vehicle_rental_app/utils/validators/validation.dart';
import 'package:vehicle_rental_app/widgets/login_text_fields.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/theme/custom_themes/text_theme.dart';
import 'PaymentMethodModel.dart';

class PaymentDetailsContainer extends StatefulWidget {
  const PaymentDetailsContainer({super.key});

  @override
  State<PaymentDetailsContainer> createState() =>
      _PaymentDetailsContainerState();
}

class _PaymentDetailsContainerState extends State<PaymentDetailsContainer> {
  String selectedMethod = "cod";
  final cardController = TextEditingController();
  late final PaymentMethodModel paymentMethod;
  final checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Image.asset(RImages.visaCard, width: 400),
          _buildCustomRadioTile(
            value: "card",
            groupValue: selectedMethod,
            title: "بطاقة ائتمانية",
            leadingIcon: Iconsax.card,
            expandChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 19.h),
                Row(
                  children: [
                    SizedBox(width: 17.h),
                    Text(
                      "طريقة الدفع",
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 83.h),
                    Container(
                      width: 80.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        // color: Color(0xffD9D9D9),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        //  checkoutController.selectPaymentMethod(context),
                        child: Text(
                          "تغيير",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: RColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: RSizes.spaceBtwItems / 2),
                Obx(
                      () =>
                      Row(
                        children: [
                          SizedBox(width: 17.w),
                          Image(
                            image: AssetImage(
                              checkoutController.selectedPaymentMethod.value
                                  .image,
                            ),
                            fit: BoxFit.contain,
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(width: 14.w),
                          Text(
                            checkoutController.selectedPaymentMethod.value.name,
                            style: TextStyle(
                                fontSize: 16.sp, color: Colors.black),
                          ),
                          SizedBox(width: 30.w),
                        ],
                      ),
                ),
                SizedBox(height: 13.h),
                Center(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: 300.w,
                      height: 47.h,
                      decoration: BoxDecoration(
                        color: RColors.primary40,
                        border: Border.all(color: RColors.primary40),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 17.w),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return add_card_dialog();
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                color: Colors.white,
                              ),
                              width: 31.w,
                              height: 31.h,
                              child: Icon(
                                Icons.add_circle_outline,
                                color: RColors.primary,
                                size: 25.r,
                              ),
                            ),
                          ),
                          SizedBox(width: 25),
                          Text(
                            "اضافة بطاقة",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 14.h),
          _buildCustomRadioTile(
            value: "net",
            groupValue: selectedMethod,
            title: "بنوك محلية",
            leadingIcon: Iconsax.bank,
          ),
          SizedBox(height: 150.h,)
        ],
      ),
    );
  }

  Widget _buildCustomRadioTile({
    required String value,
    required String groupValue,
    required String title,
    IconData? leadingIcon,

    Widget? expandChild,
  }) {
    bool isSelected = value == groupValue;
    final dark = RHelperFunctions.isDarkMode(context);
    return Card(
      elevation: 4,
      shadowColor: dark ? RColors.primary40 : RColors.primary,
      child: Container(
        width: 342.w,
        // margin: const EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: dark ? RColors.primary40 : Colors.white,
          borderRadius: BorderRadius.circular(11.r),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedMethod = value;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  child: Row(
                    children: [
                      // Custom radio circle
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? RColors.primary
                                : Color(0xFFB2ADAD),
                            width: 1,
                          ),
                          color: isSelected
                              ? RColors.primary
                              : Colors.transparent,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      if (leadingIcon != null)
                        Icon(leadingIcon, color: RColors.primary, size: 32.r),

                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: dark ? RColors.white : Colors.black,
                          ),
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 23.r,
                        color: RColors.primary40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Expansion if selected
            if (isSelected && expandChild != null) expandChild,
          ],
        ),
      ),
    );
  }
}

class add_card_dialog extends StatelessWidget {
   add_card_dialog({
    super.key,
  });
  bool save = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return AlertDialog(

        backgroundColor: RColors
            .primaryBackground,
        content: SizedBox(
          height: 500.h,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
          Row(
            children: [
              SizedBox(width: 15.w),
              Icon(Iconsax.card,
                  size: 32.r,
                  color: RColors.primary),
              SizedBox(width: 12.w),
              Text("البطاقة",
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: dark
                          ? RColors.white
                          : RColors.primary))
            ],
          ),
          SizedBox(height: 12.h),
          Container(
              width: 300.w,
              height: 1.h,
              color: RColors.primary40),
          SizedBox(height: 30.h),

          SizedBox(
            width: 295.w,
            height: 340.h,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text("اسم صاحب البطاقة",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: dark
                            ? RColors.white
                            : Colors.black)),
                SizedBox(height: RSizes.spaceBtwItems.h),
                SizedBox(
                  width: 295.w,
                  height: 32.h,
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) =>
                    value == null ||
                        value.isEmpty
                        ? 'الرجاء ادخال الاسم'
                        : null,
                    style: TextStyle(fontSize: 20.sp),
                    decoration: InputDecoration(
                      enabledBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                            6.r),
                        borderSide: BorderSide(
                            color:
                            RColors.primary40,
                            width: 1.5.w),
                      ),
                      focusedBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                            6.r),
                        borderSide: BorderSide(
                            color:
                            RColors.primary,
                            width: 2.w),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15.w, top: 14.h, bottom: 14.h),
                      hintText: "ادخل اسمك",
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: dark
                              ? RColors.primary
                              : RColors
                              .primary40),
                      filled: true,
                      fillColor: dark
                          ? RColors.white
                          .withOpacity(0.2)
                          : Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: 23.h),

                Text("رقم البطاقة",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: dark
                            ? RColors.white
                            : Colors.black)),
                SizedBox(height: RSizes.spaceBtwItems.h),
                SizedBox(
                  width: 295.w,
                  height: 32.h,
                  child: TextFormField(
                    controller:
                    _numberController,
                    keyboardType:
                    TextInputType.number,
                    validator: (value) =>
                    value == null ||
                        value.length < 16
                        ? 'الرجاء ادخال رقم صالح'
                        : null,
                    style: TextStyle(fontSize: 20.sp),
                    decoration: InputDecoration(
                      enabledBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                            6.r),
                        borderSide: BorderSide(
                            color:
                            RColors.primary40,
                            width: 1.5.w),
                      ),
                      focusedBorder:
                      OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(
                            6.r),
                        borderSide: BorderSide(
                            color:
                            RColors.primary,
                            width: 2.w),
                      ),
                      contentPadding: EdgeInsets.only(
                          left: 15.w, top: 14.h, bottom: 14.h),
                      hintText:
                      "1234 5678 9101 22592",
                      hintStyle: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14.sp,
                          color: dark
                              ? RColors.primary
                              : RColors
                              .primary40),
                      filled: true,
                      fillColor: dark
                          ? RColors.white
                          .withOpacity(0.2)
                          : Colors.white,
                    ),
                  ),
                ),

                SizedBox(height: RSizes.spaceBtwItems.h),

                Row(
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text("تاريخ الانتهاء",
                            style: TextStyle(
                                fontSize:
                                14.sp,
                                color: dark
                                    ? RColors
                                    .white
                                    : Colors
                                    .black)),
                        SizedBox(height: RSizes.spaceBtwItems.h),

                        SizedBox(
                          width: 129,
                          height: 32,
                          child:
                          TextFormField(
                            controller:
                            _expiryController,
                            keyboardType:
                            TextInputType
                                .number,
                            validator: (value) => RValidator.validateExpiryDate(value),
                            style: TextStyle(
                                fontSize:
                                20.sp),
                            decoration:
                            InputDecoration(
                              enabledBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    6.r),
                                borderSide:
                                BorderSide(
                                    color: RColors
                                        .primary40,
                                    width:
                                    1.5.w),
                              ),
                              focusedBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    6.r),
                                borderSide:
                                BorderSide(
                                    color:
                                    RColors.primary,
                                    width:
                                    2.w),
                              ),
                              contentPadding: EdgeInsets.only(
                                  left: 15.w,
                                  top: 14.h,
                                  bottom: 14.h),
                              hintText:
                              "02/2028",
                              hintStyle: TextStyle(
                                  fontSize:
                                  14.sp,
                                  color: dark
                                      ? RColors
                                      .primary
                                      : RColors
                                      .primary40),
                              filled: true,
                              fillColor: dark
                                  ? RColors
                                  .white
                                  .withOpacity(
                                  0.2)
                                  : Colors
                                  .white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10.w),

                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text("CVV",
                            style: TextStyle(
                                fontSize:
                                14.sp,
                                color: dark
                                    ? RColors
                                    .white
                                    : Colors
                                    .black)),
                        SizedBox(
                            height: 20.h),
                        SizedBox(
                          width: 129.w,
                          height: 37.w,
                          child:
                          TextFormField(

                            controller:
                            _cvvController,
                            keyboardType:
                            TextInputType
                                .number,
                            validator: (value) =>RValidator.validateCvv(value),
                            style: TextStyle(
                                fontSize:
                                20.sp),
                            decoration:
                            InputDecoration(
                              enabledBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    6.r),
                                borderSide:
                                BorderSide(
                                    color: RColors
                                        .primary40,
                                    width:
                                    1.5.w),
                              ),
                              focusedBorder:
                              OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(
                                    6.r),
                                borderSide:
                                BorderSide(
                                    color:
                                    RColors.primary,
                                    width:
                                    2.w),
                              ),
                              contentPadding: EdgeInsets
                                  .symmetric(vertical: 12.h,
                                  horizontal: 15.w),
                              hintText:
                              "...",
                              hintStyle: TextStyle(
                                  fontFamily:
                                  "Inter",
                                  fontSize:
                                  14.sp,
                                  color: dark
                                      ? RColors
                                      .primary
                                      : RColors
                                      .primary40),
                              filled: true,
                              fillColor: dark
                                  ? RColors
                                  .white
                                  .withOpacity(
                                  0.2)
                                  : Colors
                                  .white,
                            ),
                          ),
                        ),
                        SizedBox(height: 0,)
                      ],
                    )
                  ],
                ),

                SizedBox(height: 15.h),

                Row(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [
                    Transform.scale(
                      scale: 0.9,
                      child: Checkbox(
                          materialTapTargetSize:
                          MaterialTapTargetSize
                              .shrinkWrap,
                          visualDensity:
                          VisualDensity(
                              horizontal:
                              -4.w,
                              vertical:
                              -4.h),
                          checkColor:
                          Colors.white,
                          activeColor:
                          RColors.primary,
                          side: BorderSide(
                            color: RColors
                                .primary40,
                            width: 1.5.w,
                          ),
                          value: save,
                          onChanged: (value) {

                          }),
                    ),
                    const SizedBox(width: 0),
                    Text(
                        "احفظ البطاقة لتمكين الدفع السريع لاحقا",
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: Color(
                                0xFFB2ADAD))),
                  ],
                ) ,
              ],
            ),
          ) ,
                ],
              ),
            ),
              //SizedBox(height: RSizes.spaceBtwItems.h),
              SizedBox(
                width: 400.w,
                height: 50.h,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(30.r)),
                backgroundColor: RColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                ),
                onPressed: () {
                if (_formKey.currentState!
                          .validate()) {
                if (!save) {
                        return;
                }
                        /*  Loaders.warningSnackBar(
                title:
                'Checkbox Required',
                message:
                'Please agree to save the card to proceed');
                return;*/
                }

                /*if (subtotal > 0) {
                orderController
                          .processOrder(
                totalAmount);
                } else {
                Loaders.warningSnackBar(
                title:
                'Empty Cart',
                message:
                'Add items in the cart in order to proceed');
                }
                } else {
                Loaders.warningSnackBar(
                title:
                'Validation Error',
                message:
                'Please fill all fields properly');
                }*/
                },
                child: Text("ادفع الان",
                style: TextStyle(
                fontSize: 16.sp,
                  fontWeight: FontWeight.bold
                ),
                ),
              ),
              ),
                  ]
              ),
        )
    ,
    );
  }
}
