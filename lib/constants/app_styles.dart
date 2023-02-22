import 'dart:ui';

import 'package:flutter/material.dart';

class AppStyles {

  // DEVICE SIZE

  var pixelRatio = window.devicePixelRatio;

  //Size in physical pixels
  var physicalScreenSize = window.physicalSize;
  double width = window.physicalSize.width;
  double height = window.physicalSize.height;

  //Size in logical pixels
  var logicalScreenSize = window.physicalSize / window.devicePixelRatio;
  var logicalWidth = (window.physicalSize / window.devicePixelRatio).width;
  var logicalHeight = (window.physicalSize / window.devicePixelRatio).height;

  //Padding in physical pixels
  var padding = window.padding;

  //Safe area paddings in logical pixels
  var paddingLeft = window.padding.left / window.devicePixelRatio;
  var paddingRight = window.padding.right / window.devicePixelRatio;
  var paddingTop = window.padding.top / window.devicePixelRatio;
  var paddingBottom = window.padding.bottom / window.devicePixelRatio;

  // //Safe area in logical pixels
  // var safeWidth = logicalWidth - paddingLeft - paddingRight;
  // var safeHeight = logicalHeight - paddingTop - paddingBottom;

  //PADDING
  static const EdgeInsets extraSmallPadding =  EdgeInsets.all(4.0);
  static const EdgeInsets smallPadding = EdgeInsets.all( 8.0);
  static const EdgeInsets mediumPadding =  EdgeInsets.all(16.0);
  static const EdgeInsets largePadding =  EdgeInsets.all(24.0);
  static const EdgeInsets extraLargePadding =  EdgeInsets.all(32.0);

  static const EdgeInsets screenPadding = EdgeInsets.all(16.0);
  static const EdgeInsets horizontalPadding =  EdgeInsets.all(16.0);
  static const EdgeInsets verticalPadding = EdgeInsets.all(8.0);
  static const EdgeInsets cardPadding = EdgeInsets.all(12.0);
  static const EdgeInsets listItemPadding = EdgeInsets.all(16.0);
  static const EdgeInsets iconPadding = EdgeInsets.all(8.0);
  static const EdgeInsets buttonPadding = EdgeInsets.all(8.0);
  static const EdgeInsets inputPadding = EdgeInsets.all(16.0);
  static const EdgeInsets appBarTitlePadding = EdgeInsets.all(16.0);
  static const EdgeInsets sectionPadding =EdgeInsets.all( 16.0);
  static const EdgeInsets dividerPadding = EdgeInsets.all(16.0);


  // SIZED BOX
  static const SizedBox extraSmallBox = SizedBox(
    height: 4.0,
    width: 4.0,
  );
  static const SizedBox smallBox = SizedBox(
    height: 8.0,
    width: 8.0,
  );
  static const SizedBox mediumBox = SizedBox(
    height: 16.0,
    width: 16.0,
  );
  static const SizedBox largeBox = SizedBox(
    height: 24.0,
    width: 24.0,
  );
  static const SizedBox extraLargeBox = SizedBox(
    height: 32.0,
    width: 36.0,
  );

  //DIVIDER
  static const Divider thinSmallDivider =
      Divider(height: 0.5, color: Colors.grey);
  static const Divider thinMediumDivider =
      Divider(height: 1.0, color: Colors.grey);
  static const Divider thinLargeDivider =
      Divider(height: 2.0, color: Colors.grey);

  static const Divider thickSmallDivider =
      Divider(height: 0.5, color: Colors.black);
  static const Divider thickMediumDivider =
      Divider(height: 1.0, color: Colors.black);
  static const Divider thickLargeDivider =
      Divider(height: 2.0, color: Colors.black);

  //BORDER
  static Border borderSmallThin = Border.all(color: Colors.grey, width: 0.5);
  static Border borderMediumThin = Border.all(color: Colors.grey, width: 1.0);
  static Border borderLargeThin = Border.all(color: Colors.grey, width: 2.0);

  static Border borderSmallThick = Border.all(color: Colors.grey, width: 0.5);
  static Border borderMediumThick = Border.all(color: Colors.grey, width: 1.0);
  static Border borderLargeThick = Border.all(color: Colors.grey, width: 2.0);


  // BORDER RADIUS
  static const BorderRadius borderRadiusExtraSmall = BorderRadius.all(Radius.circular(4.0));
  static const BorderRadius borderRadiusSmall = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(12.0));
  static const BorderRadius borderRadiusLarge = BorderRadius.all(Radius.circular(16.0));
  static const BorderRadius borderRadiusExtraLarge = BorderRadius.all(Radius.circular(16.0));


  //BOS SHADOW
  static  BoxShadow shadowCard = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 5.0,
    spreadRadius: 0.0,
    offset:const  Offset(0.0, 2.0),
  );

  static  BoxShadow shadowButton = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 5.0,
    spreadRadius: 0.0,
    offset:const  Offset(0.0, 3.0),
  );

  static  BoxShadow shadowTextField = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 2.0,
    spreadRadius: 0.0,
    offset: const Offset(0.0, 1.0),
  );

  static  BoxShadow shadowFloatingActionButton = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    blurRadius: 10.0,
    spreadRadius: 0.0,
    offset:const Offset(0.0, 3.0),
  );


  // Small shadow
  static const List<BoxShadow> shadowSmall = [BoxShadow(
    color: Colors.black12,
    blurRadius: 4.0,
    offset: Offset(0.0, 2.0),
  )];

  // Medium shadow
  static const List<BoxShadow> shadowMedium = [BoxShadow(
    color: Colors.black26,
    blurRadius: 8.0,
    offset: Offset(0.0, 4.0),
  )];

  // Large shadow
  static const List<BoxShadow> shadowLarge = [BoxShadow(
    color: Colors.black38,
    blurRadius: 12.0,
    offset: Offset(0.0, 6.0),
  )];
  static const BoxDecoration smallBoxDecoration = BoxDecoration(
    boxShadow: shadowSmall,
    color: Colors.white,
    borderRadius: borderRadiusSmall,
  );
}
