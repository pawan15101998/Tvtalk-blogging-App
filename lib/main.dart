import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/admob_service.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:tvtalk/services/helper/dependency_injuctor.dart';
import 'package:tvtalk/services/helper/helper_notification.dart';
import 'package:tvtalk/services/helper/helper_notification.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notification',
  // 'This channel is used for importance notification',
  importance: Importance.high,
  playSound: true);

final colorconst = ColorConst();
final helpernotification = HelperNotification();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("A abackground message just show up ${message.messageId}");
}
Future main() async{
  // scary maze
  WidgetsFlutterBinding.ensureInitialized();
  AdMobService.initilized();
  helpernotification.customInit();
  MobileAds.instance.initialize(); 
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.
  resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.
  createNotificationChannel(channel);

  helpernotification.setForegroundNotificationPresentationOptions();

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
    helpernotification.onMessageOpenedApp(context);
    helpernotification.firebaseOnMessage();
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

// static Future _notificationDetails() async{
//   final largeIconPath = await
// }

  int _counter = 0;
    final Styleinformation = const BigPictureStyleInformation(
    FilePathAndroidBitmap("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDuE2ejpy-CjPVNdAhuIVch-8DRr20pvVwxs2pBWtl&s"),
    largeIcon: FilePathAndroidBitmap('https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300'),
  );

  // void sendNotification()async{
  //   setState(() {
  //     _counter++;
  //   });
  //   flutterLocalNotificationsPlugin.show(
  //     0,
  //     "Testing $_counter",
  //     "How are you",
  //     NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         channel.id,
  //         channel.name,
  //         importance: Importance.high,
  //         color: colorconst.blueColor,
  //         playSound:  true,
  //         icon: '@mipmap/ic_launcher',
  //         styleInformation: Styleinformation
  //         )
  //     )
  //   );
  //   String? token = await FirebaseMessaging.instance.getToken();
  //   print("token is hear");
  //   print(token);
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
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
          primarySwatch: Colors.blue,
          // materialTapTargetSize: 
        ),
        builder:EasyLoading.init() ,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
