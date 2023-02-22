import 'package:flutter/material.dart';

import '../../../constants/app_styles.dart';
import '../../constants/app_drawables.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Image.asset(AppDrawables.loader,
            height: AppStyles().width * .2, width: AppStyles().width * .2));
  }
}
