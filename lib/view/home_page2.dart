import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taboola_sdk/publisher_info.dart';
import 'package:taboola_sdk/standard/taboola_standard.dart';
import 'package:taboola_sdk/standard/taboola_standard_builder.dart';
import 'package:taboola_sdk/standard/taboola_standard_listener.dart';
import 'package:taboola_sdk/taboola.dart';
import 'package:tvtalk/constant/color_const.dart';
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
    'assets/images/slider4.png'
  ];
  final colorconst = ColorConst();
  final apiprovider = ApiProvider();
  var homepage2Controller = Get.find<HomePage2Controller>();
    var homePage1Controller = Get.find<HomePage1Controller>();
  int activeIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   var isreadd =  homePageController.allPostId.where((elem)=>homePageController.readArticleId.contains(elem));
  }

  //Taboola Standard listeners
void taboolaDidShow(String placement) {
  print("taboolaDidShow");
}

void taboolaDidResize(String placement, double height) {
  print("publisher did get height $height");
}

void taboolaDidFailToLoad(String placement, String error) {
  print("publisher placement:$placement did fail with an error:$error");
}

bool taboolaDidClickOnItem(
    String placement, String itemId, String clickUrl, bool organic) {
  print(
      "publisher did click on item: $itemId with clickUrl: $clickUrl in placement: $placement of organic: $organic");
  if (organic) {
    //_showToast("Publisher opted to open click but didn't actually open it.");
    print("organic");
  } else {
    // _showToast("Publisher opted to open clicks but the item is Sponsored, SDK retains control.");
    print("SC");
  }
  return false;
}

  Widget build(BuildContext context){

    Taboola.init(PublisherInfo("sdk-tester-rnd"));

    TaboolaStandardBuilder taboolaStandardBuilder =
        Taboola.getTaboolaStandardBuilder("http://www.example.com", "article");

    TaboolaStandardListener taboolaStandardListener = TaboolaStandardListener(
        taboolaDidResize,
        taboolaDidShow,
        taboolaDidFailToLoad,
        taboolaDidClickOnItem);

    TaboolaStandard taboolaStandard = taboolaStandardBuilder.build(
        "Feed without video", "thumbs-feed-01", true, taboolaStandardListener);
        
    TaboolaStandard taboolaStandardWidget = taboolaStandardBuilder.build(
        "mid article widget", "alternating-1x2-widget", true, taboolaStandardListener);

    return WillPopScope(
      onWillPop: () async{
      //  pages.animateTo(1, duration: Duration(milliseconds: 500),);
      //  return false;
       homePageController.bootomNav.value = 0;
       return false;
      },
      child: Scaffold(
        body: Obx(
           () {
            return homePage1Controller.searchArticle.isNotEmpty &&
                          homePage1Controller.nosearch != ""
                      ?
                      // homePage1Controller.allpostdata.length != 0?
                       ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          // scrollDirection: Axis.vertical,
                          itemCount: homePage1Controller.searchArticle.length,
                          itemBuilder: (context, index) {
                          // bool isread =  homePageController.allPostId.contains(homePageController.readArticleId[index]);
                          
                            return BlogCard(
                              // isread: isread,
                              indexx: index,
                              context: context,
                              blogDetail:
                                  homePage1Controller.searchArticle[index],
                            );
                          },
                        )
                      : homePage1Controller.searchArticle.isEmpty &&
                              homePage1Controller.nosearch != ""
                          ? Center(child: Text(" No Data  Found"))
                          : 
                          homePage1Controller.allpostdata.isNotEmpty ?
            SingleChildScrollView(
              child: Column(
                children: [
                  // taboolaStandard,
                  Stack(
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(
                            height: 300.0,
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            // autoPlay: true,
                            onPageChanged: ((index, reason) {
                                homepage2Controller.sliderHome2index.value = index;
                            })),
                        itemCount: homePage1Controller.allpostdata.length,
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
                      itemCount: homePage1Controller.allpostdata.length > 9 ? 9 :homePage1Controller.allpostdata.length,
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
                             var response = await apiprovider.getComment(homePage1Controller.copydata[index].id);
                           
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
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 19 / 100,
                                    width: MediaQuery.of(context).size.height * 19 / 100,
                                    decoration: BoxDecoration(
                                    color: Colors.grey,
                                      image: DecorationImage(
                    image:homePage1Controller.copydata[index].featuredImageSrc != null?
                    NetworkImage(homePage1Controller.copydata[index].featuredImageSrc, scale: 0.5):
                    NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                    fit: BoxFit.cover,),
                                    ),
                                  ),
                                  Align(
                                   alignment: Alignment.bottomCenter,
                                    child: Html(data: '<p>${homePage1Controller.copydata[index].title.rendered}</p>',
                          style: {
                            'p':Style(
                              color:homePage1Controller.copydata[index].featuredImageSrc != null ? colorconst.whiteColor: colorconst.blackColor,
                              fontSize: FontSize(8)
                            )
                          },
                          ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // homePage1Controller.copydata[index].title.rendered,
                        );
                      },
                    ),
                  ),
                  // Padding( 
                  //           padding: const EdgeInsets.symmetric(
                  //               horizontal: 20,),
                  //           child: Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             children: const [
                  //               Text(
                  //                 "Hot Shows/Topics",
                  //                 style: TextStyle(fontSize: 14),
                  //               ),
                  //               Text(
                  //                 "View All",
                  //                 style: TextStyle(
                  //                     color: colorconst.darkBlue, fontSize: 14),
                  //               )
                  //             ],
                  //           ),
                  //         ),
                        //  Padding(
                        //    padding: const EdgeInsets.only(left: 20),
                        //    child: SizedBox(
                        //     height: 150,
                        //      child: ListView.separated(
                        //       separatorBuilder: (context, index) {
                        //         return const SizedBox(width: 12,);
                        //       }, 
                        //       itemCount: 10,
                        //       shrinkWrap: true,
                        //       scrollDirection: Axis.horizontal,
                        //       itemBuilder: (context, index) {
                        //         return Column(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Container(
                        //               height: 120,
                        //               width: 120,
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(8),
                        //               image: DecorationImage(image: AssetImage("assets/images/myint1.png"),fit: BoxFit.cover)),
                        //               child: const Padding(
                        //                 padding: EdgeInsets.all(8.0),
                        //                 child: Align(
                        //                   alignment: Alignment.topRight,
                        //                   child: Icon(Icons.add,color: colorconst.blackColor,)),
                        //               ),
                        //             ),
                        //             Text(
                        //               "The Boys"
                        //             ),
                        //           ],
                        //         );
                        //       }, 
                        //       ),
                        //    ),
                        //  ),
                         Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Featured article",
                                  style: TextStyle(fontSize: 14),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.pushNamed('FEATUREARTICLEVIEWALL');
                                  },
                                  child:const Text(
                                    "View All",
                                    style: TextStyle(
                                        color: Color(0xff0701BF), fontSize: 14),
                                  ),
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
                                        height: 300.0,
                                        // viewportFraction: 1,
                                        // autoPlay: true,
                                        enableInfiniteScroll: false,
                                        onPageChanged: ((index, reason) {
                                          // homePage1 = index;
                                          // if(homePage1Controller.carouselSliderIndex.value != null)
                                           homepage2Controller.SliderHome2Featured.value = index;
                                          // homePage1Controller.carouselSliderIndex.value = index;
                                        })),
                                    itemCount: homePage1Controller.copydata.length,
                                    itemBuilder: ((context, index, realIndex) {
                                     
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
                              children:  [
                                Text(
                                  "Latest Fun Quiz",
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
                        const SizedBox(height: 20,),
                         Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                               const Text(
                                  "Trending articles",
                                  style: TextStyle(fontSize: 14),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.pushNamed('TRENDINGARTICLEVIEWALL');
                                  },
                                  child:const Text(
                                    "View All",
                                    style: TextStyle(
                                    color: Color(0xff0701BF), fontSize: 14),
                                  ),
                                )
                              ],
                            ),
                          ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:12 ),
                        child: ListView.builder(
                          controller: taboolaStandard.scrollController,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                            itemCount: homePage1Controller.allpostdata.length,
                            itemBuilder:(context, index){
                              // bool isread =  homePageController.allPostId.contains(homePageController.readArticleId[index]);
                              // bool isread = false;
                              return  BlogCard(
                                // isread: isread,
                                indexx: index,
                            context: context,
                            blogDetail: homePage1Controller.allpostdata[index]
                          );
                            },),
                      ),
                ],
              ),
            )
            : SizedBox(
              height: MediaQuery.of(context).size.height -190,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:const [
                                          Center (child: Text("No Data Found"),),
                                        ],
                                      ),
                                    );
          }
        ),
      ),
    );
  }

    Widget buildImage(BuildContext context, int index) {
        return Stack(
          children: [
          InkWell(
            onTap: ()async{
            
            var response = await apiprovider.getComment(homePage1Controller.copydata[index].id);
            
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
              decoration: BoxDecoration(
                  image:DecorationImage(
                  image:homePage1Controller.copydata[index].featuredImageSrc != null?
     NetworkImage(homePage1Controller.copydata[index].featuredImageSrc, scale: 0.5):
  const NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                  fit: BoxFit.cover,),),
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
          //                   color: colorconst.whiteColor,
          //                 ),
          //                 textAlign: TextAlign.center,
          //               ),
          //              const SizedBox(width: 4,),
          //              InkWell(
          //               onTap: (){
          //               //  homePage1Controller.like[index].isLike.toggle();
          //            
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
                          InkWell(
                            onTap: ()async {
                       
            var response = await apiprovider.getComment(homePage1Controller.copydata[index].id);
              if(signincontroller.isGuest.value == 'guest'){
              Router.neglect(context, () {context.goNamed('SIGNINPAGE');});
            }else{
              context.pushNamed('ARTICLEDETAILPAGE', extra: homePage1Controller.copydata[index],queryParams: {"index": "$index"});
            }
                            },
                            child: Html(data:'<p>${homePage1Controller.copydata[index].title.rendered}</p>',
                                              style: {
                                                'p':Style(
                                                  color:homePage1Controller.copydata[index].featuredImageSrc != null? colorconst.whiteColor: colorconst.blackColor
                                                )
                                              },
                                              ),
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
                    children:  [
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
                Text(
                  "",
                  style: TextStyle(color: Color(0xff0FC59A)),
                  // maxLines: ,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "The jay, pig, fox, zebra, and my wolves quack! Blowzy red vixens.",
                  style: TextStyle(color: colorconst.whiteColor),
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

Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: homepage2Controller.sliderHome2index.value,
      count: homePage1Controller.allpostdata.length,
      effect: JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: colorconst.blackColor),
    );
  }
    Widget buildIndicatorTrending() {
      return AnimatedSmoothIndicator(
        activeIndex: homepage2Controller.SliderHome2Featured.value,
        count: homePage1Controller.allpostdata.length,
        effect:  JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: colorconst.blackColor),
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
            activeDotColor: colorconst.blackColor),
      );
    }
}
