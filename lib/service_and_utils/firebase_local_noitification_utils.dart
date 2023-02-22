// import 'dart:convert';
//
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// import '../main.dart';
//
// late AndroidNotificationChannel channel;
//
// bool isFlutterLocalNotificationsInitialized = false;
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// @pragma('vm:entry-point')
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   try {
//       await Firebase.initializeApp(
//           options: DefaultFirebaseOptions.currentPlatform);
//
//   } catch (e) {
//     debugPrint('firebase error $e');
//   }
//   // showFlutterNotification(message);
//   debugPrint('Handling a background message ${message.messageId}');
// }
//
// initializeNotifications() async {
//   // getFirebaseMessagingToken();
//   await Future.delayed(const Duration(seconds: 5));
//   RemoteMessage? initialMessage =
//       await FirebaseMessaging.instance.getInitialMessage();
//   debugPrint('notification  initialMessage $initialMessage');
//
//   if (initialMessage != null) {
//     notificationAction(initialMessage.data, 3);
//   }
//   FirebaseMessaging.onMessage.listen((message) {
//     debugPrint('showFlutterNotification onMessage ');
//     showFlutterNotification(message);
//   });
//
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     debugPrint('notification  onMessageOpenedApp $message');
//     notificationAction(message.data, 1);
//   });
// }
//
// Future<String?> getFirebaseMessagingToken() async {
//   String? firebaseMessagingToken = await FirebaseMessaging.instance.getToken();
//   debugPrint("firebase token $firebaseMessagingToken");
//
//   return firebaseMessagingToken;
// }
//
// Future<void> _setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description:
//         'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );
//
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('notification_icon');
//
//   // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//
//   const DarwinInitializationSettings initializationSettingsDarwin =
//       DarwinInitializationSettings(
//           onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//   const LinuxInitializationSettings initializationSettingsLinux =
//       LinuxInitializationSettings(defaultActionName: 'Open notification');
//   const InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       linux: initializationSettingsLinux);
//   flutterLocalNotificationsPlugin.initialize(initializationSettings,
//       onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//
//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   ///
//   ///
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }
//
// void onDidReceiveLocalNotification(
//     int id, String? title, String? body, String? payload) async {
//   // display a dialog with the notification details, tap ok to go to another page
//   BuildContext context = MyApp.navigatorKey.currentContext!;
//   showDialog(
//     context: context,
//     builder: (BuildContext context) => CupertinoAlertDialog(
//       title: Text(title ?? 'Tittle'),
//       content: Text(body ?? 'body'),
//       actions: [
//         CupertinoDialogAction(
//           isDefaultAction: true,
//           child: const Text('OK'),
//           onPressed: () async {
//             Navigator.of(context, rootNavigator: true).pop();
//           },
//         )
//       ],
//     ),
//   );
// }
//
// void onDidReceiveNotificationResponse(
//     NotificationResponse notificationResponse) async {
//   final String? payload = notificationResponse.payload;
//   if (notificationResponse.payload != null) {
//     debugPrint('notification payload: $payload');
//     notificationAction(jsonDecode(payload!), 0);
//   }
// }
//
// void showFlutterNotification(RemoteMessage message) async {
//   debugPrint('showFlutterNotification ${message.data}');
//   await _setupFlutterNotifications();
//
//   RemoteNotification? notification = message.notification;
//   int? notificationId;
//   if (message.data.isNotEmpty) {
//     Map<String, dynamic> messageData = message.data;
//     if (messageData['notification_id'] != null) {
//       notificationId = int.parse(messageData['notification_id'].toString());
//     }
//     // for updating InApp Notification
//     // if (notificationId != null) {
//     //   Get.find<NotificationController>()
//     //       .addIndividualData(notificationId: notificationId);
//     // }
//     flutterLocalNotificationsPlugin.show(
//       notificationId ?? notification.hashCode,
//       notification?.title ?? 'tittle',
//       notification?.body ?? 'body',
//       NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             // TODO add a proper drawable resource to android, for now using
//             //      one that already exists in example app.
//             icon: 'notification_icon',
//           ),
//           iOS: const DarwinNotificationDetails()),
//       payload: json.encode(message.data),
//     );
//   }
// }
//
// notificationAction(Map<String, dynamic> messageData, int delay) async {
//   await Future.delayed(Duration(seconds: delay));
//   debugPrint('messageDataMessageData $messageData');
//
//   String notificationType = messageData['notify_type'] ?? 'UnKnown';
//   int? id;
//   if (messageData['data_id'] != null &&
//       messageData['data_id'] != '0' &&
//       messageData['data_id'] != 0) {
//     id = int.parse(messageData['data_id'].toString());
//   }
//   int? notificationId;
//   if (messageData['notification_id'] != null &&
//       messageData['notification_id'] != '0' &&
//       messageData['notification_id'] != 0) {
//     notificationId = int.parse(messageData['notification_id'].toString());
//   }
//
//   //
//   if (notificationType == 'feedback') {
//     // Navigator.pushNamed(MyApp.navigatorKey.currentContext!, '/feedBackList');
//     // if (id != null) {
//     //   Get.find<AppController>().currentFeedBackId = id;
//     //   Navigator.pushNamed(MyApp.navigatorKey.currentContext!, '/feedBack',
//     //       arguments: {'id': id}).then((value) {
//     //     Get.find<AppController>().currentFeedBackId = null;
//     //   });
//     // }
//   }
//   //In-App Notification count update
//   if (notificationId != null) {
//     // if (!Get.isRegistered<NotificationController>()) {
//     //   await Get.put(NotificationController()).getInitialData();
//     // }
//     // Get.find<NotificationController>()
//     //     .markOneAsRead(notificationId: notificationId);
//     flutterLocalNotificationsPlugin.cancel(notificationId);
//   }
//
// }
//
