import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:teamkhagrachari/app.dart';
import 'package:teamkhagrachari/local_notification_service.dart';
import 'firebase_options.dart';

Future<void> firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    LocalNotificationService.display(message);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TeamKhagrachari());
}
