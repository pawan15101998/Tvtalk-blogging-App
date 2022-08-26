import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page3_controller.dart';
import 'package:tvtalk/widgets/blog_card.dart';

class HomePage3 extends StatefulWidget {
  const HomePage3({Key? key}) : super(key: key);

  @override
  State<HomePage3> createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  final urlImages = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png',
  ];
      var homePage1Controller = Get.find<HomePage1Controller>();
  var homePage3Controller = Get.find<HomePage3Controller>();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                      height: 300.0,
                      viewportFraction: 1,
                      // autoPlay: true,
                      onPageChanged: ((index, reason) {
                          homePage3Controller.HomePage3slider.value = index;
                      })),
                  itemCount: urlImages.length,
                  itemBuilder: ((context, index, realIndex) {
                    final urlImage = urlImages[index];
                    return buildImage(urlImage, index);
                  }),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() {
              return buildIndicator();
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Featured article",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(color: Color(0xfff0701BF), fontSize: 14),
                  )
                ],
              ),
            ),
            CarouselSlider.builder(
              options: CarouselOptions(
                  height: 400.0,
                  // autoPlay: true,
                  onPageChanged: ((index, reason) {
                    // homePage1 = index;
                    // homePage1Controller.carouselSliderIndex.value =
                    homePage3Controller.HomePage3Featured.value = index;
                  })),
              itemCount: urlImages.length,
              itemBuilder: ((context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildfeaturedImage(urlImage, index, context);
              }),
            ),
            const SizedBox(
              height: 32,
            ),
            Obx(() {
              return buildIndicatorTrending();
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Hot Shows/Topics",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(color: Color(0xfff0701BF), fontSize: 14),
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
                    return const SizedBox(
                      width: 12,
                    );
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
                              image: DecorationImage(
                                  image: AssetImage("assets/images/myint1.png"),
                                  fit: BoxFit.cover)),
                        ),
                        Text("The Boys"),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Trending Videos",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(color: Color(0xfff0701BF), fontSize: 14),
                  )
                ],
              ),
            ),
            ListView.builder(
                    shrinkWrap: true,
                    itemCount: homePage1Controller.allpostdata.length,
                    itemBuilder:(context, index) {
                      return  BlogCard(
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

  Widget buildImage(String image, int index) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.symmetric(),
        height: 400,
        decoration: BoxDecoration(
            color: Colors.red,
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
      ),
      Positioned(
        bottom: 10,
        left: 10,
        width: MediaQuery.of(context).size.width * 65 / 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "The Boys",
              style: TextStyle(color: Color(0xff0FC59A)),
            ),
            const Text(
              "Bright vixens jump; dozy fowl quack. Wafting for zephyrs vex bold Jim.",
              style: TextStyle(color: Colors.white),
            ),
            Row(
              children: const [
                SizedBox(
                    height: 25,
                    width: 25,
                    child: Image(
                      image: AssetImage("assets/icons/heart.png"),
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "2.5k",
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    ]);
  }

  Widget buildfeaturedImage(String image, int index, context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        height: 400,
        // width: 200,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      ),
      Positioned(
        left: MediaQuery.of(context).size.width * 55 / 100,
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
                    SizedBox(
                        height: 25,
                        width: 25,
                        child: Image(
                          image: AssetImage("assets/icons/heart.png"),
                          color: Colors.white,
                        ))
                  ],
                )),
          ],
        ),
      ),
      Positioned(
        bottom: 10,
        width: MediaQuery.of(context).size.width * 65 / 100,
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

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: homePage3Controller.HomePage3slider.value,
      count: urlImages.length,
      effect: JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: Colors.black),
    );
  }

  Widget buildIndicatorTrending() {
    return AnimatedSmoothIndicator(
      activeIndex: homePage3Controller.HomePage3Featured.value,
      count: 4,
      effect: JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: Colors.black),
    );
  }
}
