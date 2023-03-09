import UIKit
import Flutter
import GoogleMaps
import flutter_downloader
import FirebaseCore
import Firebase
import FirebaseMessaging


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyB-_vym9wZXKCkVr7_pqtRmdNsJGgB3AAk")
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

    if #available(iOS 10.0, *)
       {
           UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
       }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(_ application: UIApplication,
                                didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          Messaging.messaging().apnsToken = deviceToken
          print("Token: \(deviceToken)")
          super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
      }
}


private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}
