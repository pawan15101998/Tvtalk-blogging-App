import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tvtalk/services/helper/dependency_injuctor.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configLoading();
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
    print("lastt");
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
