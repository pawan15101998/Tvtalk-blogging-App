import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/theme/appbar.dart';

class EnterQuizPage extends StatefulWidget {
  const EnterQuizPage({Key? key}) : super(key: key);

  @override
  State<EnterQuizPage> createState() => _EnterQuizPageState();
}

class _EnterQuizPageState extends State<EnterQuizPage> {
var fontSize = const AdaptiveTextSize();
final colorconst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context, "Quiz Name"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              advertisment(context),
              question(context),
            ],
          ),
        ),
      ),
    );
  }

 Widget question(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height*50/100,
          width: MediaQuery.of(context).size.width * 90 / 100,
          decoration: BoxDecoration(
            border: Border.all(color: colorconst.greyColor),
            // color: colorconst.blackColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              //  const Text(
              //     "Poll #12345",
              //     style: TextStyle(color: colorconst.greyColor),
              //   ),
              // const  SizedBox(
              //     height: 10,
              //   ),
               const Text(
                  "Bright vixens jump; dozy fowl quack. Wafting for zephyrs vex bold Jim.",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Image.network("https://media.istockphoto.com/photos/quiz-time-concept-speech-bubble-with-pencil-on-yellow-background-picture-id1268465415?k=20&m=1268465415&s=612x612&w=0&h=dzRhC8EPw1bZTIDzxc0416FaL8IF71RCPNjBlYUgzQA="),
               const SizedBox(
                  height: 20,
                ),
                option(context),
                option(context),
                option(context),
                Row(
children : <Widget>[
  Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(colorconst.redColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (Set<MaterialState> states) {
            return const EdgeInsets.all(16);
          },
          )
        ),
              onPressed: () {},
              child: const Text("End Quiz")
             ),
    )),
         const SizedBox(width: 5,),
Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          shadowColor: MaterialStateProperty.all(colorconst.transparentColor),
          backgroundColor: MaterialStateProperty.all<Color>(colorconst.transparentColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: BorderSide(color: colorconst.blackColor)
            )
          ),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (Set<MaterialState> states) {
            return const EdgeInsets.all(16);
          },
          )
        ),
              onPressed: () {},
              child: Text("Previous", style: TextStyle(
                color: colorconst.blackColor
              ),)
             ),
    )),
    const SizedBox(width: 5,),

Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(colorconst.blackColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
          padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
            (Set<MaterialState> states) {
            return const EdgeInsets.all(16);
             },
            )
           ),
              onPressed: () {},
              child: const Text("Next")
             ),
               )),
              ])
              ],
            ),
          ),
        ),
      const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget option(context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 90 / 100,
          decoration: BoxDecoration(
              border: Border.all(color:  colorconst.greyColor),
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("A."),
                    Icon(Icons.check_circle_rounded)
                  ],
                ),
                const Text("Yes"),
                Image.network("https://us.123rf.com/450wm/soifer/soifer1809/soifer180900063/110272407-quiz-time-neon-sign-vector-quiz-pub-design-template-neon-sign-light-banner-neon-signboard-nightly-br.jpg?ver=6")
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

    Widget advertisment(context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 12 / 100,
            width: MediaQuery.of(context).size.width * 90 / 100,
            color: colorconst.blackColor,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "This is a very catchy title as it is an advertise.",
                style: TextStyle(color: colorconst.whiteColor),
              ),
            ),
          ),
         const  SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}