import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vehicle_rental_app/utils/constants/colors.dart';
import 'package:vehicle_rental_app/utils/constants/image_strings.dart';
import 'package:vehicle_rental_app/utils/refactor_widget/current_rental_vehicle_card.dart';

class CurrentRentalVehicle extends StatefulWidget {
  const CurrentRentalVehicle({super.key});

  @override
  State<CurrentRentalVehicle> createState() => _CurrentRentalVehicleState();
}

class _CurrentRentalVehicleState extends State<CurrentRentalVehicle> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  // Sample data for rented vehicles by date
  final Map<String, List<Map<String, String>>> _rentedVehicles = {
    '2025-11-15': [
      {
        'image': RImages.car3,
        'name': "بي ام دبليو M3",
        'renter': "أحمد محمد",
        'date': "من 12:00 إلى 14:00",
      },
      {
        'image': RImages.car1,
        'name': "مرسيدس GLE",
        'renter': "علي سالم",
        'date': "من 08:00 إلى 22:00",
      },
      {
        'image': RImages.car2,
        'name': "مرسيدس بنز",
        'renter': "سامر سالم",
        'date': "من 10:00 إلى 22:00",
      },
    ],
    '2025-12-16': [
      {
        'image': RImages.car1,
        'name': "مرسيدس GLE",
        'renter': "فاطمة علي",
        'date': "من 10:00 إلى 18:00",
      },
    ],
    '2025-11-17': [
      {
        'image': RImages.car2,
        'name': "بي ام دبليو M3",
        'renter': "محمد خالد",
        'date': "من 09:00 إلى 16:00",
      },
      {
        'image': RImages.car1,
        'name': "مرسيدس GLE",
        'renter': "سارة أحمد",
        'date': "من 14:00 إلى 20:00",
      },
    ],
    '2025-11-24': [
      {
        'image': RImages.car2,
        'name': "بي ام دبليو M3",
        'renter': "يوسف محمد",
        'date': "من 11:00 إلى 15:00",
      },
    ],
  };

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  List<Map<String, String>> _getRentedVehiclesForSelectedDate() {
    final dateKey = _formatDate(_selectedDate);
    return _rentedVehicles[dateKey] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final rentedVehicles = _getRentedVehiclesForSelectedDate();

    return Column(
      children: [
        // Calendar Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تقويم الحجوزات',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: RColors.primary,
                ),
              ),
              Text(
                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: RColors.darkerGrey,
                ),
              ),
            ],
          ),
        ),

        // Calendar
        Container(
          margin: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: RColors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TableCalendar(
            firstDay: DateTime.now().subtract(const Duration(days: 365)),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDate,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDate = focusedDay;
            },

            // Calendar styling to match your app theme
            calendarStyle: CalendarStyle(
              // Selected day style
              selectedDecoration: BoxDecoration(
                color: RColors.primary,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),

              // Today style
              todayDecoration: BoxDecoration(
                color: RColors.primary.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(color: RColors.primary),
              ),
              todayTextStyle: TextStyle(
                color: RColors.primary,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),

              // Default day style
              defaultTextStyle: TextStyle(
                color: RColors.darkerGrey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),

              // Weekend style
              weekendTextStyle: TextStyle(
                color: RColors.darkerGrey.withOpacity(0.7),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),

              // Outside days style
              outsideTextStyle: TextStyle(
                color: RColors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),

              // Cell padding
              cellPadding: EdgeInsets.all(8.w),
            ),

            // Header styling
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                color: RColors.primary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: RColors.primary,
                size: 24.sp,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: RColors.primary,
                size: 24.sp,
              ),
              headerPadding: EdgeInsets.symmetric(vertical: 15.h),
            ),

            // Days of the week styling
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: RColors.darkerGrey,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: TextStyle(
                color: RColors.darkerGrey.withOpacity(0.7),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Calendar builders for custom day content
            calendarBuilders: CalendarBuilders(
              // Mark days that have rentals
              markerBuilder: (context, date, events) {
                final dateKey = _formatDate(date);
                if (_rentedVehicles.containsKey(dateKey)) {
                  return Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: RColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            // Localization for Arabic
            locale: 'ar',
            startingDayOfWeek: StartingDayOfWeek.saturday,
            availableCalendarFormats: const {CalendarFormat.month: 'شهر'},
          ),
        ),

        // Rental vehicles list for selected date
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header for rentals list
                Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: Text(
                    'المركبات المستأجرة في ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: RColors.darkerGrey,
                    ),
                  ),
                ),

                // Rental vehicles list
                Expanded(
                  child: rentedVehicles.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.car_rental,
                          size: 60.sp,
                          color: RColors.grey,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'لا توجد حجوزات في هذا اليوم',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: RColors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    itemCount: rentedVehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = rentedVehicles[index];
                      return Column(
                        children: [
                          rentedCarCard(
                            image: vehicle['image']!,
                            name: vehicle['name']!,
                            renter: vehicle['renter']!,
                            date: vehicle['date']!,
                          ),
                          if (index < rentedVehicles.length - 1)
                            SizedBox(height: 15.h),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}