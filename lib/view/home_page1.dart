
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/widgets/blog_card.dart';
import '../getxcontroller/home_page1_controller.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  var homePage1Controller = Get.find<HomePage1Controller>();

  // var homePage1 = Get.find<HomePage1>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    upperList("All",const Color(0xffFBDC6D)),
                    const SizedBox(
                      width: 20,
                    ),
                    upperList("The Boys", ""),
                    const SizedBox(
                      width: 20,
                    ),
                    upperList("Raised by Wolves", ""),
                    const SizedBox(
                      width: 20,
                    ),
                    upperList("Vikings", ""),
                    const SizedBox(
                      width: 20,
                    ),
                    upperList("The Boys", ""),
                    const SizedBox(
                      width: 20,
                    ),
                    upperList("Raised by Wolves", ""),
                  ],
                ),
              ),
              const Divider(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Featured article",
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
                  // Obx(() {
                  //   return 
                  // }),
                // Obx(() {
                //     return 
                if(homePage1Controller.allpostdata != null)
                    CarouselSlider.builder(
                          options: CarouselOptions(
                              height: 400.0,
                              // viewportFraction: 1,
                              // autoPlay: true,
                              onPageChanged: ((index, reason) {
                                // homePage1 = index;
                                homePage1Controller.carouselSliderIndex.value =
                                    index;
                              })),
                          itemCount: homePage1Controller.allpostdata.length,
                          itemBuilder: ((context, index, realIndex) {
                            // final urlImage = homePage1Controller.like[index].image;
                            return buildImage(context, index);
                          }),
                        ),
                //   }
                // ),  
                  const SizedBox(
                    height: 32,
                  ),
                 Obx(() {
                     return buildIndicator(homePage1Controller.carouselSliderIndex.value);
                   }
                 ), 
                  const SizedBox(
                    height: 20,
                  ),
                  Padding( 
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
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
                    shrinkWrap:  true,
                    itemCount: homePage1Controller.allpostdata.length,
                    itemBuilder:(context, index) {
                      return  BlogCard(
                    context: context,
                    blogDetail: homePage1Controller.allpostdata[index]
                  );
                    },),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int sliderVal) {
      return AnimatedSmoothIndicator(
        activeIndex: sliderVal,
        count: homePage1Controller.allpostdata.length,
        effect: const JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.black),
      );
    }

    Widget buildImage(BuildContext context, int index,) {
        return Stack(
          children: [
          InkWell(
            onTap: (){
              print("Moving");
              print(homePage1Controller.allpostdata[index]);
              context.pushNamed('ARTICLEDETAILPAGE', extra: homePage1Controller.allpostdata[index], );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 400,
              // width: 200,
              decoration:const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/images/slider1.png"), fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            top: 10,
            left: MediaQuery.of(context).size.width*58/100,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children:  [
                      const  Text(
                          "2.5k",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                       const SizedBox(width: 4,),
                       InkWell(
                        onTap: (){
                        //  homePage1Controller.like[index].isLike.toggle();
                         print("object");
                         print(homePage1Controller.like[index].isLike.value);
                        },
                         child: 
                        //  Obx(() {
                        //      return 
                             const SizedBox(
                              height: 25,
                              width: 25,
                              child: 
                              // homePage1Controller.like[index].isLike.value ?
                               Image(image: AssetImage("assets/icons/heart.png",))
                                // :
                              //  Image(image: AssetImage("assets/icons/color_heart.ico",), fit: BoxFit.cover,)
                               ),
                        //    }
                        //  ),
                       )
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
                children: [
                  const Text(
                    "Viking",
                    style: TextStyle(color: Color(0xff0FC59A)),
                    // maxLines: ,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    homePage1Controller.allpostdata[index].title.rendered.toString(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          )
        ]);
      }
  }

  Widget upperList(name, bgcolor) {
    return Container(
      decoration: BoxDecoration(
          color: bgcolor == "" ? Colors.transparent : bgcolor,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        child: Text(
          name,
        ),
      ),
    );
  }

