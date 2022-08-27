import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInProvider extends ChangeNotifier{
  
  final googleSignIn = GoogleSignIn(scopes:  ['email',"https://www.googleapis.com/auth/user.birthday.read", 'https://www.googleapis.com/auth/user.phonenumbers.read', "https://www.googleapis.com/auth/userinfo.profile"]);
  var _user;
   get user => _user;
  var facebookdata;
  Future googleLogin() async{
    try {
      // EasyLoading.show(status: 'loading');
  final googleUser = await googleSignIn.signIn();
  if(googleUser == null) return;
  _user = googleUser; 
  final googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
  // EasyLoading.dismiss();
  print("jdhsdjsbfhs");
  // print(googleSignIn.currentUser?.authHeaders);
  // final header = await googleSignIn.currentUser!.authHeaders;
  // final r = await http.get(Uri.parse("https://people.googleapis.com/v1/people/me?personFields=genders&key="), headers: { "Authorization": header["Authorization"]! } );
  // final response = json.decode(r.body);   
  // print("dhsgdgsahdch");
  // print(response["genders"][0]["formattedValue"]);
} on Exception catch (e) {
  // TODO
  EasyLoading.dismiss();
  print("Error from GoogleSignInPage");
  print(e.toString());
}
  notifyListeners();
}

  // Future<String> getGender() async {
  //   final headers = await googleSignIn.currentUser!.authHeaders;
  //   final r = await http.get(Uri.parse("https://people.googleapis.com/v1/people/me/connections''?requestMask.includeField=person.names"),
  //     headers: {
  //       "Authorization": headers["Authorization"]!
  //     }
  //   );
  //   print("r.body");
  //   print(r.body);
  //   final response = json.decode(r.body);
  //   print("dob");
  //   print(response["genders"][0]["formattedValue"]);
  //   return response["genders"][0]["formattedValue"];
  // }

    facebookLogin()async{
    print("FaceBook");
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email', 'user_birthday'], );
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        _user = userData;
        // print("facebook user data");
        // print(userData);
        // print(userData['name']);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future logout() async{
   await googleSignIn.disconnect();
   await FirebaseAuth.instance.signOut();
    print("google logout");
    print(user);
    //  Router.neglect(context, () {
                      // context.goNamed('SIGNINPAGE');
                    // });
    // FacebookAuth.instance.logOut();
  }
}