
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
Widget mainInfoCard(bool status) {
   const Color kIconColor = Color(0xFF767676);

  return Container(
    decoration: BoxDecoration(
      color: RColors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(color: RColors.borderSecondary),
    ),
    child: Column(
      children: [
        _infoTile(Icons.phone_outlined, "رقم الهاتف", "+970 599 123 456"),
        _divider(),
        _infoTile(Icons.credit_card_outlined, "رخصة الوكالة", "AG123456789"),
        _divider(),
        _infoTile(
          Icons.verified_user_outlined,
          "الحالة",
          status == true ? "مفعل" : "غير مفعل",
          valueColor: status == true ? Colors.green : Colors.red,
        ),
      ],
    ),
  );


}

Widget _divider() {
  return  Divider(
    indent: 20.w,
    endIndent: 20.w,
    color: RColors.borderPrimary,
  );
}

Widget _infoTile(IconData icon, String title, String value, {Color? valueColor}) {
  Color? kIconColor;
  return ListTile(
    leading: Icon(icon, color: kIconColor, size: 26.r),
    title: Text(
      title,
      style:  TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
        color: RColors.textPrimary,
      ),
    ),
    subtitle: Text(
      value,
      style: TextStyle(fontSize: 14.sp, color: valueColor ?? RColors.textSecondary),
    ),
  );
}