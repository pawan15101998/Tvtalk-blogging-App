import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page2_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/widgets/blog_card.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final urlImages = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png',
  ];
  final apiprovider = ApiProvider();
  var homepage2Controller = Get.find<HomePage2Controller>();
    var homePage1Controller = Get.find<HomePage1Controller>();
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
                          homepage2Controller.sliderHome2index.value = index;
                      })),
                  itemCount: homePage1Controller.copydata.length,
                  itemBuilder: ((context, index, realIndex) {
                    // final urlImage = urlImages[index];
                    return buildImage(context, index);
                  }),
                ),
              ],
            ),
         const SizedBox(
              height: 20,
            ),
            Obx(() {
                return buildIndicator();
              }
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 30 ),
              child: GridView.builder(
                itemCount: 9,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async{
                      // yourIntrestController.choices[index].select.toggle();
                      // choices[index].select = yourIntrestController.yourIntrest.value;
                      // print(yourIntrestController.choices[index].select);
                       var response = await apiprovider.getComment(homePage1Controller.copydata[index].id);
                       print("sddddddddddsdddddd");
                       print(apiprovider.statuscode);
                  
              if(signincontroller.isGuest.value == 'guest'){
              Router.neglect(context, () {context.goNamed('SIGNINPAGE');});
            }else{
              context.pushNamed('ARTICLEDETAILPAGE', extra: homePage1Controller.copydata[index],queryParams: {"index": "$index"});
            }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 19 / 100,
                      decoration: BoxDecoration(color: Color(0xffFFEAC5)),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            Container(
                              height: 32,
                              width: 32,
                              decoration: const BoxDecoration(
                              color: Colors.grey,
                                image: DecorationImage(image: AssetImage("assets/images/slider2.png"),fit: BoxFit.cover)
                              ),
                            ),
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(
                                homePage1Controller.copydata[index].title.rendered,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 8
                                ),
                            ),
                             )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding( 
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,),
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
                                image: DecorationImage(image: AssetImage("assets/images/myint1.png"),fit: BoxFit.cover)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(Icons.add,color: Colors.black,)),
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
                  Obx(() {
                        return CarouselSlider.builder(
                              options: CarouselOptions(
                                  height: 400.0,
                                  // viewportFraction: 1,
                                  // autoPlay: true,
                                  onPageChanged: ((index, reason) {
                                    // homePage1 = index;
                                    // if(homePage1Controller.carouselSliderIndex.value != null)
                                    homePage1Controller.carouselSliderIndex.value = index;
                                  })),
                              itemCount: homePage1Controller.copydata.length,
                              itemBuilder: ((context, index, realIndex) {
                                print("Inexxx");
                                print(index);
                                // final urlImage = homePage1Controller.like[index].image;
                                return buildImage(context, index);
                              }),
                            );
                      }
                    ),
                      const SizedBox(
                      height: 32,
                    ),
                   Obx((){
                       return
                        buildIndicatorTrending();
                     }
                   ), 
                  // const SizedBox(height: 50,),
            Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Latest Fun Quiz",
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
                            height: 220.0,
                            viewportFraction: 0.9,
                            // autoPlay: true,
                            onPageChanged: ((index, reason){
                              // homePage1 = index;
                              homepage2Controller.sliderHome2Latest.value =
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
                   Obx((){
                       return
                        buildIndicatorLatest();
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
                            "Trending articles",
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
                  physics: const ScrollPhysics(),
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

    Widget buildImage(BuildContext context, int index) {
        return Stack(
          children: [
          InkWell(
            onTap: ()async{
              print("Moving");
              print(homePage1Controller.copydata[index].id);
              // print(homePage1Controller.allpostdata[index]);
            var response = await apiprovider.getComment(homePage1Controller.copydata[index].id);
            print("sddddddddddsdddddd");
            print(apiprovider.statuscode);
              if(signincontroller.isGuest.value == 'guest'){
              Router.neglect(context, () {context.goNamed('SIGNINPAGE');});
            }else{
              context.pushNamed('ARTICLEDETAILPAGE', extra: homePage1Controller.copydata[index],queryParams: {"index": "$index"});
            }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              height: 400,
              // width: 200,
              decoration:const BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage("assets/images/slider1.png"), fit: BoxFit.fill)),
            ),
          ),
          // Positioned(
          //   top: 10,
          //   left: MediaQuery.of(context).size.width*58/100,
          //   child: Column(
          //     children: [
          //       Align(
          //           alignment: Alignment.topRight,
          //           child: Row(
          //             children:  [
          //             const  Text(
          //                 "2.5k",
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                 ),
          //                 textAlign: TextAlign.center,
          //               ),
          //              const SizedBox(width: 4,),
          //              InkWell(
          //               onTap: (){
          //               //  homePage1Controller.like[index].isLike.toggle();
          //                print("object");
          //                print(homePage1Controller.like[index].isLike.value);
          //               },
          //                child: 
          //               //  Obx(() {
          //               //      return 
          //                    const SizedBox(
          //                     height: 25,
          //                     width: 25,
          //                     child: 
          //                     // homePage1Controller.like[index].isLike.value ?
          //                      Image(image: AssetImage("assets/icons/heart.png",))
          //                       // :
          //                     //  Image(image: AssetImage("assets/icons/color_heart.ico",), fit: BoxFit.cover,)
          //                      ),
          //               //    }
          //               //  ),
          //              )
          //             ],
          //           )),
          //     ],
          //   ),
          // ),
          Positioned(
            bottom: 10,
            width: MediaQuery.of(context).size.width*65/100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "",
                    style: TextStyle(color: Color(0xff0FC59A)),
                    // maxLines:,
                    overflow: TextOverflow.ellipsis,
                  ),
                      Obx(() {
                          return 
                          Text(
                            homePage1Controller.copydata[index].title.rendered,
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      ),  
                ],
              ),
            ),
          )
        ]);
      }
Widget buildfeaturedImage(String image, int index, context) {
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
                  "",
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


        Widget buildLatestImage(String image, int index) {
      return Stack(
        children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12),
          height: 300,
          decoration: BoxDecoration(
              color: Colors.red,
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Align(
              alignment: Alignment.topRight,
              child: Text(
                "quiz",
                style: TextStyle(color: Color(0xffF1B142)),
              )),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width*50/100,
                child: Text(
                  "How quickly daft jumping zebras vex jocks help fax my big quiz.",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white),
                ),
              )),
        ),
        
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: SizedBox(
              child: ElevatedButton(
                style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    )
  )
),
                onPressed: (){},
                child: const Text("Take the quiz",
                style: TextStyle(
                  color: Colors.black
                ),
                ),
              ),
            ),
            ),
        )
        
      ]);
    }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: homepage2Controller.sliderHome2index.value,
      count: 10,
      effect: JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: Colors.black),
    );
  }
    Widget buildIndicatorTrending() {
      return AnimatedSmoothIndicator(
        activeIndex: homepage2Controller.SliderHome2Featured.value,
        count: 4,
        effect: JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.black),
      );
    }

        Widget buildIndicatorLatest() {
      return AnimatedSmoothIndicator(
        activeIndex: homepage2Controller.sliderHome2Latest.value,
        count: 4,
        effect: JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.black),
      );
    }
}
