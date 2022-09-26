import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tvtalk/services/helper/dependency_injuctor.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notification',
  // 'This channel is used for importance notification',
  importance: Importance.high,
  playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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
}

void configLoading(){
  print("first");
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.values[0]
    ..backgroundColor = Colors.transparent
    ..indicatorSize = 30.0
    ..radius = 0.0
    ..progressColor = Colors.transparent
    ..indicatorColor = Colors.transparent
    ..textColor = Colors.transparent
    ..maskColor = Colors.blue.withOpacity(0.5)
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
    sendNotification();
    
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
              color: Colors.blue,
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
          color: Colors.blue,
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
          primarySwatch: Colors.blue,
        ),
        builder:EasyLoading.init() ,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
