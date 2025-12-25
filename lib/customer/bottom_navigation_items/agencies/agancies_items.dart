import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vehicle_rental_app/customer/data/models/user/agency_model.dart';
import 'package:vehicle_rental_app/customer/data/shop/controllers/agency_controller.dart';
import 'package:vehicle_rental_app/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../widgets/RAppbar.dart';
import '../../../widgets/Rshimmer.dart';
import '../../../widgets/car_card.dart';
import '../details/details_page.dart';

class AganciesItems extends StatefulWidget {
  const AganciesItems({super.key, required this.agency});

  final AgencyModel agency;

  @override
  State<AganciesItems> createState() => _AganciesItemsState();
}

class _AganciesItemsState extends State<AganciesItems> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    AgencyController.instance.fetchVehicles(id: widget.agency.id);
  });
  }

  @override
  Widget build(BuildContext context) {
    final agencyController = AgencyController.instance;
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
              onPressed: ()=> Get.back(),
              color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
            ),
          ) ,
          title: Text(widget.agency.agencyName ,
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
      )
          : RAppbarTheme.lightAppBarTheme(
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
              onPressed: ()=> Get.back(),
              color: RColors.darkerGrey, icon:Icon( CupertinoIcons.left_chevron),
            ),
          ) ,
          title: Text(widget.agency.agencyName  ,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize:20.sp,
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
      ) ,
      body: Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
          Obx((){
            if(agencyController.isLoading.value){
              return RShimmerEffect(height: 190, width: double.infinity);
            }
            if(agencyController.error.value.isNotEmpty){
              return Center(child: Text(agencyController.error.value));
            }
            if(!agencyController.agencyVehicles.isNotEmpty){
              return Center(child: Text('لا يوجد بيانات للعرض'),);
            }
            final vehicles = agencyController.agencyVehicles;
             return GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 0.h,
                crossAxisSpacing: 15.w,
              ),
                   scrollDirection: Axis.vertical,
              itemCount: vehicles.length,
              padding: const EdgeInsets.symmetric(horizontal:10),
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return  GestureDetector(
                  onTap: ()=> Get.to(DetailsPage()),
                  child: SizedBox(
                      height: 280.h,
                      child: CarCardBookButton(
                    image: RImages.car1,
                    name: vehicle["brand"]??'',
                    rating: vehicle["reviews_avg_rating"]??'',
                    location: widget.agency.address,
                    seats: vehicle["model"]??'',
                    price: vehicle["price_per_hour"]??'',
                  ),
                  ),
                );
              },
            );
              }

            )
          ],
        ),
      ),
              ),
    );
  }
}
