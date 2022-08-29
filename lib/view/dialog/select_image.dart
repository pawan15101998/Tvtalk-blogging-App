
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tvtalk/widgets/text_field.dart';

class SelectImageDialog {
  File? image;
  Future pickimage()async{
  final image =  await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image == null) return;
  final imageTemporary = File(image.path);
  // print()
  }
  void showImageDialog(BuildContext context) {
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
                          //  setState(() {
                                                            
                          //       });
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