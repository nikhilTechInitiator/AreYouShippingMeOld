import 'dart:ui' as ui;

import 'package:are_you_shipping_me/constants/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderWithImage extends StatefulWidget {
  final String label;
  final double interval;
  final double maxValue;
  final double stepSize;
  final double? initialSliderValue;
   const SliderWithImage({Key? key, required this.label, required this.interval, required this.maxValue, required this.stepSize, this.initialSliderValue}) : super(key: key);

  @override
  State<SliderWithImage> createState() => _SliderWithImageState();
}

class _SliderWithImageState extends State<SliderWithImage> {
  ui.Image? customImage;
  double sliderValue = 0.0;

  Future<ui.Image> loadImage(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();

    return fi.image;
  }

  @override
  void initState() {
    super.initState();

    loadImage('assets/orderIcons/reached.png').then((img) async {
      ui.Image image = await getSizedImage(img);
      setState(() {
        customImage = image;
      });
    });
    sliderValue = widget.initialSliderValue ??  0.0;
  }

  @override
  Widget build(BuildContext context) {
    return SfSliderTheme(
      data: SfSliderThemeData(
          activeTrackHeight: 2,
          inactiveTrackHeight: 2,
          activeTrackColor: AppColors.sliderTrackColor,
          inactiveTrackColor: AppColors.sliderTrackColor,
          activeTickColor: AppColors.sliderTrackColor,
          activeMinorTickColor: AppColors.sliderTrackColor,
          disabledActiveTickColor: AppColors.sliderTrackColor,
          disabledInactiveTickColor: AppColors.sliderTrackColor,
          inactiveTickColor: AppColors.sliderTrackColor,
          inactiveMinorTickColor: AppColors.sliderTrackColor,
          disabledInactiveMinorTickColor: AppColors.sliderTrackColor,
          disabledActiveMinorTickColor: AppColors.sliderTrackColor,
          activeDividerColor: AppColors.sliderTrackColor,
          inactiveDividerColor: AppColors.sliderTrackColor,
          trackCornerRadius: 0,
          minorTickSize: const Size(.5, 4) ,
          tickSize: const Size(1, 8),
          activeLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(wordSpacing: .2,height: 1),
          inactiveLabelStyle: Theme.of(context).textTheme.labelSmall?.copyWith(wordSpacing: .2,height: 1),
          thumbColor: Colors.transparent,
          thumbRadius: 16),
      child: SfSlider(
        interval: widget.interval,
        showDividers: true,
        showTicks: true,
        showLabels: true,
        stepSize: widget.stepSize,
        enableTooltip: true,
        labelFormatterCallback: (dynamic actualValue, String formattedText) {
          return   '$formattedText\n${widget.label}';
        },
        // shouldAlwaysShowTooltip: true,

        thumbIcon: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SvgPicture.asset(
            'assets/orderIcons/reached.svg',
          ),
        ),
        minorTicksPerInterval: 1,
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

class _SfThumbShape extends SfThumbShape {
  final ui.Image image;

  _SfThumbShape(this.image);

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
        required RenderBox? child,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Paint? paint,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required SfThumb? thumb}) {
    final imageWidth = image.width;
    final imageHeight = image.height;

    Offset imageOffset = Offset(
      center.dx - (imageWidth * .5),
      center.dy - (imageHeight * .7),
    );

    Paint paint = Paint()..filterQuality = FilterQuality.high;
    context.canvas.drawImage(image, imageOffset, paint);
  }
}

Future getSizedImage(ui.Image image) async {
  var recorder = ui.PictureRecorder();
  var imageCanvas = new Canvas(recorder);
  paintImage(
      canvas: imageCanvas, rect: Rect.fromLTWH(0, 0, 10, 6), image: image);
  ui.Picture picture = await recorder.endRecording();

  var img = picture.toImage(10, 6);

  return img;
}

class _SfThumbShapeEmpty extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
        required RenderBox? child,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Paint? paint,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required SfThumb? thumb}) {
    final Path path = Path();
    context.canvas.drawPath(
        path,
        Paint()
          ..color = themeData.activeTrackColor!
          ..style = PaintingStyle.fill
          ..strokeWidth = 2);
  }
}
