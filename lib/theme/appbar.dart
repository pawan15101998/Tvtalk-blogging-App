import 'package:flutter/material.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
      var fontSize = AdaptiveTextSize();

  final colorconst = ColorConst();

appbar(context,  name){
  return  PreferredSize(
    preferredSize: Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
    child: AppBar(
            iconTheme: IconThemeData(
              color: colorconst.blackColor
            ),
            toolbarHeight: 120.0,
            elevation: 0,
            // automaticallyImplyLeading: false,
            backgroundColor: colorconst.mainColor,
            title: Text(name,
            style: TextStyle(
              color: colorconst.blackColor,
              fontSize: 20
            ),
            ),
          ),
  );
}