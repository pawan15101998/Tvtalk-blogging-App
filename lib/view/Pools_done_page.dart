
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tvtalk/constant/color_const.dart';

class PollsDone extends StatelessWidget {
   PollsDone({Key? key}) : super(key: key);
  

  @override
    final colorconst = ColorConst();
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            advertisment(context),
            polls(context),
            advertisment(context),
            polls(context),
            advertisment(context),
            polls(context),
            advertisment(context),
          ],
        ),
      ),
    );
  }

  Widget polls(BuildContext context){
    return Column(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height*50/100,
          width: MediaQuery.of(context).size.width*90/100,
          decoration: BoxDecoration(
            border: Border.all(color: colorconst.greyColor),
            // color: colorconst.blackColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Poll #12345",
                style: TextStyle(
                  color: colorconst.greyColor
                ),
                ),
                SizedBox(height: 10,),
                Text(
                  "Bright vixens jump; dozy fowl quack. Wafting for zephyrs vex bold Jim.",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                SizedBox(height: 10,),
                option(context),
                option(context),
                option(context),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget option(context){
    return Column(
          children: [
            Container(
              // width: MediaQuery.of(context).size.width*90/100,
              decoration: BoxDecoration(
                border: Border.all(color: colorconst.greyColor),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const[
                        Text(
                          "A."
                        ),
                        Text("Yes"),
                      ],
                    ),
                    Column(
          children: const [
            Text(
              "60% (11.5k)"
            ),
            Text(
              "CHOOSE THIS"
            )
          ],
        )
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10,)
          ]
        );
        
      
  }


   Widget advertisment(context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 12 / 100,
            width: MediaQuery.of(context).size.width * 90 / 100,
            color:  colorconst.blackColor,
            child:  Align(
              alignment: Alignment.center,
              child: Text(
                "This is a very catchy title as it is an advertise.",
                style:TextStyle(color: colorconst.blackColor),
              ),
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }

}