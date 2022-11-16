import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
    final colorconst = ColorConst();

    // final  _controller = WebView();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(80),
        child: Container(
          margin:const EdgeInsets.only(top: 20),
          child: AppBar(title: 
         const Text("Fun & Games"),
          backgroundColor: colorconst.mainColor,
          elevation: 0,
          ),
        ),
      ),
      body: WebView(
    javascriptMode: JavascriptMode.unrestricted,
    initialUrl: "https://www.jigsawplanet.com/",
   ),
    );
    
     
  }
}