
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:tvtalk/main.dart';
import 'package:tvtalk/model/get_comment_model.dart';
import 'package:tvtalk/routers.dart';
import 'package:tvtalk/utils.dart';
import 'package:go_router/go_router.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void notificationTapBackground() {}

class HelperNotification {
  // final details =
//   Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
//   await Firebase.initializeApp();
//   print("A abackground message just show up ${message.messageId}");
// }

  customInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        // s,,s,s
      },
    );
    final LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print("onDidReceiveNotificationResponse");
        print(notificationResponse.actionId);
        print(notificationResponse.id);
        print(notificationResponse.input);
        print(notificationResponse.notificationResponseType);
        print(notificationResponse.payload);
      },
      onDidReceiveBackgroundNotificationResponse: (details) {
        print("onDidReceiveBackgroundNotificationResponse");
        print(details);
        
      },
    );
  }

  setForegroundNotificationPresentationOptions() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }

  firebaseOnMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage Listner");
      print(message.data['url']);
      // print(message.data[0]);
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    // channel.description,
                    color: colorconst.blueColor,
                    importance: Importance.max,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                    largeIcon: FilePathAndroidBitmap(await Utils.downloadFile(
                            'https://tv-talk.hackerkernel.com/assets/images/${message.data['url']}',
                            'largeIcon')),
                    // styleInformation: BigPictureStyleInformation(
                    //     FilePathAndroidBitmap(await Utils.downloadFile(
                    //         'https://tv-talk.hackerkernel.com/assets/images/${message.data['url']}',
                    //         'largeIcon')),
                          
                    //     largeIcon: FilePathAndroidBitmap(await Utils.downloadFile(
                    //         'https://assets-prd.ignimgs.com/2022/03/09/pubgbattlegrounds-1646861967387.jpg',
                    //         'bigPicture'))
                    //         )
                            )));
      }
    });
  }

  onMessageOpenedApp(context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("A new noMessageOpenApp event was published");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      flutterLocalNotificationsPlugin;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(notification.body!)],
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/1000-Sister.png"))),
                      )
                    ],
                  ),
                ),
              );
            });
      }
      // context.pushNamed('SETTING');
    });
  }
}
