

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}
final signincontroller = Get.find<SignInController>();
class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          margin: EdgeInsets.only(top: 25),
          child: AppBar(
            backgroundColor: Color(0xffFFDC5C),
            elevation: 0,
            centerTitle: true,
            title:const Text("Profile"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    context.pushNamed('EDITPROFILE');
                  },
                  child: Text("Edit", style: TextStyle(color: Colors.black),)),
              )
            ],
          ),
          
        ),
      ),
      body: Container(
        color: Color(0xfffFFDC5C),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage("https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",),fit: BoxFit.cover,),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-248,
              decoration: BoxDecoration(
              color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50) )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Username", style: TextStyle(
                      color: Colors.grey
                    ),),
                    Text("Anwar zeb", style: TextStyle(
                    fontSize: 18
                    ),),
                    SizedBox(height: 40,),
                    Text("Email Adress", style: TextStyle(
                      color: Colors.grey
                    ),),
                    Text("Anwarzeb25@mail.com", style: TextStyle(
                    fontSize: 18
                    ),),
                    SizedBox(height: 40,),
                    Text("Gender", style: TextStyle(
                      color: Colors.grey
                    ),),
                    Text("Male", style: TextStyle(
                    fontSize: 18
                    ),),
                     SizedBox(height: 40,),
                    Text("Date of Birth", style: TextStyle(
                      color: Colors.grey
                    ),),
                    Text("10/14/1997", style: TextStyle(
                    fontSize: 18
                    ),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
    // Scaffold(
    //   appBar: AppBar(
    //     iconTheme: const IconThemeData(color: Colors.black),
    //     toolbarHeight: 40.0,
    //     elevation: 0,
    //     // automaticallyImplyLeading: false,
    //     backgroundColor: Color(0xfffFFDC5C),
    //     title: const Text(
    //       "My Profile",
    //       style: TextStyle(color: Colors.black, fontSize: 20),
    //     ),
    //     actions: const [
    //       Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 10),
    //         child: Icon(Icons.edit),
    //       )
    //     ],
    //   ),
    //   body: Stack(
    //     alignment: Alignment.topCenter,
    //     children: [
    //       Container(
    //         height: MediaQuery.of(context).size.height / 6,
    //         width: MediaQuery.of(context).size.width,
    //         color: Color(0xfffFFDC5C),
    //       ),
    //       Align(
    //         alignment: Alignment.bottomCenter,
    //         child: SizedBox(
    //             height: MediaQuery.of(context).size.height * 75 / 100,
    //             width: MediaQuery.of(context).size.width,
    //             child: Column(
    //               children: [
    //                 const SizedBox(
    //                   height: 55,
    //                 ),
    //                  Text(
    //                   signincontroller.userName.toString(),
    //                   style: TextStyle(fontSize: 18),
    //                 ),
    //                 const SizedBox(
    //                   height: 30,
    //                 ),
    //                 Container(
    //                   height: MediaQuery.of(context).size.height * 50 / 100,
    //                   width: MediaQuery.of(context).size.width * 90 / 100,
    //                   decoration: BoxDecoration(
    //                     border: Border.all(),
    //                   ),
    //                   child: Column(
    //                     children: [
    //                       details(context, "Email", signincontroller.userEmail.toString()),
    //                       const Divider(),
    //                       details(context, "Mobile Number", "987 654 3210"),
    //                       const Divider(),
    //                       details(context, "D. O. B.", "15.08.1947"),
    //                       const Divider(),
    //                       details(context, "Gender", "Male"),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             )),
    //       ),
    //       Positioned(
    //           top: 90,
    //           child: Container(
    //             height: 100,
    //             width: 100,
    //             decoration:  BoxDecoration(
    //                 image: DecorationImage(
    //                     image: signincontroller.image != null ?
    //                     NetworkImage(
    //                               signincontroller.image.toString()):
    //                      NetworkImage(
    //                             "https://szabul.edu.pk/dataUpload/863noimage.png"),
    //                     fit: BoxFit.cover),
    //                 shape: BoxShape.circle),
    //           )),
    //     ],
    //   ),
    // );
  }

  // Container details(BuildContext context,String content, String contentName) {
  //   return Container(
  //     height: MediaQuery.of(context).size.height / 9.3,
  //     // color: Colors.blue,
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: Column(
  //         children: [
  //           SizedBox(height: MediaQuery.of(context).size.height/30,),
  //           Align(
  //             alignment: Alignment.center,
  //             child: Text(   
  //               content,
  //               textAlign: TextAlign.center,
  //               style: TextStyle(fontSize: 14, fontWeight:FontWeight.w600 ),
  //             ),
  //           ),
  //           Text(
  //             contentName,
  //             style:TextStyle(fontSize: 14, fontWeight:FontWeight.w600 ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
