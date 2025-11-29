import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import '../../widgets/RAppbar.dart';

class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({super.key});

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  String? selectedBrand;
  String? selectedModel;
  String? selectedGear;
  String? selectedColor;
  TextEditingController priceController = TextEditingController();
  String? selectedImagePath;
  TextEditingController imageController = TextEditingController();

  final Map<String, List<String>> brandModels = {
    'بي ام دبيلو': ['X1', 'X3', 'X5', 'i8'],
    'مارسيدس': ['A-Class', 'C-Class', 'E-Class', 'S-Class'],
    'فورد': ['Focus', 'Mustang', 'Explorer'],
    'تويوتا': ['Corolla', 'Camry', 'Land Cruiser'],
  };

  final List<String> gearTypes = ['عادي', 'أتوماتيك'];
  final List<String> colors = ['أحمر', 'أزرق', 'أسود', 'أبيض', 'فضي'];

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        selectedImagePath = result.files.single.path!;
        imageController.text = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: dark
          ? RAppbarTheme.darkAppBarTheme(
        leadingWidth: 62.w,
        leading: _leadingButton(),
        title: _title(),
      )
          : RAppbarTheme.lightAppBarTheme(
        leadingWidth: 62.w,
        leading: _leadingButton(),
        title: _title(),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          children: [
            /// BRAND DROPDOWN
            _dropdownLabel('اختر نوع السيارة'),
            SizedBox(height: 8.h),
            _brandDropdown(),
            SizedBox(height: 20.h),

            /// MODEL DROPDOWN
            _dropdownLabel('اختر موديل السيارة'),
            SizedBox(height: 8.h),
            _modelDropdown(),
            SizedBox(height: 20.h),

            /// GEAR DROPDOWN
            _dropdownLabel('اختر نوع القير'),
            SizedBox(height: 8.h),
            _gearDropdown(),
            SizedBox(height: 20.h),

            /// COLOR DROPDOWN
            _dropdownLabel('اختر لون السيارة'),
            SizedBox(height: 8.h),
            _colorDropdown(),
            SizedBox(height: 20.h),

            /// PRICE FIELD
            _dropdownLabel('السعر بالساعة'),
            SizedBox(height: 8.h),
            _priceField(),
            SizedBox(height: 20.h),

            /// IMAGE PICKER
            _dropdownLabel('تحميل صورة المركبة'),
            SizedBox(height: 8.h),
            _imagePickerField(),
            SizedBox(height: 40.h),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveVehicle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: RColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'حفظ',
                  style: TextStyle(fontSize: 18.sp, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  void _saveVehicle() {
    if (selectedBrand != null &&
        selectedModel != null &&
        selectedGear != null &&
        selectedColor != null &&
        priceController.text.isNotEmpty &&
        selectedImagePath != null) {
      Get.snackbar(
        "نجاح",
        "تم إضافة: $selectedBrand $selectedModel",
        backgroundColor: RColors.primary,
        colorText: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        duration: const Duration(seconds: 2),
        borderRadius: 12,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "تنبيه",
        "الرجاء ملء جميع الحقول",
        backgroundColor: RColors.primary,
        colorText: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        duration: const Duration(seconds: 2),
        borderRadius: 12,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// AppBar Leading Button
  Widget _leadingButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(width: 1.w, color: RColors.grey),
      ),
      margin: EdgeInsets.only(right: 5.w),
      child: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(CupertinoIcons.left_chevron),
        color: RColors.darkerGrey,
      ),
    );
  }

  /// AppBar Title
  Widget _title() {
    return Text(
      'إضافة مركبة جديدة',
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: RColors.primary,
      ),
    );
  }

  /// Label
  Widget _dropdownLabel(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
    );
  }

  /// BRAND
  Widget _brandDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedBrand,
      items: brandModels.keys
          .map((brand) => DropdownMenuItem(value: brand, child: Text(brand)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedBrand = value;
          selectedModel = null;
        });
      },
      decoration: _inputDecoration(),
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
    );
  }

  /// MODEL
  Widget _modelDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedModel,
      items: selectedBrand == null
          ? []
          : brandModels[selectedBrand]!
          .map((model) => DropdownMenuItem(value: model, child: Text(model)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedModel = value;
        });
      },
      decoration: _inputDecoration(),
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
    );
  }

  /// GEAR
  Widget _gearDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedGear,
      items: gearTypes
          .map((gear) => DropdownMenuItem(value: gear, child: Text(gear)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedGear = value;
        });
      },
      decoration: _inputDecoration(),
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
    );
  }

  /// COLOR
  Widget _colorDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedColor,
      items: colors
          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedColor = value;
        });
      },
      decoration: _inputDecoration(),
      style: TextStyle(fontSize: 16.sp, color: Colors.black),
    );
  }

  /// PRICE FIELD
  Widget _priceField() {
    return TextFormField(
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "أدخل السعر بالساعة",
        hintStyle: TextStyle(color: RColors.primary40, fontSize: 16.sp),
        filled: true,
        fillColor: RColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: RColors.grey, width: 0.8.w),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  /// IMAGE PICKER
  Widget _imagePickerField() {
    return TextFormField(
      controller: imageController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: "اختر صورة المركبة",
        hintStyle: TextStyle(color: RColors.primary40, fontSize: 16.sp),
        filled: true,
        fillColor: RColors.white,
        prefixIcon: IconButton(
          icon: Icon(CupertinoIcons.add_circled, color: RColors.primary40),
          onPressed: pickImage,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: RColors.grey, width: 0.8.w),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  /// Input Decoration
  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: RColors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: RColors.grey, width: 0.8.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: RColors.grey, width: 0.8.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: RColors.primary40, width: 0.8.w),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
    );
  }
}
