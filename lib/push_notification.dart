import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifications {
  static final firebaseMessaging = FirebaseMessaging.instance;

  static Future init() async {
    await firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        carPlay: true,
        sound: true,
        criticalAlert: true);
  }
}
