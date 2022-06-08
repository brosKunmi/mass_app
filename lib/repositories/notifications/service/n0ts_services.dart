import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mass_app/utilities/buttons/text_button.dart';
import 'package:mass_app/utilities/extensions/string_extentions.dart';

class NotificationServices {
  static Future<void> setupInteractedMessage(BuildContext context) async {
    await _requestPermission();

    if (Platform.isIOS) {
      await _setIos();
    } else if (Platform.isAndroid) {
      await _createAndroidNotsChannel();
    }

    _onNotsRecieved();
    _getInitialMsg(context);
  }

  static Future<void> _getInitialMsg(BuildContext context) async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage, context);
    }

    FirebaseMessaging.onMessageOpenedApp
        .listen((m) => _handleMessage(m, context));
  }

  static Future<void> _requestPermission() async {
    var messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static void _handleMessage(RemoteMessage message, BuildContext context) {
    if (message.notification != null) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: message.notification?.title!.profileBold,
            content: message.notification?.body!.contentText,
            actions: [
              MassTextButton(
                  text: 'Ok',
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
      );
    }
  }

  static Future<void> _setIos() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  static Future<void> _createAndroidNotsChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'mass_notification_channel', // id
      'MASS Notifications', // title
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static void _onNotsRecieved() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'mass_notification_channel',
              'MASS Notifications',
              icon: android.smallIcon,
            ),
            iOS: const IOSNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
        );
      }
    });
  }
}
