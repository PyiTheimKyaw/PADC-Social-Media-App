import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FCMService {
  static final FCMService _singleton = FCMService._internal();

  factory FCMService() {
    return _singleton;
  }

  FCMService._internal();

  ///Firebase Messaging instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  ///Android notification channel

  void listenForMessage() async {
    messaging.getToken().then((fcmToken) {
      debugPrint("FCM token for device ============> $fcmToken");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      debugPrint(
          "User pressed the notification ${remoteMessage.data['post_id']}");
    });

    messaging.getInitialMessage().then((remoteMessage) {
      debugPrint("Message launched ${remoteMessage?.data['post_id']}");
    });
  }
}
