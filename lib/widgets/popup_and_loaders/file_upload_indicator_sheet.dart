import 'dart:io';

import 'package:are_you_shipping_me/constants/app_styles.dart';
import 'package:dio/dio.dart';
import '../../../main.dart';
import 'package:flutter/material.dart';

import '../../service_and_utils/dio_api_client.dart';
import '../../service_and_utils/http_api_client.dart';

showFileUploadIndicatorSheet({
  bool showUploadBytes = true,
  required String urlAddress,
  required Map<String, String> requestBody,
  required List<File> files,
  required HttpMethod httpMethod,
  required List<String> fileAddresses,
}) async {
  double totalByteLength = 0.0, uploadedByteLength = 0.0;
  double progress = 0.0;
  //change if need an alert
  bool isInitial = true;
  bool isProcessCompleted = false;
  var responseData;
  CancelToken cancelToken = CancelToken();

  showModalBottomSheet(
      elevation: 10,
      useRootNavigator: true,
      barrierColor: Colors.black54,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      )),
      context: MyApp.navigatorKey.currentContext!,
      builder: (BuildContext bottomSheetContext) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding:
                const EdgeInsets.only(top: 30, bottom: 35, left: 20, right: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Uploading Please wait',
                      style: Theme.of(MyApp.navigatorKey.currentContext!)
                          .textTheme
                          .titleLarge,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.shade100,
                  // color: Colors.white,
                ),
                if (showUploadBytes) AppStyles.smallBox,
                if (showUploadBytes)
                  Text(
                    '${uploadedByteLength.toStringAsFixed(1)}MB | ${totalByteLength.toStringAsFixed(1)}MB ',
                    style: Theme.of(MyApp.navigatorKey.currentContext!)
                        .textTheme
                        .bodyMedium,
                    textAlign: TextAlign.end,
                  ),
                AppStyles.largeBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        cancelToken.cancel();
                        Navigator.of(bottomSheetContext).pop();
                      },
                      child: const Text(
                        'CANCEL',
                      ),
                    ),
                    // InkWell(
                    //   onTap: () async {},
                    //   child: Container(
                    //     margin: EdgeInsets.only(top: 10),
                    //     decoration: BoxDecoration(
                    //         color: Colors.transparent,
                    //         borderRadius: BorderRadius.circular(25),
                    //         border: Border.all(color: Colors.white)),
                    //     padding: EdgeInsets.only(
                    //         top: 10, right: 20, left: 20, bottom: 10),
                    //     child: Text(
                    //       'CANCEL',
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 16,
                    //           color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          );
        });
      });
  if (isInitial) {
    isInitial = false;
    try {
      var response = await fileUploadUsingDio(
          urlAddress: urlAddress,
          requestBody: requestBody,
          files: files,
          fileAddresses: fileAddresses,
          cancelToken: cancelToken,
          isShowLoader: false,
          isShowSnackBar: true,
          onUploadProgress: (uploaded, total) {
            try {
              MyApp.navigatorKey.currentState!.setState(() {
                totalByteLength = total / 1024 / 1024;
                uploadedByteLength = uploaded / 1024 / 1024;
                progress = uploaded / total;
              });
            } catch (e) {
              debugPrint('error $e');
            }
          },
          httpMethod: httpMethod);
      //     .then((value) {
      //   if (uploadedByteLength >= totalByteLength) {
      //     // isProcessCompleted = true;
      //
      //
      //
      //     Navigator.of(MyApp.navigatorKey.currentContext!).pop();
      //   }
      // });
      debugPrint('response $response');
      isProcessCompleted = response[0];
      responseData = response[1];
      Navigator.of(MyApp.navigatorKey.currentContext!).pop();
    } catch (e) {
      Navigator.of(MyApp.navigatorKey.currentContext!).pop();
    }
  }
  return [isProcessCompleted, responseData];
}

// !isUploadedStarted
// ? Container(
// decoration: BoxDecoration(
// color: Colors.grey.shade900,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(16.0),
// topRight: Radius.circular(16.0),
// )),
// padding:
// EdgeInsets.only(top: 30, bottom: 35, left: 20, right: 20),
// child: new Wrap(
// children: <Widget>[
// Text(
// 'Are you sure ?',
// style: Theme.of(MyApp.navigatorKey.currentContext)
// .textTheme
//     .titleLarge,
// ),
// SizedBox(
// height: 30,
// ),
// Row(
// children: [
// InkWell(
// onTap: () {
// Navigator.of(bottomSheetContext).pop();
// },
// child: Container(
// margin: EdgeInsets.only(top: 10),
// decoration: BoxDecoration(
// color: Colors.transparent,
// borderRadius: BorderRadius.circular(25),
// border: Border.all(color: Colors.white)),
// padding: EdgeInsets.only(
// top: 10, right: 20, left: 20, bottom: 10),
// child: Text(
// 'CANCEL',
// style: TextStyle(
// fontWeight: FontWeight.w500,
// fontSize: 16,
// color: Colors.white),
// ),
// ),
// ),
// SizedBox(
// width: 15,
// ),
// Expanded(
// child: InkWell(
// onTap: () async {
//
// },
// child: Container(
// margin: EdgeInsets.only(top: 10),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(25),
// ),
// padding: EdgeInsets.only(top: 10, bottom: 10),
// child: Center(
// child: Text(
// 'UPLOAD',
// style: TextStyle(
// fontWeight: FontWeight.w500,
// fontSize: 16,
// color: Colors.black),
// ),
// ),
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// )
// :
