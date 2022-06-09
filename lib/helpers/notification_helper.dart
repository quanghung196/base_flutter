import 'dart:developer' as developer;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class NotificationHelper {
  NotificationHelper._();

  static NotificationHelper get instance => NotificationHelper._();

  Future<void> getInitialNotificationMessage() async {
    FirebaseMessaging.instance.getInitialMessage().then((message) async {
      if (message != null) {
        // Notification data
        developer.log(message.data.toString());
      }
    });
  }

  Future<void> registerNotification() async {
    await Firebase.initializeApp();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      // Notification data
      developer.log(message.data.toString());
    });

    print(await messaging.getToken());

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        // Notification data
        developer.log(message.data.toString());
      });
    } else {}
  }
}
