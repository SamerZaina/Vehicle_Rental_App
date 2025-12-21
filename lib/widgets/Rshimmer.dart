import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/helpers/helper_functions.dart';

class RShimmerEffect extends StatelessWidget {
  const RShimmerEffect({
    super.key,
    required this.height,
    required this.width,
    this.radius = 15,
    this.color
  });

  final double width,height,radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final dark = RHelperFunctions.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: color ?? (dark ? Color(0xff656363) : Colors.white),
            borderRadius: BorderRadius.circular(radius)
        ),
      ), );
  }
}
