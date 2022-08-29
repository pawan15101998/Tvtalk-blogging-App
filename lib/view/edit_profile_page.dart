

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/view/dialog/select_image.dart';

class Editprofilepage extends StatefulWidget {
  const Editprofilepage({Key? key}) : super(key: key);


  @override
  State<Editprofilepage> createState() => _EditprofilepageState();
}



class _EditprofilepageState extends State<Editprofilepage> {
  @override
  File? image;
final signincontroller = Get.find<SignInController>();
TextEditingController namecontroller = TextEditingController();
TextEditingController emailcontroller =  TextEditingController();
TextEditingController gendercontroller =  TextEditingController();
TextEditingController dobcontroller =  TextEditingController();
DateTime date = DateTime(2002, 02, 02);
  void initState() {
    // TODO: implement initState
    super.initState();

    namecontroller.text =  signincontroller.userName.toString();
    emailcontroller.text = signincontroller.userEmail.toString();
  }

Future pickimage()async{
  try {
  final image =  await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image == null) return;
  final imageTemporary = File(image.path);
      setState(() {
      this.image = imageTemporary;
    });
} on Exception catch (e) {
  // TODO
  print("Fail to pick image $e");
}
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Container(
          margin: EdgeInsets.only(top: 25),
          child: AppBar(
            backgroundColor:Color(0xffFFDC5C),
            elevation: 0,
            centerTitle: true,
            title:const Text("Profile"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Save", style: TextStyle(color: Colors.black),),
              )
            ],
          ),
          
        ),
      ),
      body: Container(
        color:const Color(0xffFFDC5C),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          // image != null?  Container(
            
          //   child: Image.file(image!, height: 100, width: 100,)) : 
            InkWell(
              onTap: (){
                print("object");
              showImageDialog();
              print("ct");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration:const BoxDecoration(
                    color: Colors.red,
                  shape: BoxShape.circle,
                  // image: DecorationImage(
                  //   image:  NetworkImage("https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg",),fit: BoxFit.cover,),
                  ),
                  child:Stack(
                    children: [
                      image != null ? ClipOval(child: Image.file(image!, height: 100, width: 100, fit: BoxFit.cover, )) : ClipOval(child: Image(image: NetworkImage("https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"), fit: BoxFit.cover,)),
                       Positioned(
                        top: 50,
                        // right: 0,
                        left: 50,
                     //give the values according to your requirement
                     child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                      child: Icon(Icons.edit, size: 25)),
        ),
                    ],
                  ),
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
                  children:  [
                     Text("Username", style: TextStyle(
                      color: Colors.grey
                    ),),
                    TextFormField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        // hintText: "jk"
                      ),
                      // controller: ,
                    ),
                    SizedBox(height: 40,),
                    Text("Email Adress", style: TextStyle(
                      color: Colors.grey
                    ),),
                    TextFormField(
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        // hintText: ""
                      ),
                      // controller: ,
                    ),
                    SizedBox(height: 40,),
                    Text("Gender", style: TextStyle(
                      color: Colors.grey
                    ),),
                    TextFormField(
                      decoration:const InputDecoration(
                        hintText: "Add"
                      ),
                      // controller: ,
                    ),
                    const SizedBox(height: 40,),
                   const Text("Date of Birth", style: TextStyle(
                      color: Colors.grey
                    ),),
                    ElevatedButton(
                      onPressed: ()async{
                       DateTime? newDate = await showDatePicker(
                          context: context, 
                          initialDate: date, 
                          firstDate: DateTime(1900), 
                          lastDate: DateTime(21000));
                          if(newDate == null) return;
                          setState(() {
                            date = newDate;
                          });
                      }, 
                      child: Text(date.toString()))
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

    void showImageDialog() {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (BuildContext context, _, __) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: IntrinsicHeight(
                  child: Container(
                    width: double.maxFinite,
                    clipBehavior: Clip.antiAlias,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                         ElevatedButton(
                          onPressed: pickimage, 
                         child: Text("Select from gallary")),
                          const SizedBox(height: 16),
                         ElevatedButton(onPressed: () {
                           setState(() {
                                                            
                                });
                         }, 
                         child: Text("Select from gallary")),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}
