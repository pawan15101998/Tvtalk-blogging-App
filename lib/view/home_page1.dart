import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';
import 'package:tvtalk/view/feeds_detail_page.dart';
// import 'package:tvtalk/view/profile_page.dart';
import 'package:tvtalk/widgets/blog_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../getxcontroller/home_page1_controller.dart';
import '../getxcontroller/signin_controller.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage1> createState() => HomePage1State();
}

class HomePage1State extends State<HomePage1> {
var homePage1Controller = Get.find<HomePage1Controller>();
final apiprovider = ApiProvider();
var yourIntrestController = Get.find<YourIntrestController>();
  // var homePage1 = Get.find<HomePage1>();
final signincontroller = Get.find<SignInController>();
List listModel = [];
final colorconst = ColorConst();


refreshWidget(){
    setState(() {});
}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement initState
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
           showDialog(context: context, builder: (_)=>AlertDialog(
                              title:const Text("Do you Want to Rate this App"),
                              actions: [
                                TextButton(onPressed: (){
                                 SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                                }, 
                                child:const Text("No")),
                                TextButton(onPressed: (){
                                launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.hackerkernel.scoreyourrun"));
                                Navigator.pop(context);
                                }, 
                                child:const Text("Yes"))
                              ],
                            ));
                            return false;
      },
      child: Scaffold(
          body: RefreshIndicator(
            onRefresh: ()async{
              homePage1Controller.allpostdata = [].obs;
            homePage1Controller.copydata = [].obs;
            apiprovider.allPost = [];
            await apiprovider.getPost(homePage1Controller.userTags);
              setState(() {});
            },
            child: SingleChildScrollView(
                child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Obx(() {
                  return homePage1Controller.searchArticle.isNotEmpty &&
                          homePage1Controller.nosearch != "" && yourIntrestController.searchTags.value == false
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          // scrollDirection: Axis.vertical,
                          itemCount: homePage1Controller.searchArticle.length,
                          itemBuilder: (context, index){
                          bool isread =  homePageController.allPostId.contains(homePageController.readArticleId[index]);
                            return BlogCard(
                              // isread: isread,
                              
                              indexx: index,
                              context: context,
                              blogDetail: homePage1Controller.searchArticle[index],
                            );
                          },
                        )
                      : (yourIntrestController.searchTags.value == true) && 
                      (homePage1Controller.searchArticle.isNotEmpty)
                      ?
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: homePage1Controller.searchArticle.length,
                        itemBuilder: (context, ind) {
                          return InkWell(
                            onTap: ()async {
                              int? tagid;
                              yourIntrestController.allTagsModel.forEach((element) {
                                if(element.name.toLowerCase().trim() == homePage1Controller.searchArticle.toString().replaceAll("[", "").replaceAll("]", "").trim()){
                                  tagid = element.id;
                                }
                               });
                               homePage1Controller.allpostdata = [].obs;
                               apiprovider.allPost = [];
                               await apiprovider.getPost(tagid);
                               context.pushNamed('TAGSEARCHPAGE', queryParams: {'tagName': homePage1Controller.searchArticle.toString().replaceAll("[", "").replaceAll("]", "")});                      
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color:colorconst.mainColor,
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text(homePage1Controller.searchArticle[ind], style: 
                                const TextStyle(
                                  fontSize: 20
                                )
                                ,))),
                            ),
                          );
                        }
                      ):
                      homePage1Controller.searchArticle.isEmpty &&
                              homePage1Controller.nosearch != ""
                          ? const Center(child: Text(" No Data Found"))
                          : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 35,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      //  Obx(() {
                                      // return
                                      InkWell(
                                          onTap: () async {
                                            homePage1Controller.allpostdata =
                                                [].obs;
                                            homePage1Controller.copydata = [].obs;
                                            apiprovider.allPost = [];
                                
                                                homePage1Controller.topTags.value =
                                                "All";
                                            await apiprovider.getPost(
                                                homePage1Controller.userTags.value);
                                            
                                            setState(() {});
                                          },
                                          child: upperList(
                                              name: "All",
                                              isSelected: true,
                                              bgcolor: const Color(0xffFBDC6D))),
                                      //   }
                                      // ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Obx(() {
                                        return ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: yourIntrestController
                                                .allTagsModel.length,
                                            itemBuilder: (context, index){
                                              return InkWell(
                                                onTap: () async {
                                                  homePage1Controller.allpostdata =[].obs;
                                                  homePage1Controller.copydata =[].obs;
                                                  apiprovider.allPost = [];
                                                 
                                                      homePage1Controller
                                                          .topTags.value =
                                                      yourIntrestController
                                                          .allTagsModel[index].name
                                                          .toString();
                                                  await apiprovider.getPost(
                                                      yourIntrestController
                                                          .allTagsModel[index].id);
                                                
                                                  setState(() {});
                                                },
                                                child: upperList(
                                                    name: yourIntrestController
                                                        .allTagsModel[index].name
                                                        .toString(),
                                                    isSelected: true,
                                                    bgcolor: "",
                                                    ),
                                              );
                                            });
                                      }),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                homePage1Controller.allpostdata.length != 0
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    apiprovider.getTags();
                                                  },
                                                  child: Text(
                                                    "Featured article",
                                                    style: TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context.pushNamed(
                                                        'FEATUREARTICLEVIEWALL');
                                                  },
                                                  child:  Text(
                                                    "View All",
                                                    style: TextStyle(
                                                        color: colorconst.darkBlue,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // Obx(() {
                                          //   return
                                          // }),
                                          // Obx(() {
                                          //     return
          
                                          Obx(() {
                                            return CarouselSlider.builder(
                                              options: CarouselOptions(
                                                  height: 300.0,
                                                  enableInfiniteScroll: false,
                                                  // viewportFraction: 1,
                                                  autoPlay: false,
                                                  onPageChanged: ((index, reason) {
                                                    // homePage1 = index;
                                                    // if(homePage1Controller.carouselSliderIndex.value != null)
                                                    homePage1Controller
                                                        .carouselSliderIndex
                                                        .value = index;
                                                  })),
                                              itemCount: homePage1Controller
                                                  .copydata.length,
                                              itemBuilder:
                                                  ((context, index, realIndex) {
                                                // Stream streamController() => Stream.fromFuture(
                                                // apiprovider.getComment(homePage1Controller.copydata[index].id)
                                                //   );
                                               
                                                // final urlImage = homePage1Controller.like[index].image;
                                                return buildImage(context, index);
                                              }),
                                            );
                                          }),
          
                                          //   }
                                          // ),
                                          const SizedBox(
                                            height: 32,
                                          ),
                                          Obx(() {
                                            return buildIndicator(
                                                homePage1Controller
                                                    .carouselSliderIndex.value);
                                          }),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Trending Articles",
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context.pushNamed(
                                                        'TRENDINGARTICLEVIEWALL');
                                                  },
                                                  child: Text(
                                                    "View All",
                                                    style: TextStyle(
                                                        color: colorconst.darkBlue,
                                                        fontSize: 14),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Obx(() {
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              // scrollDirection: Axis.vertical,
                                              itemCount: homePage1Controller.allpostdata.length,
                                              itemBuilder: (context, index) {
                                                // allpostdata = [].obs;
                                                // homePage1Controller.searchArticle = [].obs;
                                                // homePage1Controller.allpostdata = [].obs;
                                                // homePage1Controller.copydata = [].obs;
                                                      
                                                bool isread = false;
                                                if(homePageController.readArticleId.length != 0) {
                                                // isread = homePageController.allPostId.contains(homePageController.readArticleId[index]);
                                                }
                                              
                                                return Obx(() {
                                                    return BlogCard(
                                                      // isread: isread,
                                                      indexx: index,
                                                      context: context,
                                                      blogDetail: homePage1Controller
                                                          .allpostdata[index],
                                                    );
                                                  }
                                                );
                                              },
                                            );
                                          }),
                                        ],
                                      )
                                    : SizedBox(
                                        height: MediaQuery.of(context).size.height -
                                            190,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text("No Data Found"),
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            );
                }),
              ],
            ),
                ),
              ),
          )),
    );
  }

  Widget buildIndicator(int sliderVal) {
    return SizedBox(
      child: AnimatedSmoothIndicator(
        activeIndex: sliderVal,
        count: homePage1Controller.allpostdata.length,
        effect:  JumpingDotEffect(
            dotColor: Colors.grey,
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: colorconst.blackColor),
      ),
    );
  }

  Widget buildImage(BuildContext context, int index) {
    return Stack(children: [
      InkWell(
        onTap: () async {
          // if (signincontroller.isGuest.value == 'guest') {
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
          height: double.infinity,
          // width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: 
              homePage1Controller.copydata[index].featuredImageSrc!=
                      null
                  ? 
                  Image.network(
                      homePage1Controller.copydata[index].featuredImageSrc,
                      scale: 0.5).image
                    : 
                 const NetworkImage(
                      'https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Positioned(
        top: 10,
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
                        color: colorconst.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    InkWell(
                      onTap: () {
                        apiprovider.postApi('/post/like-post', {
                          "postId":
                              homePage1Controller.copydata[index].id.toString()
                        });
                        setState(() {});
                      },
                      child:
                          //  Obx(() {
                          //      return
                          const SizedBox(
                              height: 25,
                              width: 25,
                              child:
                                  // homePage1Controller.like[index].isLike.value ?
                                  Image(
                                      image: AssetImage(
                                "assets/icons/heart.png",
                              ))
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
        width: MediaQuery.of(context).size.width * 65 / 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   "Viking",
              //   style: TextStyle(color: Color(0xff0FC59A)),
              //   // maxLines:,
              //   overflow: TextOverflow.ellipsis,
              // ),
              Obx(() {
                return InkWell(
                  onTap: () async {
                    await apiprovider
                        .getComment(homePage1Controller.copydata[index].id);
                    context.pushNamed('ARTICLEDETAILPAGE',
                        extra: homePage1Controller.copydata[index],
                        queryParams: {"index": "${index}"});
                  },
                  child: Html(
                    data:
                        "<P>${homePage1Controller.copydata[index].title.rendered}</p>",
                    style: {
                      'p': Style(
                          color: 
                          homePage1Controller
                                      .copydata[index].featuredImageSrc !=
                                  null
                              ? colorconst.whiteColor
                              : 
                              colorconst.blackColor)
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      )
    ]);
  }
}

Widget upperList({name, index, bool isSelected = false, bgcolor}) {
  final colorconst = ColorConst();
  return Container(
    decoration: BoxDecoration(
        color: homePage1Controller.topTags.value == name
            ? Color(0xffFBDC6D)
            : colorconst.transparentColor,
        borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: Text(
        name,
      ),
    ),
  );
}
