import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/model/get_comment_model.dart';
import 'package:tvtalk/routers.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/feeds_detail_page.dart';
import 'package:tvtalk/view/fun_&_games.dart';
import 'package:tvtalk/view/home_page1.dart';
import 'package:tvtalk/view/home_page2.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:tvtalk/view/home_page3.dart';
import 'package:tvtalk/view/home_page4.dart';
import 'package:url_launcher/url_launcher.dart';


// function check(time) { 
// console.log("mera time hai ye", time);
// var dateNow = moment().add(5.5, "h").toISOString();
// var newtime = moment(dateNow.split("T")[0] + "T" + ${time}Z,
// "YYYY-MM-DD HH:mm:ss").add(moment().utcOffset(), "m");
// var d1 = new Date(dateNow);
// var d2 = new Date(newtime);
// console.log("d1", d1);
// console.log("d2", d2);
// if (d1 >= d2) {return false;}
//  else {return true; 
//   }
// }


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var fontSize = AdaptiveTextSize();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
  final yourIntrestController = Get.find<YourIntrestController>();
  int pageIndex = 0;
  var apiProvider = ApiProvider();
  var homePageController = Get.find<HomePageController>();
  var homePage1Controller = Get.find<HomePage1Controller>();
  TextEditingController searchcontroller = TextEditingController();
  // String? userEmail;
  // String? imageurl;
  List? copydata;
  List? datacopy;
  final signincontroller = Get.find<SignInController>();
  final colorconst = ColorConst();

  final items = [
  Column(
      children: const [
        Icon(
          Icons.home,
          size: 25,
        ),
      ],
    ),
  Column(
      children: const [
        Icon(
          Icons.home,
          size: 25,
        ),
      ],
    ),
  Column(
      children: const [
        Icon(
          Icons.home,
          size: 25,
        ),
      ],
    ),
  Column(
      children: const [
        Icon(
          Icons.home,
          size: 25,
        ),
      ],
    ),
  Column(
      children: const [
        Icon(
          Icons.home,
          size: 25,
        ),
      ],
    ),
  ];

  final pages = [
    HomePage1(  key: settingState,),
    const HomePage2(),
    const FunAndGames(),
    const HomePage3(),
    const HomePage4(),
  ];



  @override
  void initState() {
    super.initState();
    getUSerDetails() async {
      // final SharedPreferences sharedPreferences =
      //     await SharedPreferences.getInstance();
      signincontroller.getuserdata();
    }

    getUSerDetails();
    datacopy = homePage1Controller.allpostdata;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  bool appbar = false;
  bool firstclickNotific = true;
  bool firstclickprofile = true;
  bool savearticleclick = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        key: scaffoldKey,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(fontSize.getadaptiveTextSize(context, 70)),
          child: AppBar(
            toolbarHeight: 100.0,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: colorconst.mainColor,
            title: const SizedBox(
                width: 110,
                child: Image(
                  image: AssetImage(
                    "assets/images/logo.png",
                  ),
                )),
            leading: Obx(() {
              return homePageController.searchIcon.value
                  ?
                  signincontroller.isGuest.value == "" ?
                   IconButton(
                      icon: const Image(
                              image: AssetImage(
                                'assets/icons/icon_menu.png',
                              ),
                              height: 24,
                            ),
                      onPressed: () async{
                        setState(() {});
                        scaffoldKey.currentState!.openDrawer();  
                      },
                    ) : InkWell(
                      onTap: () {
                         context.goNamed("SIGNINPAGE");
                      },
                      child: Icon(Icons.login, color: colorconst.blackColor,))
                  : const SizedBox();
            }),
            actions: [
              // Obx(() {
              //   return homePageController.searchIcon.value
              //       ? IconButton(
              //           onPressed: () {},
              //           icon: const Image(
              //             image: AssetImage("assets/icons/icon_dark.png"),
              //             height: 24,
              //           ))
              //       : const SizedBox();
              // }),
              Obx(() {
                return homePageController.searchIcon.value
                    ? IconButton(
                        onPressed: () async{
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          String? userid = sharedPreferences.getString('userId');
                          List notification =  await apiProvider.postApi("/user/show-notification", {
                            "userID": userid
                          });
                        homePageController.notificationData.value =  apiProvider.RegisterResponse;
                        var postid;
                        
                        if(firstclickNotific){
                          firstclickNotific = false;
                          context.pushNamed('NOTIFICATIONLIST');
                        }else{
                          firstclickNotific = true;
                        }
                        // for(int i=1; i<=homePageController.notificationData.value[0].length; i++){
                        //  List postData = jsonDecode(homePageController.notificationData.value[i]['jsonData']);
                        // // postid =  await apiProvider.postApi('/post/mark-read', {'postId': "${jsonDecode(homePageController.notificationData[i]['jsonData'])[0]['postId'][0]}"});
                        // print(postData);
                        // }
                        },
                        icon: Obx(() {
                            return Stack(
                              children: [
                                homePageController.unReadNotification != 0?
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 15,
                                    width: 15,
                                    decoration: BoxDecoration(
                                      color: colorconst.redColor,
                                      shape: BoxShape.circle
                                    ),
                                    child: Center(
                                      child: Text(homePageController.unReadNotification.toString(),style: TextStyle(
                                        fontSize: 10
                                      ),),
                                    ),
                                  ),
                                ) :const SizedBox(),
                              const Padding(
                                  padding:  EdgeInsets.all(5.0),
                                  child: Image(
                                  image: AssetImage("assets/icons/icon_bell.png"),
                                  height: 24,
                              ),
                                ),
                              ],
                            );
                          }
                        )
                        )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            // margin: const EdgeInsets.only(top: 20,),
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 80 / 100,
                              child: TextFormField(
                                controller: searchcontroller,
                                onChanged: homePage1Controller.searchFunction,
                                //  (value) {
                                //   // homePage1Controller.allpostdata[0].title.rendered = value;
                                //   copydata = homePage1Controller.allpostdata;
                                //   homePage1Controller.allpostdata.value =
                                //       copydata!
                                //           .where((i) => i.title.rendered
                                //               .toString()
                                //               .toLowerCase()
                                //               .contains(value.toLowerCase()))
                                //           .toList();
                                //   if (searchcontroller.text == "") {
                                //     apiProvider.getPost(
                                //         homePage1Controller.userTags.value);
                                //   }
                                //   // apiProvider.getPost(homePage1Controller.userTags.value);
                                //   //  searchcontroller.clear();`
                                //   // dataCopy![0].title.rendered = value;
                                //   // homePage1Controller.allpostdata.value = dataCopy!;
                                // },
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: colorconst.whiteColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: colorconst.whiteColor),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: colorconst.whiteColor,
                                  // suffixIcon: InkWell(
                                  //     onTap: () {
                                  //       homePageController.searchIcon.toggle();
                                  //       searchcontroller.clear();
                                  //       apiProvider.getPost(homePage1Controller.userTags.value);
                                  //     },
                                  //     child: Icon(Icons.cancel)),
                                  border: OutlineInputBorder(),
                                  hintText: 'Search',
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                //             : Expanded(
                //                 child: Center(
                //                 // margin: const EdgeInsets.only(top: 20,),
                //                 child: SizedBox(
                //                   height: 50,
                //                   width: MediaQuery.of(context).size.width * 80 / 100,
                //                   child: TextFormField(
                //                     controller: searchcontroller,
                //                     onChanged: (value) {
                //                       // homePage1Controller.allpostdata[0].title.rendered = value;
                //                       copydata = homePage1Controller.allpostdata;
                //                       homePage1Controller.allpostdata.value = copydata!
                //                           .where((i) => i.title.rendered
                //                               .toString()
                //                               .toLowerCase()
                //                               .contains(value.toLowerCase()))
                //                           .toList();
                //                       // searchcontroller.clear();`
                //                       // dataCopy![0].title.rendered = value;
                //                       // homePage1Controller.allpostdata.value = dataCopy!;
                //                     },
                //                     decoration: InputDecoration(
                //                       focusedBorder: OutlineInputBorder(
                //                         borderSide: BorderSide(color: colorconst.whiteColor),
                //                         borderRadius: BorderRadius.circular(10),
                //                       ),
                //                       enabledBorder: UnderlineInputBorder(
                //   borderSide: BorderSide(color: colorconst.whiteColor),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                //                       filled: true,
                //                       fillColor: colorconst.whiteColor,
                //                       suffixIcon: InkWell(
                //                           onTap: () {
                //                             homePageController.searchIcon.toggle();
                //                             searchcontroller.clear();
                //                             apiProvider.getPost(homePage1Controller.userTags.value);
                //                           },
                //                           child: Icon(Icons.cancel)),
                //                       border: OutlineInputBorder(),
                //                       hintText: 'Search',
                //                     ),
                //                   ),
                //                 ),
                //               ));
              }),
              Obx((){
                return IconButton(
                    onPressed:(){
                      context.pushNamed("SEARCHPAGE");
                      // homePageController.searchIcon.toggle();
                      // homePage1Controller.searchArticle.clear(); 
                      // homePage1Controller.allpostdata = [];
                      // apiProvider.getPost(homePage1Controller.userTags.value); 
                      },
                    icon: homePageController.searchIcon.value
                        ? const Image(
                            image: AssetImage("assets/icons/icon_search.png"),
                            height: 24,
                          )
                        : InkWell(
                            onTap:()async{
                              // homePage1Controller.allpostdata.clear();
                              // homePage1Controller.searchArticle = [].obs;
                              // await  apiProvider.getPost("32");
                              homePage1Controller.nosearch = "".obs;
                              homePageController.searchIcon.toggle();
                              searchcontroller.clear();
                              homePage1Controller.searchArticle.clear();
                            },
                            child: Icon(
                              Icons.cancel,
                              color: colorconst.blackColor,
                            ),
                          ));
              }),
            const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              InkWell(
                onTap: () async{
                  // showNotification()
                  await apiProvider.getprofile();
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  // if(sharedPreferences.getString('birthday') != null){
                  // homePageController.birthday.value = sharedPreferences.getString('birthday')!;
                  // }
                  if(firstclickprofile){
                    firstclickprofile = false;
                  context.pushNamed("PROFILEPAGE");
                  }else{
                    firstclickprofile = true;
                  }
          
                },
                child: DrawerHeader(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: fontSize.getadaptiveTextSize(context, 60),
                      width: fontSize.getadaptiveTextSize(context, 60),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: (homePageController.userDetails['data'] == null || homePageController.userDetails['data']['image'] == null)
                                ? const NetworkImage(
                                    "https://szabul.edu.pk/dataUpload/863noimage.png"):
                               NetworkImage("https://tv-talk.hackerkernel.com${homePageController.userDetails['data']['image']}"),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          signincontroller.userName != null
                              ? signincontroller.userName.toString()
                              : "",
                          //  userName != null? userName.toString(): "John Cena",
                          style:const TextStyle(fontSize: 18),
                        ),
                        Text(
                          signincontroller.userEmail != null
                              ? signincontroller.userEmail.toString()
                              : "",
                          // userEmail != null? userEmail.toString(): "John Cena",
                          style: const TextStyle(
                              // fontWeight: FontWeight.w200
                              color: Color(0xff707070),
                              fontSize: 14),
                        )
                      ],
                    )
                  ],
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    DrawerItems("assets/icons/savedIcon.png", "My Saved Articles",
                        () async{
                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          String? userid = sharedPreferences.getString('userId');
                        List getSavedArticle =  await apiProvider.getSavedArticle(userid);
                        List articleIdList = [];
                        String articleId;
                        for(int i= 0; i<getSavedArticle.length; i++){
                          articleIdList.add(getSavedArticle[i]['articleId']);
                        }
                      articleId = articleIdList.toString().replaceAll('[', '').replaceAll(']', '');
                      await apiProvider.getSavedPost(articleId);
                      if(savearticleclick){
                      savearticleclick = false;
                      context.pushNamed('MYSAVEDARTICLES');
                      }else{
                        savearticleclick = true;
                      }
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems("assets/icons/icon_quiz.png", "Quizes", () {
                      context.pushNamed('QUIZES');
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems(
                        "assets/icons/icon_puzzle.png", "Jigsaw Puzzle", () {}),
                    const SizedBox(
                      height: 10,  
                    ),
                    DrawerItems("assets/icons/icon_profile.png", "My Profile",
                        () async{
                      await apiProvider.getprofile();
                       context.pushNamed('PROFILEPAGE');
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    // DrawerItems("assets/icons/icon_interest.png", "My Interests",
                    //     () {
                    //   context.pushNamed('MYINTEREST');
                    // }),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    DrawerItems(
                        "assets/icons/icon_share.png", "Share App", () async{
                           await Share.share('https://tvtalk.page.link/hellol');
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems(
                        "assets/icons/icon_rating.png", "Rate App", (){
                          showDialog(context: context, builder: (_)=>AlertDialog(
                            title:const Text("Do you Want to Rate this App"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                              }, 
                              child:const Text("No")),
                              TextButton(onPressed: (){
                              launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.hackerkernel.scoreyourrun"));
                              Navigator.pop(context);
                              }, 
                              child:const Text("Yes"))
                            ],
                          ));
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems("assets/icons/icon_tc.png", "Terms & Conditions",
                        () {
                      context.pushNamed('TERMANDCONDITION');
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems("assets/icons/setting.png", "SETTING",
                        ()async{
                           // getuserDetails()async{
                           await apiProvider.getprofile();
                          print("this is user details");
                          print(homePageController.userDetails['data']['fcm_token']);
                          if(homePageController.userDetails['data']['fcm_token'] != null){
                            homePageController.notificationToggle = true;
                          }else{
                            homePageController.notificationToggle = false;
                          }
                          print(homePageController.notificationToggle);
                        // }
                         context.pushNamed('SETTING');
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems("assets/icons/icon_privacy.png", "Privacy Policy",
                        () {
                      context.pushNamed('PRIVACYPOLICY');
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems("assets/icons/feedback.png", "Feedback",
                        () {
                      context.pushNamed('FEEDBACK');
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    DrawerItems("assets/icons/icon_logout.png", "Logout",
                        () async {
                      final SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                      sharedPreferences.remove('email');
                      sharedPreferences.remove('name');
                      sharedPreferences.remove('image');
                      sharedPreferences.remove('reset_token');
                      sharedPreferences.remove('userId');
                      await apiProvider.postApi(
                      "/user/delete-fcm",
                       {}
                      );
                      final provider = Provider.of<GoogleSignInProvider>(context,
                          listen: false);
                      context.goNamed("SIGNINPAGE");
                      await provider.logout();
                      // provider.user
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
          // backgroundColor: colorconst.redColor,
        ),
        body: 
        homePage1Controller.allpostdata == [] ?Text("No Feed Found")  :Obx(() {
          return pages[homePageController.bootomNav.value];
        }),
        // bottomNavigationBar: Obx(() {
        //     return buildMynavbar();
        //   }
        // ),
        bottomNavigationBar: Obx((){
          return BottomAppBar(
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              // notchMargin: 10,
              elevation: 20,
              shape: AutomaticNotchedShape(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: BottomNavigationBar(
                currentIndex: homePageController.bootomNav.value,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                selectedItemColor: colorconst.lightYellow,
                selectedIconTheme: IconThemeData(color: colorconst.lightYellow),
                backgroundColor: colorconst.transparentColor,
                // fixedColor: colorconst.transparentColor,\
                onTap: (index) {
                  homePageController.bootomNav.value = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 25,
                        child: Image(
                          image: const AssetImage(
                            "assets/icons/icon_myfeed.png",
                          ),
                          color: homePageController.bootomNav.value == 0
                              ? colorconst.lightYellow
                              : colorconst.blackColor,
                        )),
                    label: "Feed",
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 25,
                        child: Image(
                          image: AssetImage(
                            "assets/icons/icon_home.png",
                          ),
                          color: homePageController.bootomNav.value == 1
                              ? colorconst.lightYellow
                              : colorconst.blackColor,
                        )),
                    label: "Home",
                  ),
                  const BottomNavigationBarItem(
                    
                    icon: SizedBox(
                      height: 25,
                      // width: 50,
                    ),
                    label: "Fun&Games",  
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 25,
                        child: Image(
                          image: const AssetImage(
                            "assets/icons/icon_video.png",
                          ),
                          color: homePageController.bootomNav.value == 3
                              ? colorconst.lightYellow
                              : colorconst.blackColor,
                        )),
                    label: "Video",
                  ),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                        height: 25,
                        child: Image(
                          image:const AssetImage(
                            "assets/icons/icon_trending.png",
                          ),
                          color: homePageController.bootomNav.value == 4
                              ? colorconst.lightYellow
                              : colorconst.blackColor,
                        )),
                    label: "Trending",
                  ),
                ],
              )
              // SizedBox(
              //   height: 60,
              //   child: Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       SizedBox(
              //         height: 40,
              //         child: Column(
              //           children: const[
              //             SizedBox(
              //               height: 25,
              //               child:Image(image: AssetImage("assets/icons/icon_myfeed.png"))
              //             ),
              //       Text("My Feed",style: TextStyle(
              //         fontSize: 10
              //       ),)
              //           ],
              //         ),
              //       ),
              //       InkWell(
              //         onTap: (){
              //         },
              //         child: SizedBox(
              //           height: 40,
              //           child: Column(
              //             children:const [
              //               SizedBox(
              //                 height: 25,
              //                 // width: 20,
              //                 child: Image(image: AssetImage("assets/icons/home_icon.webp"))
              //               ),
              //         Text("Home",style: TextStyle(
              //           fontSize: 10
              //         ),)
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(width: 15,),
              //       SizedBox(
              //         height: 40,
              //         child: Column(
              //           children: const[
              //             SizedBox(
              //               height: 25,
              //               child: Image(image: AssetImage("assets/icons/video_icon.png"))
              //             ),
              //       Text("Video",style: TextStyle(
              //         fontSize: 10
              //       ),)
              //           ],
              //         ),
              //       ),
              //      SizedBox(
              //         height: 40,
              //         child: Column(
              //           children: const[
              //             SizedBox(
              //               height: 25,
              //               child: Image(image: AssetImage("assets/icons/icon_trending.png"))
              //             ),
              //       Text("Trending",
              //       style: TextStyle(
              //         fontSize: 10
              //       ),
              //       )
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // color: Utiles.primary_bg_color,
              );
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: colorconst.lightYellow,
          child:  SizedBox(
              height: 40,
              width: 40,
              child: Image(
                image:const AssetImage("assets/icons/dice.png"),
                color: colorconst.whiteColor,
              )),
          onPressed: () {
            context.pushNamed('FUNANDGAMES');
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget upperList({name, index, bool isSelected = false, bgcolor}) {  
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

  Widget buildMynavbar() {
    return AnimatedBottomNavigationBar(
      // elevation: 0,
      icons: const [
        Icons.feed,
        Icons.home,
        Icons.video_call,
        Icons.trending_down,
      ],
      // backgroundColor: Colors.grey,
      activeIndex: homePageController.bootomNav.value,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness
          .sharpEdge, //for more curve use NotchSmoothness.verySmoothEdge
      leftCornerRadius: 0,
      rightCornerRadius: 0,
      activeColor: colorconst.mainColor,
      onTap: (index) {
        homePageController.bootomNav.value = index;
      },
      //other params
    );
  }
}

Widget DrawerItems(String icon, String title, ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      // height: 45,
      decoration: BoxDecoration(
          color: Color(0xfffF9EDD9), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title),
        leading: Image(
          image: AssetImage(icon),
          height: 24,
        ),
        minLeadingWidth: 10,
      ),
    ),
  );
}
