// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tvtalk/constant/front_size.dart';
// import 'package:tvtalk/view/home_page1.dart';
// import 'package:tvtalk/view/home_page2.dart';

// class MainHomepage extends StatefulWidget {
//   const MainHomepage({Key? key}) : super(key: key);

//   @override
//   State<MainHomepage> createState() => _MainHomepageState();
// }

// class _MainHomepageState extends State<MainHomepage> {
//   var scaffoldKey = GlobalKey<ScaffoldState>();
//     var fontSize = AdaptiveTextSize();
    
//    int pageIndex = 0;
  
//   final pages = [
//     const HomePage1(),
//     const HomePage2(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           key: scaffoldKey,
//           appBar: PreferredSize(
//             preferredSize:
//                 Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
//             child: AppBar(
//               toolbarHeight: 120.0,
//               elevation: 0,
//               // automaticallyImplyLeading: false,
//               backgroundColor: Color(0xfffFFDC5C),
//               title: SizedBox( width: 110, child: Image(image: AssetImage("assets/images/logo.png",),)),
//               leading: IconButton(
//                 icon: const Image(
//                   image: AssetImage(
//                     'assets/icons/icon_menu.png',
//                   ),
//                   height: 24,
//                 ),
//                 onPressed: () {
//                   scaffoldKey.currentState!.openDrawer();
//                 },
//               ),
//               actions: [
//                 IconButton(
//                     onPressed: () {},
//                     icon: Image(
//                       image: AssetImage("assets/icons/icon_bell.png"),
//                       height: 24,
//                     )),
//                 IconButton(
//                     onPressed: () {},
//                     icon: Image(
//                       image: AssetImage("assets/icons/icon_search.png"),
//                       height: 24,
//                     )),
//               ],
//             ),
//           ),
//           drawer: Drawer(
//             child: ListView(
//               children: [
//                 DrawerHeader(
//                     child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: fontSize.getadaptiveTextSize(context, 60),
//                       width: fontSize.getadaptiveTextSize(context, 60),
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("assets/images/profile.webp"),
//                             fit: BoxFit.cover),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const [
//                         Text(
//                           "John Cena",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         Text(
//                           "JohnCena@gmaio.com",
//                           style: TextStyle(
//                               // fontWeight: FontWeight.w200
//                               color: Color(0xfff707070),
//                               fontSize: 14),
//                         )
//                       ],
//                     )
//                   ],
//                 )),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   child: Container(
//                     // height: 45,
//                     child: Column(
//                       children: [
//                         DrawerItems("assets/icons/savedIcon.png",
//                             "My Saved Articles", (){
//                               context.pushNamed('MYSAVEDARTICLES');
//                             }),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems("assets/icons/icon_quiz.png", "Quizes", () {
//                           context.pushNamed('QUIZES');
//                         }),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems(
//                             "assets/icons/icon_puzzle.png", "Jigsaw Puzzle", () {}),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems(
//                             "assets/icons/icon_profile.png", "My Profile", () {
//                               context.pushNamed('PROFILEPAGE');
//                             }),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems("assets/icons/icon_interest.png",
//                             "My Interests", () {
//                               context.pushNamed('MYINTEREST');
//                             }),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems(
//                             "assets/icons/icon_share.png", "Share App", () {}),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems(
//                             "assets/icons/icon_rating.png", "Rate App", () {}),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems("assets/icons/icon_tc.png",
//                             "Terms & Conditions", () {
//                               context.pushNamed('TERMANDCONDITION');
//                             }),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems("assets/icons/icon_privacy.png",
//                             "Privacy Policy", () {
//                               context.pushNamed('PRIVACYPOLICY');
//                             }),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         DrawerItems("assets/icons/icon_logout.png", "Logout",
//                             () async {
//                           print("sccccccccccccccccc");
//                           final SharedPreferences sharedPreferences =
//                               await SharedPreferences.getInstance();
//                           sharedPreferences.remove('email');
//                           Router.neglect(context, () {
//                             context.goNamed('SIGNINPAGE');
//                           });
//                         }),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             // backgroundColor: Colors.red,
//           ),
//           body:pages[pageIndex],
//           bottomNavigationBar: buildMyNavBar(context),
//         );
//   }

  
// Widget DrawerItems(String icon, String title, ontap) {
//   return InkWell(
//     onTap: ontap,
//     child: Container(
//       // height: 45,
//       decoration: BoxDecoration(
//           color: Color(0xfffF9EDD9), borderRadius: BorderRadius.circular(10)),
//       child: ListTile(
//         title: Text(title),
//         leading: Image(
//           image: AssetImage(icon),
//           height: 24,
//         ),
//         minLeadingWidth: 10,
//       ),
//     ),
//   );
// }

//   Container buildMyNavBar(BuildContext context){
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           InkWell(
//             onTap: (){
//                  
//             },
//             child: Text(
//               "Feeds for me",
//               style: TextStyle(
//                 backgroundColor: Color(0xfffFFDC5C),
//                 fontSize:16,
//                 fontWeight:  pageIndex == 0? FontWeight.bold: FontWeight.normal
//               ),
//             ),
//           ),
//           InkWell(
//             onTap: (){
//                 
//             },
//             child: Text(
//               "HomePage",
//               style: TextStyle(
//                 backgroundColor: Color(0xfffFFDC5C),
//                 fontSize:16,
//                 fontWeight: pageIndex == 1? FontWeight.bold: FontWeight.normal
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }