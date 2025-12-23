import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/drop_down_addvheicle_screen.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/drop_down_label.dart';

import '../../utils/constants/image_strings.dart';
import '../../widgets/RAppbar.dart';
import '../controller/add_new_vehicle/brand_controller.dart';
import '../controller/add_new_vehicle/brand_modle_controller.dart';
import '../controller/add_new_vehicle/create_new_vehilce_controller.dart';
import '../controller/add_new_vehicle/fuel_type_controller.dart';
import '../controller/add_new_vehicle/status_controller.dart';
import '../controller/add_new_vehicle/transmission_controller.dart';
import '../controller/add_new_vehicle/vehicle_color_controller.dart';
import '../controller/add_new_vehicle/vehilce_types_controller.dart';
import '../controller/agency_all_vehicles_controller.dart';
import '../model/add_new_vehicle_modles/create_new_vehicle_model.dart';

class AddNewVehicle extends StatefulWidget {
  const AddNewVehicle({super.key});

  @override
  State<AddNewVehicle> createState() => _AddNewVehicleState();
}

class _AddNewVehicleState extends State<AddNewVehicle> {
  String? selectedVehicleType;

  String? selectedBrand;
  int? selectedBrandId;

  String? selectedModel;
  int? selectedModelId;

  String? selectedGear;
  String? selectedColor;
  String? selectedFuel;
  String? selectedStatus;

  final TextEditingController registrationNumberController =
  TextEditingController();
  final TextEditingController seatsController = TextEditingController();
  final TextEditingController doorsController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  String? selectedImagePath;

  /// Search controllers
  final TextEditingController brandSearchController = TextEditingController();
  final TextEditingController modelSearchController = TextEditingController();
  final TextEditingController gearSearchController = TextEditingController();
  final TextEditingController colorSearchController = TextEditingController();
  final TextEditingController fuelSearchController = TextEditingController();
  final TextEditingController stautsSearchController = TextEditingController();
  final TextEditingController vehicleTypeSearchController =
  TextEditingController();

  /// Controllers
  final TransmissionController transmissionController =
  Get.put(TransmissionController());
  final FuelTypeController fuelTypeController =
  Get.put(FuelTypeController());
  final VehicleColorController vehicleColorController =
  Get.put(VehicleColorController());
  final VehicleTypeController vehicleTypeController =
  Get.put(VehicleTypeController());
  final BrandController brandController = Get.put(BrandController());
  final VehicleModelController vehicleModelController =
  Get.put(VehicleModelController());
  final AddNewVehicleController addNewVehicleController =
  Get.put(AddNewVehicleController());
  final VehicleStatusController statusController =
  Get.put(VehicleStatusController());
  final AgencyCarsController agencyCarsController =
  Get.put(AgencyCarsController());

  bool isVehicleTypeDropdownOpen = false;
  bool isBrandDropdownOpen = false;
  bool isModelDropdownOpen = false;
  bool isGearDropdownOpen = false;
  bool isColorDropdownOpen = false;
  bool isFuelDropdownOpen = false;
  bool isStatusDropdownOpen = false;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        selectedImagePath = result.files.single.path!;
        imageController.text = result.files.single.name;
      });
    }
  }

  InputDecoration _inputDecoration(String hint) {
    final dark = RHelperFunctions.isDarkMode(context);

    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 14.sp),
      filled: true,
      fillColor: dark ? Colors.grey.shade900 : Colors.grey.shade100,
      contentPadding:
      EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide:
        BorderSide(color: dark ? Colors.grey.shade700 : Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.4,
        ),
      ),
    );
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
            /// VEHICLE TYPE
            dropdownLabel('نوع المركبة'),
            SizedBox(height: 8.h),
            Obx(() {
              if (vehicleTypeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return searchableDropdown(
                items: vehicleTypeController.carTypes,
                selectedValue: selectedVehicleType,
                onSelected: (value) {
                  setState(() {
                    selectedVehicleType = value;
                    selectedBrand = null;
                    selectedBrandId = null;
                    selectedModel = null;
                    selectedModelId = null;
                    isVehicleTypeDropdownOpen = false;
                  });
                  brandController.fetchBrands(value);
                },
                searchController: vehicleTypeSearchController,
                hintText: 'اختر نوع المركبة',
                isDropdownOpen: isVehicleTypeDropdownOpen,
                onTap: () => setState(() =>
                isVehicleTypeDropdownOpen = !isVehicleTypeDropdownOpen),
                refresh: () => setState(() {}),
              );
            }),
            SizedBox(height: 20.h),

            /// BRAND
            dropdownLabel('اختر الماركة'),
            SizedBox(height: 8.h),
            Obx(() {
              if (brandController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return searchableDropdown(
                items: brandController.brands.map((e) => e.name).toList(),
                selectedValue: selectedBrand,
                onSelected: (value) {
                  final brand = brandController.brands
                      .firstWhere((b) => b.name == value);

                  setState(() {
                    selectedBrand = brand.name;
                    selectedBrandId = brand.id;
                    selectedModel = null;
                    selectedModelId = null;
                    isBrandDropdownOpen = false;
                  });

                  vehicleModelController.fetchModels(
                    selectedVehicleType!,
                    brand.id,
                  );
                },
                searchController: brandSearchController,
                hintText: 'اختر الماركة',
                isDropdownOpen: isBrandDropdownOpen,
                onTap: () =>
                    setState(() => isBrandDropdownOpen = !isBrandDropdownOpen),
                refresh: () => setState(() {}),
              );
            }),
            SizedBox(height: 20.h),

            /// MODEL
            dropdownLabel('اختر الموديل'),
            SizedBox(height: 8.h),
            Obx(() {
              if (vehicleModelController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return searchableDropdown(
                items: vehicleModelController.models.map((e) => e.name).toList(),
                selectedValue: selectedModel,
                onSelected: (value) {
                  final model = vehicleModelController.models
                      .firstWhere((m) => m.name == value);

                  setState(() {
                    selectedModel = model.name;
                    selectedModelId = model.id;
                    isModelDropdownOpen = false;
                  });
                },
                searchController: modelSearchController,
                hintText: 'اختر الموديل',
                isDropdownOpen: isModelDropdownOpen,
                onTap: () =>
                    setState(() => isModelDropdownOpen = !isModelDropdownOpen),
                refresh: () => setState(() {}),
              );
            }),
            SizedBox(height: 20.h),

            /// TRANSMISSION
            dropdownLabel('نوع القير'),
            searchableDropdown(
              items: transmissionController.transmissions,
              selectedValue: selectedGear,
              onSelected: (value) {
                setState(() {
                  selectedGear = value;
                  isGearDropdownOpen = false;
                });
              },
              searchController: gearSearchController,
              hintText: 'اختر نوع القير',
              isDropdownOpen: isGearDropdownOpen,
              onTap: () =>
                  setState(() => isGearDropdownOpen = !isGearDropdownOpen),
              refresh: () => setState(() {}),
            ),
            SizedBox(height: 20.h),

            /// COLOR
            dropdownLabel('لون المركبة'),
            searchableDropdown(
              items: vehicleColorController.colors,
              selectedValue: selectedColor,
              onSelected: (value) {
                setState(() {
                  selectedColor = value;
                  isColorDropdownOpen = false;
                });
              },
              searchController: colorSearchController,
              hintText: 'اختر اللون',
              isDropdownOpen: isColorDropdownOpen,
              onTap: () =>
                  setState(() => isColorDropdownOpen = !isColorDropdownOpen),
              refresh: () => setState(() {}),
            ),
            SizedBox(height: 20.h),

            /// FUEL
            dropdownLabel('نوع الوقود'),
            searchableDropdown(
              items: fuelTypeController.fuelTypes,
              selectedValue: selectedFuel,
              onSelected: (value) {
                setState(() {
                  selectedFuel = value;
                  isFuelDropdownOpen = false;
                });
              },
              searchController: fuelSearchController,
              hintText: 'اختر نوع الوقود',
              isDropdownOpen: isFuelDropdownOpen,
              onTap: () =>
                  setState(() => isFuelDropdownOpen = !isFuelDropdownOpen),
              refresh: () => setState(() {}),
            ),
            SizedBox(height: 20.h),


            /// status
            dropdownLabel('الحالة'),
            searchableDropdown(
              items: statusController.statusList,
              selectedValue: selectedStatus,
              onSelected: (value) {
                setState(() {
                  selectedStatus = value;
                  isStatusDropdownOpen = false;
                });
              },
              searchController: fuelSearchController,
              hintText: 'فعالة - غير فعالة',
              isDropdownOpen: isStatusDropdownOpen,
              onTap: () =>
                  setState(() => isStatusDropdownOpen = !isStatusDropdownOpen),
              refresh: () => setState(() {}),
            ),
            SizedBox(height: 20.h),



            /// REGISTRATION NUMBER
            dropdownLabel('رقم التسجيل'),
            TextFormField(
              controller: registrationNumberController,
              style: TextStyle(fontSize: 14.sp),
              decoration: _inputDecoration('مثال: 123-ABC'),
            ),
            SizedBox(height: 20.h),

            /// SEATS
            dropdownLabel('عدد المقاعد'),
            TextFormField(
              controller: seatsController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 14.sp),
              decoration: _inputDecoration('مثال: 5'),
            ),
            SizedBox(height: 20.h),

            /// Doors
            dropdownLabel('عدد الأبواب'),
            TextFormField(
              controller: doorsController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 14.sp),
              decoration: _inputDecoration('مثال: 4'),
            ),
            SizedBox(height: 20.h),

            /// PRICE
            dropdownLabel('السعر بالساعة'),
            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 14.sp),
              decoration: _inputDecoration('مثال: 50'),
            ),
            SizedBox(height: 20.h),

            /// DESCRIPTION
            dropdownLabel('وصف المركبة'),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              style: TextStyle(fontSize: 14.sp),
              decoration: _inputDecoration('أدخل وصف المركبة'),
            ),
            SizedBox(height: 20.h),

            /// IMAGE
            dropdownLabel('صورة المركبة'),
            GestureDetector(
              onTap: pickImage,
              child: AbsorbPointer(
                child: TextFormField(
                  controller: imageController,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: _inputDecoration('اختر صورة المركبة').copyWith(
                    prefixIcon: Icon(
                      Icons.add_circle_outline,
                      size: 22.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40.h),


            /// BUTTON
            SizedBox(
              height: 50.h,
              child: Obx(() {
                return ElevatedButton(
                  onPressed: addNewVehicleController.isLoading.value ? null : _saveVehicle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: addNewVehicleController.isLoading.value
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                  child: addNewVehicleController.isLoading.value
                      ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                      : Text(
                    'إضافة المركبة',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _saveVehicle() async {
    // Remove image requirement since API might accept vehicles without images
    if (selectedVehicleType == null ||
        selectedBrandId == null ||
        selectedModelId == null ||
        selectedGear == null ||
        selectedColor == null ||
        selectedFuel == null ||
        selectedStatus == null ||
        registrationNumberController.text.isEmpty ||
        seatsController.text.isEmpty ||
        doorsController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'الرجاء ملء جميع الحقول المطلوبة',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Show loading
    addNewVehicleController.isLoading.value = true;

    try {
      final vehicle = CreateVehicleModel(
        modelId: selectedModelId!,
        transmission: selectedGear!,
        color: selectedColor!,
        fuelType: selectedFuel!,
        status: selectedStatus!,
        registrationNumber: registrationNumberController.text.trim(),
        seats: int.tryParse(seatsController.text.trim()) ?? 0,
        doors: int.tryParse(doorsController.text.trim()) ?? 0,
        pricePerHour: double.tryParse(priceController.text.trim()) ?? 0.0,
        description: descriptionController.text.trim(),
        images: selectedImagePath != null ? [File(selectedImagePath!)] : null,
      );

      final success = await addNewVehicleController.addNewVehicle(vehicle);

      if (success) {
        // Success snackbar
        Get.snackbar(
          'تمت الاضافة !',
          'تم اضافة المركبة بنجاح',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
          icon: Icon(Icons.check_circle, color: Colors.white),
        );

        // here we make get request to add the vehicle which we already added
        // to myVehicle list of the agency
        agencyCarsController.fetchAgencyCars();
        // Wait a bit before going back to show the snackbar
        await Future.delayed(Duration(milliseconds: 1500));

        /// Return success to previous screen
        Get.back(result: true);

      }
      // If not success, error snackbar is already shown in controller
    } catch (e) {
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء الحفظ: $e',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      addNewVehicleController.isLoading.value = false;
    }
  }


  Widget _leadingButton() => IconButton(
    icon: const Icon(CupertinoIcons.left_chevron),
    onPressed: () => Get.back(),
  );

  Widget _title() =>
      Text('إضافة مركبة جديدة', style: TextStyle(fontSize: 20.sp));
}
