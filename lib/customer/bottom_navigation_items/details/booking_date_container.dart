import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:vehicle_rental_app/utils/formatters/formatters.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class BookingDateContainer extends StatefulWidget {
  const BookingDateContainer({super.key, required this.onTimeSelected, required this.onDateSelected});
  final Function(bool) onTimeSelected;
  final Function(bool) onDateSelected;
  @override
  State<BookingDateContainer> createState() => _BookingDateContainerState();
}

class _BookingDateContainerState extends State<BookingDateContainer> {
  DateTime pickUpDate = DateTime.now();
  DateTime returnDate = DateTime.now().add(const Duration(days: 1));

  TimeOfDay pickUpTime = const TimeOfDay(hour: 10, minute: 30);
  TimeOfDay returnTime = const TimeOfDay(hour: 17, minute: 30);

  bool timeSelected = false; //
  bool dateSelected = false;

  List<DateTime> bookedDates = [
    DateTime(2025, 11, 27),
    DateTime(2025, 11, 30),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('تاريخ ووقت الإيجار' ,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,),),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: RSizes.spaceBtwItems),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.white,
            ),
            child: Row(
              children: [
                // ------------------ Pick Up Date ------------------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "تاريخ الحجز",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          "${pickUpDate.day} / ${pickUpDate.month} / ${pickUpDate.year}",
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),

                // ------------------ Divider ------------------
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  width: 1,
                  height: 30,
                  color: Colors.grey.shade300,
                ),

                // ------------------ Return Date ------------------
                Expanded(
                  child: InkWell(
                    onTap: () async {

                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "تاريخ الارجاع",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              "${returnDate.day} / ${returnDate.month} / ${returnDate.year}",
                              style: const TextStyle(fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [

                Row(
                  children: [

                    Expanded(
                      child: InkWell(
                        onTap:_pickTimeRange,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: RColors.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.access_time, size: 16, color: Colors.white),
                              const SizedBox(width: 6),
                              Text(
                                RFormatter.formatTime(pickUpTime),
                                style: const TextStyle(color: Colors.white, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.access_time, size: 16, color: Colors.black54),
                            const SizedBox(width: 6),
                            Text(
                              RFormatter.formatTime(returnTime),
                              style: const TextStyle(color: Colors.black87, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: RSizes.spaceBtwItems,),
                SfDateRangePicker(
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    blackoutDates: bookedDates ,
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    blackoutDatesDecoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    blackoutDateTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  headerStyle: const DateRangePickerHeaderStyle(
                    backgroundColor:RColors.white,
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selectableDayPredicate: (date){
                    return !bookedDates.any(
                            (d)=>
                        d.year == date.year &&
                            d.month == date.month &&
                            d.day == date.day
                    );
                  },
                  backgroundColor: RColors.white,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(pickUpDate, returnDate),
                  onSelectionChanged: _onDateRangeChanged,
                  startRangeSelectionColor: RColors.primary,
                  endRangeSelectionColor: RColors.primary,
                  rangeSelectionColor: RColors.primary.withOpacity(0.2),
                  todayHighlightColor: Color(0xFF2962FF),

                  selectionTextStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  rangeTextStyle: const TextStyle(
                    color: Color(0xFF2962FF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 5,
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red
                        ),
                      ) ,
                      Text('محجوز')
                    ],
                  ),
                ),

              ],
            ),
          ),
          Center(
            child: Container(
              width: 350.w,
              padding: const EdgeInsets.all(15.0),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: RColors.primary70.withOpacity(0.2)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('سعر الساعة :',
                        style: TextStyle(
                            color: RColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp
                        ),
                      ),
                      Text('  30\$',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ساعات الحجز :',
                        style: TextStyle(
                            color: RColors.primary,

                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp
                        ),
                      ),
                      Text('4 ساعات',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp
                        ),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('اجمالي المبلغ :',
                        style: TextStyle(
                            color: RColors.primary,

                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp
                        ),
                      ),
                      Text('120\$',
                        style: TextStyle(
                            backgroundColor: RColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _onDateRangeChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final range = args.value as PickerDateRange;
      final DateTime? start = range.startDate;
      final DateTime? end   = range.endDate ?? range.startDate;

      if (start != null && end != null) {
        setState(() {
          pickUpDate  = start;
          returnDate  = end;
          dateSelected = true;
        });
        widget.onDateSelected(true);
        final days = end.difference(start).inDays;
        for (int i = 0; i <= days; i++) {
          final day = DateTime(start.year, start.month, start.day + i);

          final alreadyExists = bookedDates.any((d) =>
          d.year == day.year && d.month == day.month && d.day == day.day);

          if (!alreadyExists) {
          //  bookedDates.add(day);
          }
    }
  } } }

      Future<void> _pickTimeRange() async {
        final TimeRange? result = await showTimeRangePicker(
          context: context,
          start: pickUpTime,
          end: returnTime,
          use24HourFormat: false,
          selectedColor: RColors.primary,
          strokeColor: const Color(0xFF0C2B4E),
          backgroundColor: Colors.white,
        );

        if (result != null) {
          setState(() {
            pickUpTime  = result.startTime;
            returnTime  = result.endTime;
            timeSelected = true;
          });

          widget.onTimeSelected(true);
        }
      }




}
