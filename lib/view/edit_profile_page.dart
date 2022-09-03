import 'dart:convert';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart' as modelProgresshub;
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
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
TextEditingController namecontroller   =    TextEditingController();
TextEditingController emailcontroller  =   TextEditingController();
TextEditingController gendercontroller =  TextEditingController();
TextEditingController dobcontroller    =     TextEditingController();
TextEditingController mobilecontroller =  TextEditingController();
final homePageController = Get.find<HomePageController>();
 late String value = homePageController.userDetails['data']['gender'] == 0? "male" :"female";
final items = ['male', 'female'];
DateTime date = DateTime(2000, 01, 01);
// date = FormData(map)
bool showSpinner = false;
  void initState(){
    // TODO: implement initState
    super.initState();
    print("userdetails");
    print(date);
    print(homePageController.userDetails['data']['name']);
    print(homePageController.userDetails);
    namecontroller.text =  homePageController.userDetails['data']['name'];
    emailcontroller.text = homePageController.userDetails['data']['email'];
    gendercontroller.text = homePageController.userDetails['data']['gender'] == null? "Add" :homePageController.userDetails['data']['gender'] == 0? "Male" : "Female";
    if(homePageController.userDetails['data']['mobile'] != null){
    mobilecontroller.text = homePageController.userDetails['data']['mobile'].toString();
    }
    dobcontroller.text = homePageController.userDetails['data']['dob'] == null ? "Select date" :homePageController.userDetails['data']['dob'] ;
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

  Future<void> uploadImage ()async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   String? resetToken = sharedPreferences.getString('reset_token');
   var stream;
   var length;
    print("object");
    print(resetToken);
    print(image);
    print(namecontroller.text);
    print(DateFormat("MM/dd/yyyy").format(date));
    print(mobilecontroller.text.toString());
    print(value);
    print(homePageController.userDetails);

    setState(() {
      showSpinner = true;
    });
    if(image != null){
     stream =http.ByteStream(image!.openRead());
    stream.cast();
     length = await image!.length();
    }
    var uri = Uri.parse('https://tv-talk.hackerkernel.com/api/v1/user/edit-profile');
    var request =  http.MultipartRequest('POST', uri);
    request.fields['name'] = namecontroller.text;
    if(DateFormat("MM-dd-yyyy").format(date) != ""){
      request.fields['dob'] = DateFormat("MM-dd-yyyy").format(date);
    }
    request.fields['gender'] = value == 'male' ?'0' : value == 'female' ?'1': "";
    if(mobilecontroller.text != ""){
    request.fields['mobile'] = mobilecontroller.text;
    }
    request.headers.addAll({'Content-Type': 'application/x-www-form-urlencoded',
    'authorization': 'Bearer ${resetToken!}',
    });
    print("hgsdjk,df");
    // print()
    if(image != null){
          var multiport =  http.MultipartFile(
      "file", 
      stream, 
      length);
      request.files.add(multiport);
      }
      var response = await request.send();
      print("kjdfhsdj");
      if(response.statusCode == 200){
            setState(() {
      showSpinner = false;
      Flushbar(
          backgroundColor: Colors.green,
          message: "Profile updated sucessfully",
          duration: Duration(seconds: 1),
        ).show(context);
    });
        print("image uploaded");
        print(response);
    }
      else{
        // print(response);
        setState(() {
      showSpinner = false;
    });
        print("failed to upload");
    
      }
  }
  @override
  Widget build(BuildContext context) {
    return  modelProgresshub.ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                  child: GestureDetector(
                    onTap: () {
                      uploadImage();
                    },
                    child: Text("Save", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),)),
                )
              ],
            ),
            
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            color:const Color(0xffFFDC5C),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              // image != null?  Container(
                
              //   child: Image.file(image!, height: 100, width: 100,)) : 
                Padding(
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
                        image != null ? ClipOval (child: Container(height: 100, width: 100, child: Image.file(image!,   fit: BoxFit.cover, ))) :const ClipOval( child: Image(height: 100, width: 100, image: NetworkImage("https://image.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg"), fit: BoxFit.cover,)),
                         Positioned(
                          top: 70,
                          left: 70,
                      //  give the values according to your requirement
                       child: InkWell(
                        onTap: () {
                          showImageDialog();
                        },
                         child: Container(
                          height: 30,
                          width: 30,
                          decoration:const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: const Icon(Icons.edit, size: 25)
                          ),
                       ),
            ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height-248,
                  decoration:const BoxDecoration(
                  color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50) )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                           Text("Username", style: TextStyle(
                            color: Colors.grey
                          ),),
                          TextFormField(
                            controller: namecontroller,
                            decoration:const InputDecoration(
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
                          // TextFormField(
                          //   controller: gendercontroller,
                          //   decoration:const InputDecoration(
                          //     hintText: "Add"
                          //   ),
                          //   // controller: ,
                          // ),
                      DropdownButton<dynamic>(
                      underline: Container(height: 0.5, width: MediaQuery.of(context).size.width, color: Colors.black,),
                      items: items.map(buildMenuItem).toList(),
                      iconSize: 36,
                      
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                      value: value,
                      isExpanded: true,
                      onChanged: (val){
                        setState(() {
                          this.value = val;
                        });
                      }),
                          SizedBox(height: 40,),
                          Text("Mobile", style: TextStyle(
                            color: Colors.grey
                          ),),
                          TextFormField(
                            controller: mobilecontroller,
                            decoration: InputDecoration(
                              hintText:mobilecontroller.text == ""? "------":""
                            ),
                            // controller: ,
                          ),
                          const SizedBox(height: 40,),
                         const Text("Date of Birth", style: TextStyle(
                            color: Colors.grey
                          ),),
                          ElevatedButton(
                           style: ElevatedButton.styleFrom(
                              primary: Color(0xffFFDC5C),
                            ),
                            onPressed: ()async{
                             DateTime? newDate = await showDatePicker(
                                context: context, 
                                initialDate: date, 
                                firstDate: DateTime(1900), 
                                lastDate: DateTime(21000),
                                builder: (context, child){
                                  return Theme(
                                    data: ThemeData().copyWith(
                                      colorScheme: ColorScheme.dark(
                                        primary:  Color(0xffFFDC5C),
                                        onPrimary: Colors.black,
                                        surface:  Color(0xffFFDC5C),
                                      ),
                                      dialogBackgroundColor: Colors.black
                                    ), child: child!);
                                }
                                );  
                                if(newDate == null) return;
                                setState(() {
                                  date = newDate;
                                  print("shi date");
                                  print(date);
                                });
                            }, 
                            child: Text(DateFormat("MM-dd-yyyy").format(date)))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
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

        DropdownMenuItem<String> buildMenuItem(String item) =>DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: TextStyle(fontSize: 18),
    ));

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
                                Navigator.pop(context);
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
