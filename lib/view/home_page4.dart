import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page4_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
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
    final colorconst = ColorConst();
    var yourIntrestController = Get.find<YourIntrestController>();
    var homePage1Controller = Get.find<HomePage1Controller>();
  var homepage4Controller = Get.find<HomePage4Controller>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        homePageController.bootomNav.value = 0;
      return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
               Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              "Trending Videos",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                  color: colorconst.darkBlue, fontSize: 14),
                            )
                          ],
                        ),
                      ),
                      Obx(() {
                          return CarouselSlider.builder(
                              options: CarouselOptions(
                                  height: 300.0,
                                  // autoPlay: true,
                                  onPageChanged: ((index, reason) {
                                    homePage1Controller.carouselSliderIndex.value = index;
                                  })),
                              itemCount: homePage1Controller.copydata.length,
                              itemBuilder: ((context, index, realIndex) {
                                // final urlImage = urlImages[index];
                                return buildfeaturedVideo(index, context);
                              }),
                            );
                        }
                      ),
                        const SizedBox(
                        height: 32,
                      ),
                     Obx((){
                         return
                          buildIndicatorTrendingVideo(homePage1Controller.carouselSliderIndex.value);
                       }
                     ), 
                    SizedBox(height: 20,),
                    Padding( 
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              "Hot Shows/Topics",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                  color: colorconst.darkBlue, fontSize: 14),
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
                          itemCount: yourIntrestController.choices.length,
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
                                  image: DecorationImage(image: AssetImage(yourIntrestController.choices[index].title.toString()),fit: BoxFit.cover)
                                  ),
                                ),
                                Text(
                                  yourIntrestController
                                              .allTagsModel[index].name
                                              .toString(),
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
                          children:  [
                            Text(
                              "Trending Articles",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "View All",
                              style: TextStyle(
                                  color: colorconst.darkBlue, fontSize: 14),
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
      ),
    );
  }

Widget buildfeaturedVideo(int index, BuildContext context) {
      return Stack(
        children: [
        InkWell(
          onTap: () async{
            await apiprovider.getComment(homePage1Controller.copydata[index].id);
            context.pushNamed('ARTICLEDETAILPAGE',
              extra: homePage1Controller.copydata[index],
              queryParams: {"index": "${index}"});
               await apiprovider.postApi('/post/mark-read', {'postId': "${homePage1Controller.allpostdata[index].id}"});
         homePage1Controller.allpostdata[index].read = true;
         homePage1Controller.copydata[index].read = true;
         homePageController.isArticleRead();
         setState(() {
           
         });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 400,
            // width: 200,
            decoration: BoxDecoration(
                image:
                    DecorationImage(
                      image:homePage1Controller.copydata[index].featuredImageSrc!=
                      null
                  ? NetworkImage(
                      homePage1Controller.copydata[index].featuredImageSrc,
                      scale: 0.5):
                     const NetworkImage(
                      'https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                       fit: BoxFit.cover)),
          ),
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
                          color: colorconst.whiteColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                          height: 25,
                          width: 25,
                          child: Image(image: AssetImage("assets/icons/heart.png"), color: colorconst.whiteColor,))
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
              children:  [
                // Text(
                //   "Viking",
                //   style: TextStyle(color: Color(0xff0FC59A)),
                //   // maxLines: ,
                //   overflow: TextOverflow.ellipsis,
                // ),
                Text(
                  homePage1Controller.copydata[index].title.rendered,
                  style: TextStyle(color: colorconst.whiteColor),
                )
              ],
            ),
          ),
        )
      ]);
    }

    Widget buildIndicatorTrendingVideo(index) {
      return AnimatedSmoothIndicator(
        activeIndex: index,
        count: homePage1Controller.copydata.length,
        effect: JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: colorconst.blackColor),
      );
    }
}