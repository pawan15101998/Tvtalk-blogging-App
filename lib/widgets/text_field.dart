import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/controllers/textField_logic.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
// import 'package:tvtalk/network/textField_logic.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/theme/theme.dart';

class HomePageTextField extends StatefulWidget {
  HomePageTextField(
      {Key? key,
      required this.width,
      required this.textName,
      required this.controller
      // required this.textSize,
      })
      : super(key: key);

  final double width;
  String textName;
  TextEditingController controller;

  @override
  State<HomePageTextField> createState() => _HomePageTextFieldState();
}

class _HomePageTextFieldState extends State<HomePageTextField> {
  var textSize = AdaptiveTextSize();
  var passwordController = Get.find<SignInController>();
  late bool _passwordVisible;
  var textfieldLogic = TextFieldLogic();
   sufixIcon(ontap) {
    if (widget.textName == "Password" ||
        widget.textName == "Confirm Password" ||
        widget.textName == "New Password") {
      return IconButton(
        icon: Icon(
        (passwordController.passwordVisiblity.value && (widget.textName == 'Password' || widget.textName == "New Password"))
         ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: ontap,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Container(
          width: widget.width * 90 / 100,
          height: textSize.getadaptiveTextSize(context, 45),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: TextFieldColor),
          child: TextFormField(
              obscureText:
                  textfieldLogic.obscureText(widget.textName, passwordController.passwordVisiblity.value),
              controller: widget.controller,
              decoration: InputDecoration(
                  fillColor: const Color(0xffFEDC5D),
                  border: InputBorder.none,
                  label: Text(widget.textName),
                  suffixIcon:sufixIcon(
                    (){
                      if(widget.textName == 'Password'){
                      passwordController.passwordVisiblity.toggle();
                      }else if(widget.textName == 'confirm Password'){
                      passwordController.cnfpasswordVisiblity.toggle();
                      }else if(widget.textName == 'New Password'){
                      passwordController.passwordVisiblity.toggle();
                      }
                      print("toggle");
                    }
                    )
                      // textfieldLogic.sufixIcon(widget.textName, _passwordVisible)
                      )
                      ),
        ));
  }
}
