import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black
          ),
          toolbarHeight: 80.0,
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor:  Color(0xfffFFDC5C),
          title: const Text("Poles",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20
          ),
          ),
          bottom: TabBar(
            controller: quizTabController,
            indicatorColor: Colors.white,
            indicatorWeight: 5,  
            indicatorPadding: EdgeInsets.only(bottom: 1),
            // indicatorWeight: 1,
            tabs: const [
              Text("All Polls", 
              style: TextStyle(
                color: Colors.black
              ),              
              ),
              Text("Polls Already Done",
              style: TextStyle(
                color: Colors.black
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