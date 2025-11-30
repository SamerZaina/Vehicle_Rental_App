import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/drop_down_addvheicle_screen.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/drop_down_label.dart';
import '../../widgets/RAppbar.dart';
import 'package:vehicle_rental_app/utils/constants/brands_models_array.dart';

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
  String? selectedFuel;
  String? selectedVehicleType;

  TextEditingController priceController = TextEditingController();
  TextEditingController seatsController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController(); // New controller for description

  String? selectedImagePath;

  // Search controllers for each dropdown
  TextEditingController brandSearchController = TextEditingController();
  TextEditingController modelSearchController = TextEditingController();
  TextEditingController gearSearchController = TextEditingController();
  TextEditingController colorSearchController = TextEditingController();
  TextEditingController fuelSearchController = TextEditingController();
  TextEditingController vehicleTypeSearchController = TextEditingController();

  final List<String> gearTypes = ['عادي', 'أتوماتيك'];
  final List<String> colors = [
    'أحمر',     // Red
    'أزرق',     // Blue
    'أسود',     // Black
    'أبيض',     // White
    'فضي',      // Silver
    'رمادي',    // Gray
    'أخضر',     // Green
    'برتقالي',  // Orange
    'بنفسجي',   // Purple
    'ذهبي',     // Gold
    'بني',      // Brown
    'زهري',     // Pink
    'كحلي',     // Navy
    'تركوازي',  // Turquoise
    'فيروزي',   // Teal
    'لافندر',   // Lavender
    'ليموني',   // Lemon Yellow
  ];

  final List<String> fuelTypes = ['بنزين', 'ديزل', 'كهرباء', 'هايبرد'];
  final List<String> vehicleTypes = ['سيارة', 'باص', 'دراجة نارية'];

  // Track dropdown open states
  bool isBrandDropdownOpen = false;
  bool isModelDropdownOpen = false;
  bool isGearDropdownOpen = false;
  bool isColorDropdownOpen = false;
  bool isFuelDropdownOpen = false;
  bool isVehicleTypeDropdownOpen = false;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        selectedImagePath = result.files.single.path!;
        imageController.text = result.files.single.name;
      });
    }
  }

  // Get available models based on selected vehicle type and brand
  List<String> getAvailableModels() {
    if (selectedVehicleType == null || selectedBrand == null) {
      return [];
    }
    return BrandsModlesArray().getModels(selectedBrand, selectedVehicleType);
  }

  // Filter list based on search query
  List<String> filterList(List<String> list, String query) {
    if (query.isEmpty) return list;
    return list
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    brandSearchController.dispose();
    modelSearchController.dispose();
    gearSearchController.dispose();
    colorSearchController.dispose();
    fuelSearchController.dispose();
    vehicleTypeSearchController.dispose();
    descriptionController.dispose(); // Dispose the new controller
    super.dispose();
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
            dropdownLabel('اختر نوع السيارة'),
            SizedBox(height: 8.h),
          searchableDropdown(
            items: BrandsModlesArray().brands, // list of brands
            selectedValue: selectedBrand, // currently selected brand
            onSelected: (String value) {
              setState(() {
                selectedBrand = value; // update selected brand
                selectedModel = null; // reset dependent dropdowns
                selectedVehicleType = null;
                isBrandDropdownOpen = false; // close dropdown
                brandSearchController.clear(); // clear search
              });
            },
            searchController: brandSearchController, // search controller
            hintText: 'اختر الماركة', // hint text
            isDropdownOpen: isBrandDropdownOpen, // dropdown open state
            onTap: () {
              setState(() {
                isBrandDropdownOpen = !isBrandDropdownOpen; // toggle dropdown
                if (isBrandDropdownOpen) {
                  // close other dropdowns
                  isModelDropdownOpen = false;
                  isGearDropdownOpen = false;
                  isColorDropdownOpen = false;
                  isFuelDropdownOpen = false;
                  isVehicleTypeDropdownOpen = false;
                }
              });
            },
            refresh: () => setState(() {}), // refresh UI when typing in search
          ),
          SizedBox(height: 20.h),

            /// VEHICLE TYPE DROPDOWN
            dropdownLabel('نوع المركبة'),
            SizedBox(height: 8.h),
        searchableDropdown(
          items: selectedBrand != null
              ? BrandsModlesArray().getVehicleTypesForBrand(selectedBrand!)
              : vehicleTypes, // dynamic list based on selected brand
          selectedValue: selectedVehicleType, // currently selected vehicle type
          onSelected: (String value) {
            setState(() {
              selectedVehicleType = value; // update selected value
              selectedModel = null; // reset dependent dropdown
              isVehicleTypeDropdownOpen = false; // close dropdown
              vehicleTypeSearchController.clear(); // clear search
            });
          },
          searchController: vehicleTypeSearchController, // search controller
          hintText: 'اختر نوع المركبة', // hint text
          isDropdownOpen: isVehicleTypeDropdownOpen, // dropdown open state
          onTap: () {
            setState(() {
              isVehicleTypeDropdownOpen = !isVehicleTypeDropdownOpen; // toggle dropdown
              if (isVehicleTypeDropdownOpen) {
                // close other dropdowns
                isBrandDropdownOpen = false;
                isModelDropdownOpen = false;
                isGearDropdownOpen = false;
                isColorDropdownOpen = false;
                isFuelDropdownOpen = false;
              }
            });
          },
          refresh: () => setState(() {}), // refresh UI when search text changes
        )
        ,
            SizedBox(height: 20.h),

            /// MODEL DROPDOWN
            dropdownLabel('اختر موديل السيارة'),
            SizedBox(height: 8.h),
        searchableDropdown(
          items: getAvailableModels(), // list of available models
          selectedValue: selectedModel, // currently selected model
          onSelected: (String value) {
            setState(() {
              selectedModel = value; // update selected model
              isModelDropdownOpen = false; // close dropdown
              modelSearchController.clear(); // clear search
            });
          },
          searchController: modelSearchController, // search controller
          hintText: 'اختر الموديل', // hint text
          isDropdownOpen: isModelDropdownOpen, // dropdown open state
          onTap: () {
            if (selectedBrand != null && selectedVehicleType != null) {
              setState(() {
                isModelDropdownOpen = !isModelDropdownOpen; // toggle dropdown
                if (isModelDropdownOpen) {
                  // close other dropdowns
                  isBrandDropdownOpen = false;
                  isGearDropdownOpen = false;
                  isColorDropdownOpen = false;
                  isFuelDropdownOpen = false;
                  isVehicleTypeDropdownOpen = false;
                }
              });
            }
          },
          refresh: () => setState(() {}), // refresh UI when typing in search
        )
        ,SizedBox(height: 20.h),

            /// GEAR DROPDOWN
            dropdownLabel('اختر نوع القير'),
            SizedBox(height: 8.h),
        searchableDropdown(
          items: gearTypes, // list of gear types
          selectedValue: selectedGear, // currently selected gear
          onSelected: (String value) {
            setState(() {
              selectedGear = value; // update selected gear
              isGearDropdownOpen = false; // close dropdown
              gearSearchController.clear(); // clear search
            });
          },
          searchController: gearSearchController, // search controller
          hintText: 'اختر نوع القير', // hint text
          isDropdownOpen: isGearDropdownOpen, // dropdown open state
          onTap: () {
            setState(() {
              isGearDropdownOpen = !isGearDropdownOpen; // toggle dropdown
              if (isGearDropdownOpen) {
                // close other dropdowns
                isBrandDropdownOpen = false;
                isModelDropdownOpen = false;
                isColorDropdownOpen = false;
                isFuelDropdownOpen = false;
                isVehicleTypeDropdownOpen = false;
              }
            });
          },
          refresh: () => setState(() {}), // refresh UI when typing in search
        )
        , SizedBox(height: 20.h),

            /// COLOR DROPDOWN
            dropdownLabel('اختر لون السيارة'),
            SizedBox(height: 8.h),
          searchableDropdown(
            items: colors, // your list of colors
            selectedValue: selectedColor, // the currently selected color
            onSelected: (String value) {
              setState(() {
                selectedColor = value; // update selected value
                isColorDropdownOpen = false; // close dropdown
                colorSearchController.clear(); // clear search
              });
            },
            searchController: colorSearchController, // controller for search input
            hintText: 'اختر اللون', // the hint text
            isDropdownOpen: isColorDropdownOpen, // whether the dropdown is open
            onTap: () {
              setState(() {
                isColorDropdownOpen = !isColorDropdownOpen;
                if (isColorDropdownOpen) {
                  // Close other dropdowns
                  isBrandDropdownOpen = false;
                  isModelDropdownOpen = false;
                  isGearDropdownOpen = false;
                  isFuelDropdownOpen = false;
                  isVehicleTypeDropdownOpen = false;
                }
              });
            },
            refresh: () => setState(() {}), // refresh UI when search text changes
          ), SizedBox(height: 20.h),

            /// FUEL DROPDOWN
            dropdownLabel('نوع الوقود'),
            SizedBox(height: 8.h),
        searchableDropdown(
          items: fuelTypes, // list of fuel types
          selectedValue: selectedFuel, // currently selected fuel
          onSelected: (String value) {
            setState(() {
              selectedFuel = value; // update selected fuel
              isFuelDropdownOpen = false; // close dropdown
              fuelSearchController.clear(); // clear search
            });
          },
          searchController: fuelSearchController, // search controller
          hintText: 'اختر نوع الوقود', // hint text
          isDropdownOpen: isFuelDropdownOpen, // dropdown open state
          onTap: () {
            setState(() {
              isFuelDropdownOpen = !isFuelDropdownOpen; // toggle dropdown
              if (isFuelDropdownOpen) {
                // close other dropdowns
                isBrandDropdownOpen = false;
                isModelDropdownOpen = false;
                isGearDropdownOpen = false;
                isColorDropdownOpen = false;
                isVehicleTypeDropdownOpen = false;
              }
            });
          },
          refresh: () => setState(() {}), // refresh UI when typing in search
        )
        ,SizedBox(height: 20.h),

            /// NUMBER OF SEATS
            dropdownLabel('عدد المقاعد'),
            SizedBox(height: 8.h),
            _seatsField(),
            SizedBox(height: 20.h),

            /// PRICE FIELD
            dropdownLabel('السعر بالساعة'),
            SizedBox(height: 8.h),
            _priceField(),
            SizedBox(height: 20.h),

            /// DESCRIPTION FIELD - NEW TEXTFIELD
            dropdownLabel('وصف المركبة'),
            SizedBox(height: 8.h),
            _descriptionField(),
            SizedBox(height: 20.h),

            /// IMAGE PICKER
            dropdownLabel('تحميل صورة المركبة'),
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
                  'اضافة',
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
        selectedFuel != null &&
        selectedVehicleType != null &&
        seatsController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty && // Check description field
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


  /// NUMBER OF SEATS
  Widget _seatsField() {
    return TextFormField(
      controller: seatsController,
      keyboardType: TextInputType.number,
      decoration: _inputDecoration().copyWith(
        hintText: 'مثال: 5',
      ),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  /// PRICE FIELD
  Widget _priceField() {
    return TextFormField(
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: _inputDecoration().copyWith(hintText: 'مثال: 30'),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  /// DESCRIPTION FIELD - NEW TEXTFIELD
  Widget _descriptionField() {
    return TextFormField(
      controller: descriptionController,
      keyboardType: TextInputType.multiline,
      maxLines: 4, // Multiple lines for description
      decoration: _inputDecoration().copyWith(
        hintText: 'أدخل وصف المركبة...',
        alignLabelWithHint: true,
      ),
      style: TextStyle(fontSize: 16.sp),
    );
  }

  /// IMAGE PICKER FIELD
  Widget _imagePickerField() {
    return GestureDetector(
      onTap: pickImage,
      child: AbsorbPointer(
        child: TextFormField(
          controller: imageController,
          decoration: _inputDecoration().copyWith(
            hintText: 'اختر صورة',
            suffixIcon: Icon(Icons.add, color: RColors.primary),
          ),
        ),
      ),
    );
  }

  /// INPUT DECORATION
  InputDecoration _inputDecoration() {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: RColors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: RColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: RColors.primary),
      ),
    );
  }
}