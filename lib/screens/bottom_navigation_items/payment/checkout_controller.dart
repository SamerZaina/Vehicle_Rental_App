import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_rental_app/screens/bottom_navigation_items/payment/PaymentMethodModel.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../widgets/payment_tile.dart';

class CheckoutController extends GetxController{
  static CheckoutController get instance => Get.find();

  final Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;

  @override
  void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(image: RImages.paypal , name: 'Paypal');
   super.onInit();
  }

  Future<dynamic> selectPaymentMethod(BuildContext context){
    return showModalBottomSheet(
        context: context,
        backgroundColor: RColors.primaryBackground,
        builder: (_) => SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(RSizes.lg),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Payment Method",style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: "Inter",fontWeight: FontWeight.w500),),
                SizedBox(height: RSizes.spaceBtwSections,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: RImages.paypal, name: 'PayPal')),
                SizedBox(height: RSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: RImages.paypal, name: 'Google Pay')),
                SizedBox(height: RSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: RImages.paypal, name: 'Apple Pay')),
                SizedBox(height: RSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: RImages.paypal, name: 'VISA')),
                SizedBox(height: RSizes.spaceBtwSections/2,),
                TPaymentTile(paymentMethod: PaymentMethodModel(image: RImages.paypal, name: 'Master Card')),
                SizedBox(height: RSizes.spaceBtwSections/2,),

                TPaymentTile(paymentMethod: PaymentMethodModel(image: RImages.paypal, name: 'Credit Card')),
                SizedBox(height: RSizes.spaceBtwSections/2,),

                SizedBox(height: RSizes.spaceBtwSections,),

              ],
            ),
          ),
        ));
  }

}