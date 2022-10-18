import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tvtalk/services/helper/dependency_injuctor.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notification',
  // 'This channel is used for importance notification',
  importance: Importance.high,
  playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final colorconst = ColorConst();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("A abackground message just show up ${message.messageId}");
}


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.
  resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.
  createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  // configLoading();
  DependencyInjuctor.initializeController();
  runApp(MyApp());
  print("easy");
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
}

void configLoading(){
  print("first");
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.values[0]
    ..backgroundColor = colorconst.transparentColor
    ..indicatorSize = 30.0
    ..radius = 0.0
    ..progressColor = colorconst.transparentColor
    ..indicatorColor = colorconst.transparentColor
    ..textColor = colorconst.transparentColor
    ..maskColor = colorconst.blueColor.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    // print("lastt");
    // ..customAnimation = CustomAnimation();
}

class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   final router = CustomRouter();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();    
    // showNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if(notification != null &&  android !=  null){
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // channel.description,
              color: colorconst.blueColor,
              playSound: true,
              icon: '@mipmap/ic_launcher'
            )
          )
          );
      }
     });
     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print("A new noMessageOpenApp event was published");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if(notification != null && android != null){
        showDialog(
          context: context, 
          builder: (_){
            return AlertDialog(
              title: Text(notification.title!),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.body!)
                  ],
                ),
              ),
            );
          }); 
      }
     });
  }
 
//  Future<void> _createDynamicLink(bool short) async{
//   setState(() {
//     _iscreatingLink = true;
//   });

//    final DynamicLinkParameters parameters = DynamicLinkParameters(
//     link: Uri.parse("https://tvtalk.page.link/helloworld"), 
//     uriPrefix: "https://tvtalk.page.link",
//     androidParameters: AndroidParameters(
//       packageName: "com.example.tvtalk",
//       minimumVersion: 0
//     ),
//     iosParameters: IOSParameters(
//       bundleId: "",
//       minimumVersion: "0",
//     ),
//     // dynamicLinkParametersOptions: dynamicLinkParametersOptions(
//     //   ShortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
//     // ),
//     socialMetaTagParameters: SocialMetaTagParameters(
//       title: "The Title Of the Dynamic Link Says Hello World",
//       description: "This is a random Description just say hello world"
//     )
//     );
//     Uri url;
//     if(short){
//       final ShortDynamicLink shotLink = await parameters.buildShortLink();
//       print(shotLink.toString());
//       url = shotLink.shortUrl;
//     }else{
//       url = await parameters.buildUrl();
//     }
//     setState(() {
//       _linkMessage = url.toString();
//       _iscreating = false;
//     });
//       // Uri shortLink = await parameters.buildShortLink();
//  }

  int _counter = 0;

  void sendNotification()async{
    setState(() {
      _counter++;
    });
    flutterLocalNotificationsPlugin.show(
      0,
      "Testing $_counter",
      "How are you",
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          importance: Importance.high,
          color: colorconst.blueColor,
          playSound:  true,
          icon: '@mipmap/ic_launcher'
          )
      )
    );
    String? token = await FirebaseMessaging.instance.getToken();
    print("token is hear");
    print(token);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> GoogleSignInProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        // routeInformationProvider: router.goRouter.routeInformationProvider,
        routerDelegate: router.goRouter.routerDelegate,
        routeInformationParser: router.goRouter.routeInformationParser,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Poppins',
          primarySwatch: colorconst.blueColor,
        ),
        builder:EasyLoading.init() ,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
