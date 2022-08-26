
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/view/profile_page.dart';
import 'package:tvtalk/widgets/blog_card.dart';
import '../getxcontroller/home_page1_controller.dart';
import '../getxcontroller/signin_controller.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}


class _HomePage1State extends State<HomePage1> {
  var homePage1Controller = Get.find<HomePage1Controller>();
final  apiprovider = ApiProvider();
 var yourIntrestController = Get.find<YourIntrestController>();
  // var homePage1 = Get.find<HomePage1>();
final signincontroller = Get.find<SignInController>();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    // for(int i=0; i<=homePage1Controller.allpostdata.length; i++){
    // homePage1Controller.allpostdata.add({"status": 0});
    // }
    print("stsusss");
    print(homePage1Controller.allpostdata);
  }
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
                    Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: yourIntrestController.allTagsModel.length,
                          itemBuilder: (context, index) {
                          return upperList(yourIntrestController.allTagsModel[index].name.toString(), "");
                        },);
                      }
                    ),
                    
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
                      children:  [
                        InkWell(
                          onTap: () {
                            apiprovider.getTags();
                          },
                          child: Text(
                            "Featured article",
                            style: TextStyle(fontSize: 14),
                          ),
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
                     StreamBuilder<Object>(
                       stream: null,
                       builder: (context, snapshot) {
                         return Obx(() {
                          
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
                                        // Stream streamController() => Stream.fromFuture(
                                        // apiprovider.getComment(homePage1Controller.copydata[index].id)
                                        //   );
                                    print("Inexxx");
                                    print(index);
                                    // final urlImage = homePage1Controller.like[index].image;
                                    return buildImage(context, index);
                                  }),
                                );
                          }
                                         );
                       }
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
                  Obx((){
                      return ListView.builder(
                        shrinkWrap:  true,
                        physics: const ScrollPhysics(),
                        // scrollDirection: Axis.vertical,
                        itemCount: homePage1Controller.allpostdata.length,
                        itemBuilder:(context,index){
                          return  BlogCard(
                               indexx: index,
                               context: context,
                               blogDetail: homePage1Controller.allpostdata[index]
                           );
                        },);
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(int sliderVal) {
      return SizedBox(
        child: AnimatedSmoothIndicator(
          activeIndex: sliderVal,
          count: 10,
          effect: const JumpingDotEffect(
              dotColor: Colors.grey,
              dotHeight: 6,
              dotWidth: 6,
              activeDotColor: Colors.black),
        ),
      );
    }

    Widget buildImage(BuildContext context, int index) {
        return Stack(
          children: [
          InkWell(
            onTap: ()async{
            // if(signincontroller.isGuest.value == 'guest'){
              Router.neglect(context, () {context.goNamed('SIGNINPAGE');});
            // }else{
              print("Moving");
              print(homePage1Controller.copydata[index].id);
              // print(homePage1Controller.allpostdata[index]);
            await apiprovider.getComment(homePage1Controller.copydata[index].id);
            print("sddddddddddsdddddd");
            print(apiprovider.statuscode);
              context.pushNamed('ARTICLEDETAILPAGE', extra: homePage1Controller.copydata[index],queryParams: {"index": "$index"});
            // }
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
            left: MediaQuery.of(context).size.width*55/100,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children:  [
                     const Text(
                          "2.5k",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                       const SizedBox(width: 4,),
                       InkWell(
                        onTap: (){
                        apiprovider.postApi('/post/like-post', {
                          "postId": homePage1Controller.copydata[index].id.toString()
                        });
                        setState(() {
                          
                        });
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
                  // const Text(
                  //   "Viking",
                  //   style: TextStyle(color: Color(0xff0FC59A)),
                  //   // maxLines:,
                  //   overflow: TextOverflow.ellipsis,
                  // ),
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

