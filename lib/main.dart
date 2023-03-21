import 'dart:io';

import 'package:are_you_shipping_me/widgets/all_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'constants/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCOeISUPVtrdSD4R6i0kfzm5SU6NAvqNMg",
          authDomain: "selector-map-d4b19.firebaseapp.com",
          projectId: "selector-map-d4b19",
          storageBucket: "selector-map-d4b19.appspot.com",
          messagingSenderId: "79723746965",
          appId: "1:79723746965:web:5d11069fecfdc0b71e2d9c",
          measurementId: "G-R7CQSKYC5W"
      ),
    );
  } else{
    await Firebase.initializeApp();
  }
  if (!kIsWeb) await FlutterDownloader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: getTheme(context),
      home: const AllWidgets(),
    );
  }
}
