import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:are_you_shipping_me/constants/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_exceptions.dart';
import '../widgets/popup_and_loaders/show_loader.dart';
import '../widgets/popup_and_loaders/show_snack_bar.dart';

Map<String, String> authHeaders = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
};
String? authToken;

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

enum HttpMethod { post, patch, get, delete }

Future loginHttpRequest(
    {required String urlAddress,
    required Map<String, String> requestBody,
    required HttpMethod httpMethod,
    bool isShowLoader = true,
    bool isShowSnackBar = true}) async {
  debugPrint('============= start $httpMethod $urlAddress   ===============');

  if (await checkInternetConnectivity()) {
    try {
      if (isShowLoader) {
        showLoader();
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      authToken = sharedPreferences.getString('auth_token');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      };

      if (authToken != null) {
        //debugPrint"Bearer authToken");
        debugPrint("Bearer $authToken");
        headers.addAll({'Authorization': 'Bearer $authToken'});
        authHeaders.addAll({'Authorization': 'Bearer $authToken'});
      }
      final uri = Uri.parse(AppConfig.apiAddress + urlAddress);
      late http.Response response;
      if (httpMethod == HttpMethod.post) {
        response = await http.post(uri,
            body: jsonEncode(requestBody), headers: headers);
      }
      if (response.statusCode == 200 || response.statusCode == 401) {
        var responseBody = jsonDecode(response.body);
        debugPrint(
            '============= end $httpMethod  $urlAddress post api =============== \n $responseBody');
        if (responseBody['status'] != null &&
            responseBody['status'] == 'success') {
          if (isShowLoader) {
            hideLoader();
          }
          return responseBody;
        } else {
          if (responseBody['message'] != null) {
            throw Exception(responseBody['message']);
          } else {
            throw AppExceptions.somethingWentWrong;
          }
        }
      } else {
        throw AppExceptions.somethingWentWrong;
      }
    } catch (e) {
      debugPrint(
          '============= fail $httpMethod  $urlAddress  api =============== \n error $e');

      String message = e.toString().substring(10);
      if (isShowLoader) {
        hideLoader();
      }
      if (isShowSnackBar) {
        showSnackBar(message);
      }
      rethrow;
    }
  }
}

Future httpRequest(
    {required String urlAddress,
    required Map<String, String> requestBody,
    required HttpMethod httpMethod,
    bool isShowLoader = true,
    bool isShowSnackBar = true}) async {
  debugPrint('============= start $httpMethod $urlAddress   ===============');
  debugPrint(
      '============= requestBody  $httpMethod  $requestBody   ===============');

  if (await checkInternetConnectivity()) {
    try {
      if (isShowLoader) {
        showLoader();
      }
      final headers = {'Authorization': 'Bearer $authToken'};
      //debugPrint"Bearer authToken");

      String params = '';

      if (httpMethod == HttpMethod.get) {
        requestBody.forEach((key, value) {
          params = params.isEmpty ? '?$key=$value' : '$params&$key=$value';
        });
      }
      String finalUrl = AppConfig.apiAddress + urlAddress + params;

      final uri = Uri.parse(finalUrl);

      late http.Response response;
      if (httpMethod == HttpMethod.post) {
        response = await http.post(uri, body: requestBody, headers: headers);
      }
      if (httpMethod == HttpMethod.get) {
        response = await http.get(uri, headers: headers);
      }

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        debugPrint(
            '============= end $httpMethod  $urlAddress post api =============== \n $responseBody');

        if (responseBody['success'] != null && responseBody['success']) {
          if (isShowLoader) {
            hideLoader();
          }

          return responseBody['data'];
        } else {
          if (responseBody['message'] != null) {
            throw Exception(responseBody['message']);
          } else {
            throw AppExceptions.somethingWentWrong;
          }
        }
      } else if (response.statusCode == 401) {
        throw AppExceptions.unAuthorised;
      } else {
        throw AppExceptions.somethingWentWrong;
      }
    } catch (e) {
      debugPrint(
          '============= fail $httpMethod  $urlAddress  api =============== \n error $e');

      String message = e.toString().substring(10);
      if (isShowLoader) {
        hideLoader();
      }
      if (isShowSnackBar) {
        showSnackBar(message);
      }
      rethrow;
    }
  }
}

Future httpRequestCustom(
    {required String urlAddress,
    required Map<String, String> requestBody,
    required HttpMethod httpMethod,
    bool isShowLoader = true,
    bool isShowSnackBar = true}) async {
  debugPrint(
      '============= custom start $httpMethod $urlAddress   ===============');
  debugPrint(
      '============= custom requestBody  $httpMethod  $requestBody   ===============');

  if (await checkInternetConnectivity()) {
    try {
      if (isShowLoader) {
        showLoader();
      }

      final headers = {'Authorization': 'Bearer $authToken'};
      // debugPrint("Bearer $authToken");

      final uri = Uri.parse(urlAddress);

      late http.Response response;
      if (httpMethod == HttpMethod.post) {
        response = await http.post(uri, body: requestBody, headers: headers);
      }
      if (httpMethod == HttpMethod.get) {
        response = await http.get(uri, headers: headers);
      }

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (isShowLoader) {
          hideLoader();
        }
        debugPrint(
            '============= custom end $httpMethod  $urlAddress post api =============== \n $responseBody');
        return responseBody;
      } else if (response.statusCode == 401) {
        throw AppExceptions.unAuthorised;
      } else {
        throw AppExceptions.somethingWentWrong;
      }
    } catch (e) {
      debugPrint(
          '=============custom fail $httpMethod  $urlAddress  api =============== \n error $e');

      String message = e.toString().substring(10);
      if (isShowLoader) {
        hideLoader();
      }
      if (isShowSnackBar) {
        showSnackBar(message);
      }
      rethrow;
    }
  }
}
