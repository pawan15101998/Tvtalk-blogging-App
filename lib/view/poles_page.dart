import 'package:flutter/material.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/view/Pools_done_page.dart';
import 'package:tvtalk/view/all_polls.dart';
import 'package:tvtalk/view/alllquiz_tab_page.dart';
import 'package:tvtalk/view/quiz_already_taken_page.dart';

class Poles extends StatefulWidget {
  const Poles({Key? key}) : super(key: key);

  @override
  State<Poles> createState() => _PolesState();
}

class _PolesState extends State<Poles> with SingleTickerProviderStateMixin {

   late TabController quizTabController;
     @override
  void initState() {
    super.initState();
    quizTabController = TabController(vsync: this, length: 2);
  }

 @override
 void dispose() {
   quizTabController.dispose();
   super.dispose();
 }
   final colorconst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          iconTheme:  IconThemeData(
            color: colorconst.blackColor
          ),
          toolbarHeight: 80.0,
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor:  colorconst.mainColor,
          title:  Text("Poles",
          style: TextStyle(
            color: colorconst.blackColor,
            fontSize: 20
          ),
          ),
          bottom: TabBar(
            controller: quizTabController,
            indicatorColor: colorconst.whiteColor,
            indicatorWeight: 5,  
            indicatorPadding: EdgeInsets.only(bottom: 1),
            // indicatorWeight: 1,
            tabs:  [
              Text("All Polls", 
              style: TextStyle(
                color: colorconst.blackColor
              ),              
              ),
              Text("Polls Already Done",
              style: TextStyle(
                color: colorconst.blackColor
              ), 
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: quizTabController,
          children: [
            AllPolls(),
            PollsDone()
          ]
          ),
    );
  }
}