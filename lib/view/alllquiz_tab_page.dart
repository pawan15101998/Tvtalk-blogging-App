import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/constant/color_const.dart';

class AllQuizPage extends StatefulWidget {
  const AllQuizPage({Key? key}) : super(key: key);

  @override
  State<AllQuizPage> createState() => _AllQuizPageState();
}

class _AllQuizPageState extends State<AllQuizPage> {
    final urlImages = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png'
  ];
  final colorconst = ColorConst();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Column(
        children: [
          SizedBox(height: 20,),
          CarouselSlider.builder(
                            options: CarouselOptions(
                                height: 220.0,
                                viewportFraction: 0.9,
                                // autoPlay: true,
                                onPageChanged: ((index, reason){
                                  // homePage1 = index;
                                  // homepage2Controller.sliderHome2Latest.value =
                                      index;
                              })),
                            itemCount: urlImages.length,
                            itemBuilder: ((context, index, realIndex) {
                              final urlImage = urlImages[index];
                              return buildLatestImage(urlImage, index);
                            }),
                      ),
                       const SizedBox(
                          height: 32,
                        ),
                      //  Obx((){
                      //      return
                            buildIndicatorLatest(),
                      //    }
                      //  ),
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

  Widget buildIndicatorLatest() {
      return AnimatedSmoothIndicator(
        activeIndex: 5,
        count: 4,
        effect: JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: colorconst.blackColor),
      );
    }

      Widget buildLatestImage(String image, int index) {
      return Stack(
        children: [
        Container(
          margin:const EdgeInsets.symmetric(horizontal: 12),
          height: 300,
          decoration: BoxDecoration(
              color: colorconst.redColor,
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
        ),
         Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "quiz",
                style: TextStyle(color: colorconst.lightYellow),
              )),
        ),

        Padding(
          padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width*50/100,
                child: Text(
                  "How quickly daft jumping zebras vex jocks help fax my big quiz.",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: colorconst.whiteColor),
                ),
              )),
        ),
        
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding:const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: SizedBox(
              child: ElevatedButton(
                style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all<Color>(colorconst.whiteColor),
             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    )
  )
),
                onPressed: (){},
                child:  Text("Take the quiz",
                style: TextStyle(
                  color: colorconst.blackColor
                ),
                ),
              ),
            ),
            ),
        )
      ]);
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
                   Text(
                    "Quiz",
                    style: TextStyle(
                      color: colorconst.lightYellow,
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
                  onPressed: (){
                    context.pushNamed('ENTERQUIZPAGE');
                  }, 
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