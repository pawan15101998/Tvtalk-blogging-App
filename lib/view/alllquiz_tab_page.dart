import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllQuizPage extends StatefulWidget {
  const AllQuizPage({Key? key}) : super(key: key);

  @override
  State<AllQuizPage> createState() => _AllQuizPageState();
}

class _AllQuizPageState extends State<AllQuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Column(
        children: [
          SizedBox(height: 20,),
          SingleQuiz(),
          SingleQuiz(),
          SingleQuiz(),
          SingleQuiz(),
          SingleQuiz(),
          SingleQuiz(),
          SingleQuiz(),
          SingleQuiz(),
        ],
       ),
     ),
    );
  }

  Widget SingleQuiz(){
    return  Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height:MediaQuery.of(context).size.height*18/100,
          width: MediaQuery.of(context).size.width*25/100,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/allquizimage.png", ),fit: BoxFit.cover)
          ),
        ),
        Container(
          // padding: const EdgeInsets.all(16.0),
          //  width: c_width,
          height:MediaQuery.of(context).size.height*18/100,
          width: MediaQuery.of(context).size.width-150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quiz",
                    style: TextStyle(
                      color: Color(0xfffF1B142),
                      fontSize: 14
                    ),
                  ),
                  // SizedBox(width: 100,),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Share",
                          style: TextStyle(
                            color: Color(0xfff707070)
                          ),
                        ),
                        Icon(Icons.share)
                      ],
                    ),
                  )
                ],
              ),
              const Expanded(
                child: Text( 
                  "Bright vixens jump; dozy fowl quack. Wafting for zephyrs vex bold Jim, ",
                  overflow:TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                  ),
                ),
              ), 
              SizedBox(
                width: double.infinity-50,
                height: MediaQuery.of(context).size.height*5/100,
                child: ElevatedButton(
                  onPressed: (){}, 
                  child: Text("Take the Quiz",
                  style: TextStyle(
                    fontWeight: FontWeight.w100
                  ), 
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xfff000000)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                ),
          ))
                  ),
              )
            ],
          ),
        )
      ],
    ),
  );
  }
}