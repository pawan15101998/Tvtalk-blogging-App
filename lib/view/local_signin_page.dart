import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/view/home_page.dart';
import 'package:tvtalk/view/signIn_screen.dart';

class LocalSignPage extends StatefulWidget {
  const LocalSignPage({Key? key}) : super(key: key);

  @override
  State<LocalSignPage> createState() => _LocalSignPageState();
}

class _LocalSignPageState extends State<LocalSignPage> {
  var SocialSignin = GoogleSignInProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
       
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something Went wrong'),
              );
            } else if (snapshot.hasData) {
        
              return HomePage();
            } else {
              return SignInPage();
            }
          }),
    );
  }
}
