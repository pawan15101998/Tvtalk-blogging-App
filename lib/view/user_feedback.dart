
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/theme/theme.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';

class userFeedback extends StatefulWidget {
  const userFeedback({Key? key}) : super(key: key);

  @override
  State<userFeedback> createState() => _userFeedbackState();
}

class _userFeedbackState extends State<userFeedback> {
  var fontSize = AdaptiveTextSize();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final signincontroller = Get.find<SignInController>();
  final colorconst = ColorConst();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = signincontroller.userName!;
    emailController..text = signincontroller.userEmail!;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
        child: AppBar(
          iconTheme: IconThemeData(
            color: colorconst.blackColor
          ),
          toolbarHeight: 120.0,
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: colorconst.mainColor,
          title:  Text("Feedback",
          style: TextStyle(
            color: colorconst.blackColor,
            fontSize: 20
          ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textField(context,  "Name", nameController, 45, null),
              const SizedBox(height: 20,),
              textField(context, "email", emailController, 45, null),
              const SizedBox(height: 20,),
              textField(context, "Message", messageController, 100, 200),
              const SizedBox(height: 20,),
               SizedBox(
                width: MediaQuery.of(context).size.width*70/100,
                height: MediaQuery.of(context).size.width*10/100,
                 child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(colorconst.mainColor,),
            ),
            onPressed: () async{
            final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
            String? userid = sharedPreferences.getString('userId');
              if(messageController.text == ""){
                Flushbar(
                 backgroundColor: colorconst.redColor,
                message: "Please fill Feedback form",
                  duration: Duration(seconds: 1),
                ).show(context);
              }else{
               await  apiprovider.postApi("/user/feedback", {
                  "userId": userid,
                  "name": signincontroller.userName,
                  "emailId": signincontroller.userEmail,
                  "message":messageController.text
                });
                if(apiprovider.RegisterResponse['message'] == 'Feedback submitted successfully'){
                // Flushbar(
                //  backgroundColor: colorconst.greenColor,
                // message: "Feedback submitted successfully",
                //   duration: Duration(seconds: 1),
                // ).show(context);
                messageController.clear();
                showDialog(context: context, 
                barrierDismissible: false,
                builder: ((context) => AlertDialog(
                title: Text("Feedback submitted successfully"),
                //  content:Text("data"),
            actions:[
              // FlatButton(
              //   child: Text("okBtnText"),
              //   onPressed: (){},
              // ),
              // FlatButton(
              //     child: Text("Ok"),
              //     onPressed: () => context.goNamed('HOMEPAGE'))
            ],
          )
                ));
                // context.pushNamed('HOMEPAGE');
                }else{
                  Flushbar(
                 backgroundColor: colorconst.redColor,
                message: "Something Went wrong",
                  duration: Duration(seconds: 1),
                ).show(context);
                }
              }
            },
            child:  Text('Submit', style: TextStyle(
              color: colorconst.blackColor
            ),),
          ),
               ),
            ],
          ),
        ),
      ),
      )
      );
  }

  Widget textField(BuildContext context, String name , TextEditingController controller, int height, var maxlength){
    return Container(
            width: MediaQuery.of(context).size.width * 90 / 100,
            // height: MediaQuery.of(context).size.width * 40 / 100,
            height: fontSize.getadaptiveTextSize(context, height),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: TextFieldColor),
            child: TextFormField(
                obscureText: false,
                maxLength: maxlength,
                // maxLines: maxline,
                controller:controller,
                decoration: InputDecoration(
                    fillColor: const Color(0xffFEDC5D),
                    border: InputBorder.none,
                    label: Text(name),
                    // suffixIcon:
                        // textfieldLogic.sufixIcon(widget.textName, _passwordVisible)
                        )
                        ),
                );
  }
}