import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const primaryColor = Color(0xff181818);

const primaryColorLighter = Color(0xff3A3B3C);
const primaryColorLightest = Color(0xff404040);

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle({super.key, required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black12,
      enabled: true,
      highlightColor: Colors.white,
      loop: 3,
      child: ClipOval(
        child: ColoredBox(
          color: Colors.white,
          child: SizedBox(
            height: radius * 2,
            width: radius * 2,
          ),
        ),
      ),
    );
  }
}

class ShimmerRectangle extends StatelessWidget {
  final double height, width;

  const ShimmerRectangle(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: primaryColorLightest,
      highlightColor: primaryColorLighter,
      loop: 100,
      child: ColoredBox(
        color: primaryColor,
        child: SizedBox(
          height: height,
          width: width,
        ),
      ),
    );
  }
}
