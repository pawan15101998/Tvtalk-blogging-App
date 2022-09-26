import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page4_controller.dart';
import 'package:tvtalk/widgets/blog_card.dart';

class HomePage4 extends StatefulWidget {
  const HomePage4({Key? key}) : super(key: key);

  @override
  State<HomePage4> createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
    final urlImages = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png',
  ];
    var homePage1Controller = Get.find<HomePage1Controller>();
  var homepage4Controller = Get.find<HomePage4Controller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Trending Videos",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                                color: Color(0xfff0701BF), fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                        options: CarouselOptions(
                            height: 300.0,
                            // autoPlay: true,
                            onPageChanged: ((index, reason) {
                              homepage4Controller.homePage4Slider.value = index;
                            })),
                        itemCount: urlImages.length,
                        itemBuilder: ((context, index, realIndex) {
                          final urlImage = urlImages[index];
                          return buildfeaturedVideo(urlImage, index, context);
                        }),
                      ),
                      const SizedBox(
                      height: 32,
                    ),
                   Obx((){
                       return
                        buildIndicatorTrendingVideo();
                     }
                   ), 
                  SizedBox(height: 20,),
                  Padding( 
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Hot Shows/Topics",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                                color: Color(0xfff0701BF), fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    Padding(
                     padding: const EdgeInsets.only(left: 20),
                     child: SizedBox(
                      height: 150,
                       child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 12,);
                        }, 
                        itemCount: 10,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(image: AssetImage("assets/images/myint1.png"),fit: BoxFit.cover)
                                ),
                              ),
                              Text(
                                "The Boys"
                              ),
                            ],
                          );
                        }, 
                        ),
                     ),
                   ),
                   Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Trending Articles",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                                color: Color(0xfff0701BF), fontSize: 14),
                          )
                        ],
                      ),
                    ),
               ListView.builder(
                shrinkWrap: true,
                physics:const ScrollPhysics(),
                    itemCount: homePage1Controller.allpostdata.length,
                    itemBuilder:(context, index) {
                  // bool isread =  homePageController.allPostId.contains(homePageController.readArticleId[index]);
                        return  BlogCard(
                    // isread: isread,
                    indexx: index,
                    context: context,
                    blogDetail: homePage1Controller.allpostdata[index]
                  );
                    },),
          ],
        ),
      ),
    );
  }

Widget buildfeaturedVideo(String image, int index, context) {
      return Stack(
        children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 400,
          // width: 200,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        Positioned(
          top: 10,
          left: MediaQuery.of(context).size.width*60/100,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    children: [
                      Text(
                        "2.5k",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                          height: 25,
                          width: 25,
                          child: Image(image: AssetImage("assets/icons/heart.png"), color: Colors.white,))
                    ],
                  )),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          width: MediaQuery.of(context).size.width*65/100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Viking",
                  style: TextStyle(color: Color(0xff0FC59A)),
                  // maxLines: ,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "The jay, pig, fox, zebra, and my wolves quack! Blowzy red vixens.",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        )
      ]);
    }


     Widget buildIndicatorTrendingVideo() {
      return AnimatedSmoothIndicator(
        activeIndex: homepage4Controller.homePage4Slider.value,
        count: 4,
        effect: JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.black),
      );
    }
}