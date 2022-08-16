
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/routers.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/home_page1.dart';
import 'package:tvtalk/view/home_page2.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:tvtalk/view/home_page3.dart';
import 'package:tvtalk/view/home_page4.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fontSize = AdaptiveTextSize();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final user = FirebaseAuth.instance.currentUser;
   int pageIndex = 0;
   var apiProvider = ApiProvider();
   var homePageController = Get.find<HomePageController>();

   final items = [
    Column(children: const [Icon(Icons.home, size: 25,),],),
    Column(children: const [Icon(Icons.home, size: 25,),],),
    Column(children: const [Icon(Icons.home, size: 25,),],),
    Column(children: const [Icon(Icons.home, size: 25,),],),
    Column(children: const [Icon(Icons.home, size: 25,),],),
   ];
     
  final pages = [
    const HomePage1(),
    const HomePage2(),
    const SizedBox(),
    const HomePage3(),
    const HomePage4(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiProvider.getPost();
  }

  @override
  Widget build(BuildContext context){
    print("Google print");
    print(user);
    return Scaffold(
      extendBody: true,
      key: scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
        child: AppBar(
          toolbarHeight: 120.0,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xfffFFDC5C),
          title: const SizedBox( width: 110, child: Image(image: AssetImage("assets/images/logo.png",),)),
          leading: Obx(() {
              return homePageController.searchIcon.value ? IconButton(
                icon: const Image(
                  image: AssetImage(
                    'assets/icons/icon_menu.png',
                  ),
                  height: 24,
                ),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ): const SizedBox();
            }
          ),
          actions: [
             Obx(() {
                 return homePageController.searchIcon.value? IconButton(
                        onPressed: (){},
                        icon: const Image(
                          image: AssetImage("assets/icons/icon_dark.png"),
                          height: 24,
                        )) : const SizedBox();
               }
             ),
              
          Obx(() {
              return homePageController.searchIcon.value?  IconButton(
                    onPressed: () {},
                    icon: const Image(
                      image: AssetImage("assets/icons/icon_bell.png"),
                      height: 24,
                    )) : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,),
                        child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: TextFormField(
                          decoration: const InputDecoration(
                           fillColor: Colors.white,
                           border: OutlineInputBorder(),
                           labelText: 'Enter your username',
                           ),
                    ),
                        ),
                      ));
            }
          ), 
            Obx(() {
                return IconButton(
                    onPressed: (){
                      homePageController.searchIcon.toggle();
                    },
                    icon: homePageController.searchIcon.value ? const Image(
                      image: AssetImage("assets/icons/icon_search.png"),
                      height: 24,
                    ): Icon(Icons.cancel));
              }
            ),
                SizedBox(width: 10,),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: fontSize.getadaptiveTextSize(context, 60),
                  width: fontSize.getadaptiveTextSize(context, 60),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/profile.webp"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "John Cena",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text( 
                      "JohnCena@gmaio.com",
                      style: TextStyle(
                          // fontWeight: FontWeight.w200
                          color: Color(0xfff707070),
                          fontSize: 14),
                    )
                  ],
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  DrawerItems("assets/icons/savedIcon.png",
                      "My Saved Articles", (){
                        context.pushNamed('MYSAVEDARTICLES');
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
                  DrawerItems(
                      "assets/icons/icon_profile.png", "My Profile", () {
                        context.pushNamed('PROFILEPAGE');
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItems("assets/icons/icon_interest.png",
                      "My Interests", () {
                        context.pushNamed('MYINTEREST');
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItems(
                      "assets/icons/icon_share.png", "Share App", () {}),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItems(
                      "assets/icons/icon_rating.png", "Rate App", () {}),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItems("assets/icons/icon_tc.png",
                      "Terms & Conditions", () {
                        context.pushNamed('TERMANDCONDITION');
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItems("assets/icons/icon_privacy.png",
                      "Privacy Policy", () {
                        context.pushNamed('PRIVACYPOLICY');
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItems("assets/icons/icon_logout.png", "Logout",
                      () async {
                    print("sccccccccccccccccc");
                    final SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                    sharedPreferences.remove('email');
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    print("user details");
                    provider.logout();
                    // provider.user
                    print("user details--------");
                      context.goNamed("SIGNINPAGE");
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
        // backgroundColor: Colors.red,
      ),
      body:Obx((){
          return pages[homePageController.bootomNav.value];
        }
      ),
      // bottomNavigationBar: Obx(() {
      //     return buildMynavbar();
      //   }
      // ),
      bottomNavigationBar: Obx(() {
          return BottomAppBar(
            // clipBehavior: Clip.antiAliasWithSaveLayer,
            // notchMargin: 10,
          elevation: 20,
          shape: AutomaticNotchedShape(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0),),
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))  
          ),
          child: BottomNavigationBar(
          currentIndex: homePageController.bootomNav.value,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Color(0xffF1B142),
           selectedIconTheme:IconThemeData(color: Color(0xffF1B142)) ,   
          backgroundColor: Colors.transparent,
          
          // fixedColor: Colors.transparent,\
          onTap: (index){homePageController.bootomNav.value = index;},
          items:  [
            BottomNavigationBarItem(
              icon: SizedBox(height: 25, child: Image(image: AssetImage("assets/icons/icon_myfeed.png",),
              color:homePageController.bootomNav.value == 0 ?Color(0xffF1B142): Colors.black,)),
              label: "Feed",
              ),
              BottomNavigationBarItem(
              icon: SizedBox(height: 25, child: Image(image: AssetImage("assets/icons/icon_home.png",),
              color:homePageController.bootomNav.value == 1 ?Color(0xffF1B142): Colors.black,
              )),
              label: "Home",
              ),
              const BottomNavigationBarItem(
              icon: SizedBox(height: 25,),
              label: "fun&Games",
              ),
              BottomNavigationBarItem(
              icon: SizedBox(height: 25, child: Image(image: const AssetImage("assets/icons/icon_video.png",),
              color: homePageController.bootomNav.value == 3 ?Color(0xffF1B142): Colors.black,
              )),
              label: "Video",
              ),
              BottomNavigationBarItem(
              icon: SizedBox(height: 25, child: Image(image: AssetImage("assets/icons/icon_trending.png",),
              color:homePageController.bootomNav.value == 4 ?Color(0xffF1B142): Colors.black,
              )),
              label: "Trending",
              ),
          ],)
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
        }
      ),
     floatingActionButton: FloatingActionButton(
      backgroundColor: Color(0xfffF1B142),
      child: const SizedBox(
        height: 40,
        width: 40,
        child: Image(image: AssetImage("assets/icons/dice.png"),color: Colors.white,)),
    onPressed: (){
      context.pushNamed('FUNANDGAMES');
    },
   ),
   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


  Widget buildMynavbar(){
    return  AnimatedBottomNavigationBar( 
    // elevation: 0,
    icons: const [
      Icons.feed,
      Icons.home,
      Icons.video_call,
      Icons.trending_down,
    ],
    // borderColor: Color(0xffFFDC5C),
    // backgroundColor: Colors.grey,
    activeIndex: homePageController.bootomNav.value, 
    gapLocation: GapLocation.center,
    notchSmoothness: NotchSmoothness.sharpEdge, //for more curve use NotchSmoothness.verySmoothEdge
    leftCornerRadius: 0,
    rightCornerRadius: 0,
    activeColor: const Color(0xffFFDC5C),
    onTap: (index){
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




