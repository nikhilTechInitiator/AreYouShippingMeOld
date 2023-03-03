import 'dart:ui' as ui;

import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderWithCircle extends StatefulWidget {
  final double interval;
  final double maxValue;
  final double stepSize;
   const SliderWithCircle({Key? key,  required this.interval, required this.maxValue, required this.stepSize}) : super(key: key);

  @override
  State<SliderWithCircle> createState() => _SliderWithCircleState();
}

class _SliderWithCircleState extends State<SliderWithCircle> {
  double sliderValue = 0.0;



  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
          activeTrackHeight: 5,
          inactiveTrackHeight: 5,
          activeTrackColor: Colors.blue,
          inactiveTrackColor: Colors.grey,
          activeTickColor: Colors.blue,
          activeMinorTickColor: Colors.blue,
          disabledActiveTickColor: Colors.grey,
          disabledInactiveTickColor: Colors.grey,
          inactiveTickColor: Colors.grey,
          inactiveMinorTickColor: Colors.grey,
          disabledInactiveMinorTickColor: Colors.grey,
          disabledActiveMinorTickColor: Colors.grey,
          activeDividerColor: Colors.blue,
          inactiveDividerColor: Colors.grey,
          trackCornerRadius: 0,
          tickSize: const Size(10, 10),
          activeLabelStyle: Theme.of(context).textTheme.labelSmall,
          inactiveLabelStyle: Theme.of(context).textTheme.labelSmall,
          thumbColor: Colors.transparent,minorTickSize: Size(0,0),
          thumbRadius: 15),
      child: SfSlider(
        interval: widget.interval,
        showDividers: true,
        showTicks: false,
        showLabels: false,
        stepSize: widget.stepSize,
        enableTooltip: false,
        minorTicksPerInterval: 1,dividerShape:_DividerShape() ,
        value: sliderValue,
        min: 0,
        max: widget.maxValue,
        onChanged: (value) {
          setState(() {
            sliderValue = value;
          });
        },
      ),
    );
  }
}

class _DividerShape extends SfDividerShape {
  @override
  void paint(PaintingContext context, Offset center, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Paint? paint,
        required Animation<double> enableAnimation,
        required TextDirection textDirection}) {
    bool isActive;

    switch (textDirection) {
      case TextDirection.ltr:
        isActive = center.dx <= thumbCenter!.dx;
        break;
      case TextDirection.rtl:
        isActive = center.dx >= thumbCenter!.dx;
        break;
    }
    context. canvas.drawCircle(center, 10,
        Paint()
          ..isAntiAlias = true
          ..style = PaintingStyle.fill
          ..color = isActive ? themeData.activeTrackColor! : Colors.grey);
  }
}


