import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../popup_and_loaders/show_snack_bar.dart';

download(
    {required String url,
    String? fileNameWithExtension,
    bool isShowSnackBar = true}) async {
  final status = await Permission.storage.request();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? authToken = sharedPreferences.getString('auth_token');
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  if (authToken != null) {
    headers.addAll({'Authorization': 'Bearer $authToken'});
  }
  if (status.isGranted) {
    if (isShowSnackBar) {
      showSnackBar("downloading");
    }
    final downloadPath = await getDownloadPath2();

    final taskId = await FlutterDownloader.enqueue(
      url: url,
      headers: headers,
      savedDir: downloadPath!,
      showNotification: true,
      fileName: fileNameWithExtension,
      saveInPublicStorage: false,
      openFileFromNotification: true,
    );
    if (isShowSnackBar) {
      showSnackBar("downloaded successfully",action: ()  async {
        if (taskId != null) {
          debugPrint("path///${downloadPath}/${fileNameWithExtension}");
          OpenFilex.open("$downloadPath/$fileNameWithExtension");
        }
      });
    }
  } else {
    showSnackBar('Please give permission for storage');
  }
}


void initialiser() {
  final ReceivePort _port = ReceivePort();
  int progress = 0;
  IsolateNameServer.registerPortWithName(
      _port.sendPort, 'downloader_send_port');
  _port.listen((dynamic data) {
    // String id = data[0];
    // DownloadTaskStatus status = data[1];
    progress = data[2];
  });

  FlutterDownloader.registerCallback(downloadCallback);
}

@pragma('vm:entry-point')
void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? sendPort =
      IsolateNameServer.lookupPortByName('downloader_send_port');
  sendPort!.send([id, status, progress]);
}

void disposeMethod() {
  IsolateNameServer.removePortNameMapping('downloader_send_port');
}
Future<String?> getDownloadPath2() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getExternalStorageDirectory();
    }
  } catch (err) {
    debugPrint("Cannot get download folder path");
  }
  return directory?.path;
}
