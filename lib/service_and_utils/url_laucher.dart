
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_strings.dart';
import '../widgets/popup_and_loaders/show_snack_bar.dart';

class UrlUtils {
  Future<void> launch(String urlString) async {
    debugPrint('urlString $urlString');
    final Uri url = Uri.parse(urlString);

    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $url';
      }
    } catch (e) {
      showSnackBar(AppStrings.somethingWentWrong);
      debugPrint('url launch error $url');
      debugPrint(e.toString());
    }
  }

  Future<void> launchWhatsApp({required String contactNumber}) async {
    try {
      launchUrl(Uri.parse('https://wa.me/$contactNumber?text=Hi'),
          mode: LaunchMode.externalApplication);
    } catch (e) {
      showSnackBar(AppStrings.somethingWentWrong);
      debugPrint(e.toString());
    }
  }

  Future<void> callToNumber({required String contactNumber}) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: contactNumber,
    );
    try {
      launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      showSnackBar(AppStrings.somethingWentWrong);
      debugPrint(e.toString());
    }
  }
}
