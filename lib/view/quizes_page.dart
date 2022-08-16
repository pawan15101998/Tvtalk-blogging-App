import 'package:flutter/material.dart';
import 'package:tvtalk/view/alllquiz_tab_page.dart';
import 'package:tvtalk/view/quiz_already_taken_page.dart';

class QuizesPage extends StatefulWidget {
  const QuizesPage({Key? key}) : super(key: key);

  @override
  State<QuizesPage> createState() => _QuizesPageState();
}

class _QuizesPageState extends State<QuizesPage> with SingleTickerProviderStateMixin {

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
          title: const Text("Quizes",
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
              Text("All Quiz", 
              style: TextStyle(
                color: Colors.black
              ),              
              ),
              Text("Quiz Already Taken",
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
            AllQuizPage(),
            QuizAlreadytakenPage()
          ]
          ),
    );
  }
}