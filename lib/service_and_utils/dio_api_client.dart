import 'dart:async';
import 'dart:io';

import 'package:are_you_shipping_me/constants/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../constants/app_exceptions.dart';
import '../widgets/popup_and_loaders/show_loader.dart';
import '../widgets/popup_and_loaders/show_snack_bar.dart';
import 'custom_exception.dart';
import 'http_api_client.dart';

Future<bool> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      throw Exception('No Internet');
    }
  } on SocketException catch (_) {
    showSnackBar('No Internet Connection');
    return false;
  }
}

Future<List> fileUploadUsingDio(
    {required String urlAddress,
    required Map<String, String> requestBody,
    required HttpMethod httpMethod,
    bool isShowLoader = true,
    bool isShowSnackBar = true,
    required List<File> files,
    required List<String> fileAddresses,
    CancelToken? cancelToken,
    required Function onUploadProgress}) async {
  var responseData;

  if (await checkInternetConnectivity()) {
    try {
      if (isShowLoader) {
        showLoader();
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? authToken = sharedPreferences.getString('auth_token');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };
      if (authToken != null) {
        headers.addAll({'Authorization': 'Bearer $authToken'});
      }

      debugPrint('requestBody $requestBody');
      var dio = Dio();

      // debugPrint('requestBody  dio $requestBody');
      var formData = FormData.fromMap(requestBody);
      if (files.isNotEmpty) {
        int i = 0;
        for (File file in files) {
          String fileName = file.path.split('/').last;
          debugPrint('${fileAddresses[i]} ${file.path} $fileName');
          MultipartFile multipartFile =
              await MultipartFile.fromFile(file.path, filename: fileName);
          formData.files.add(MapEntry(fileAddresses[i], multipartFile));
          i++;
        }
      }
      final Response response;
      debugPrint(AppConfig.apiAddress + urlAddress);
      try {
        response = await dio.post(AppConfig.apiAddress + urlAddress,
            cancelToken: cancelToken,
            options: Options(
              followRedirects: false,
              // will not throw errors
              headers: headers,
            ),
            data: formData, onSendProgress: (send, total) {
          onUploadProgress(send, total);
        });
      } on DioError catch (err) {
        final errorMessage = CustomException.fromDioError(err).toString();
        throw errorMessage;
      } catch (e) {
        if (e.toString().contains('DioErrorType.cancel')) {
          return [false, null];
        } else {
          debugPrint(e.toString());
          debugPrint("e.toString()");
          throw AppExceptions.somethingWentWrong;
        }
      }

      // debugPrint(response.statusCode);
      // debugPrint(response.data);
      if (response.statusCode == 200) {
        var responseBody = response.data;

        debugPrint(
            '============= end $httpMethod  $urlAddress post api =============== \n $responseBody');
        if (responseBody['data'] != null) {
          responseData = responseBody['data'];
        }
        if (responseBody['success'] != null && responseBody['success']) {
          if (isShowLoader) {
            hideLoader();
          }
          return [true, responseData];
        } else {
          if (responseBody['message'] != null) {
            if (responseData != null) {
              return [false, responseData];
            } else {
              throw Exception(responseBody['message']);
            }
          } else {
            throw AppExceptions.somethingWentWrong;
          }
        }
      } else if (response.statusCode == 401) {
        throw AppExceptions.unAuthorised;
      } else {
        throw AppExceptions.somethingWentWrong;
      }
    }
    // on DioError catch (err) {
    //   final errorMessage = CustomException.fromDioError(err).toString();
    //   throw errorMessage;
    // }
    catch (e) {
      debugPrint(
          '============= fail $httpMethod  $urlAddress  dioApi =============== \n error $e');

      String message = e.toString().substring(10);
      if (isShowLoader) {
        hideLoader();
      }
      //to close loading sheet
      // if (cancelToken != null) {
      //   hideLoader();
      // }
      if (isShowSnackBar) {
        showSnackBar(message);
      }
      debugPrint(responseData);

      rethrow;
    }
  } else {
    throw AppExceptions.somethingWentWrong;
  }
}
