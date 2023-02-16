import 'dart:ffi';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const FCM_SERVER_KEY =
    'AAAAJcvZctE:APA91bGJr3H46xECW4suT0iI3biHkvFrPwzViiZNdgmGgutuPL0FinCqhsfNt19qE2HQoNqnZ4vvDTeaxSP5ReIT-0Zuzg0AReBzS-Y2wtHXAxyMbEU23gxyQRnO8wA5oBDMJ-GzuUBE';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class notifications extends StatefulWidget {
  const notifications({super.key});

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  static Notifications get instance => Notifications();
  static const Map<String, dynamic> DEFAULT_NOTIFICATION_DATA = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'type': 'default',
  };
  Future<String> send(
    // String fcmToken,
    String? title,
    String? body,
    // Map<String, dynamic> data = DEFAULT_NOTIFICATION_DATA,
  ) async {
    /// Sends a notification with the
    /// given title and body to the given
    /// FCM token.
    try {
      http.Response r = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${FCM_SERVER_KEY}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': title.toString(),
              'body': body.toString(),
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': await messaging.getToken(),
          },
        ),
      );

      return r.body;
    } catch (e) {
      return e.toString();
    }
  }

  getMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      print('============== data notification===============');
// Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => const ShowPackage()));

      print("${message.notification!.title}");
      print("${message.notification!.body}");
      print("===============================================");
    });
  }

  void initState() {
    getMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notification'),
      ),
      body: MaterialButton(
        onPressed: () async {
          await send('this is first notification', 'the service is added');
        },
        child: Text('send notification'),
      ),
    );
  }
}

class Notifications {
  /// Handles sending FCM notifications
  /// using Google's FCM api.
  static Notifications get instance => Notifications();
  static const Map<String, dynamic> DEFAULT_NOTIFICATION_DATA = {
    'click_action': 'FLUTTER_NOTIFICATION_CLICK',
    'type': 'default',
  };
  Future<String> send(
    String fcmToken, {
    String? title,
    String? body,
    //Map<String, dynamic> data = DEFAULT_NOTIFICATION_DATA,
  }) async {
    /// Sends a notification with the
    /// given title and body to the given
    /// FCM token.
    try {
      http.Response r = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${FCM_SERVER_KEY}',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'title': title.toString(),
              'body': body.toString(),
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            },
            'to': await messaging.getToken(),
          },
        ),
      );

      return r.body;
    } catch (e) {
      return e.toString();
    }
  }
  
}
