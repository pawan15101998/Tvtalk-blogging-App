import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FunAndGames extends StatefulWidget {
  const FunAndGames({Key? key}) : super(key: key);
  @override
  State<FunAndGames> createState() => _FunAndGamesState();
}

class _FunAndGamesState extends State<FunAndGames> {
    final colorconst = ColorConst();

  @override
  Widget build(BuildContext context){
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
      body: Container(
        color: colorconst.mainColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              funAndGames('Quize', "assets/images/quize.png", (){
                context.pushNamed('QUIZES');}),
              const SizedBox(height: 30,),
              funAndGames('Pools', "assets/images/pools.png",(){
                context.pushNamed('POLES');
              }),
              const SizedBox(height: 30,),
              funAndGames('Puzzles', "assets/images/puzzle.png",(){
                context.pushNamed('WEBVIEW');
                // await launchUrl(Uri.parse('https://www.jigsawplanet.com/'));
              }),
              const SizedBox(height: 30,),
              funAndGames('Guess Who', "assets/images/quize.png",(){
                context.pushNamed('QUIZES');
              }),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }

  Widget funAndGames(String name, String image, Ontap){
    return InkWell(
      onTap: Ontap,
      child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image(image: AssetImage(image))),
                          SizedBox(width: 20,),
                        Text(name,style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                   const Icon(Icons.arrow_forward_rounded)
                  ],
                ),
    );
  }
}