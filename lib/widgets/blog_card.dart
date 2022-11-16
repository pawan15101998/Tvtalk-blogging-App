import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/admob_service.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';

const maxfailLoadAttempt = 3;

class BlogCard extends StatefulWidget{
   BlogCard(
      {Key? key,
      required this.indexx,
      required this.context,
      required this.blogDetail,
      // required this.isread
      })
      : super(key: key);

  final BuildContext context;
  final blogDetail;
  final indexx;
  // bool isread;
  @override
  State<BlogCard> createState() => _BlogCardState();
}


final apiprovider = ApiProvider();
final signincontroller = Get.find<SignInController>();
var isRead;
final homePageController = Get.find<HomePageController>();

getReadStatus(){
  // homePageController.readArticleId;
  // homePageController.allPostId;



  for(int i = 0; i<homePageController.allPostId.length; i++){
   var result = homePageController.allPostId.contains(homePageController.readArticleId[i]);

  }
}



class _BlogCardState extends State<BlogCard> {
  final adMobService  = AdMobService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getReadStatus();
    _createInterstitialAd();
  }

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
  }
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempt =0;

  void _createInterstitialAd(){
  InterstitialAd.load(
    adUnitId: adMobService.interstitialADUnitId, 
    request: AdRequest(), 
    adLoadCallback: InterstitialAdLoadCallback(
      onAdLoaded: (InterstitialAd ad){
        _interstitialAd =ad;
        _interstitialLoadAttempt = 0;
      }, 
      onAdFailedToLoad: (LoadAdError error) {
        _interstitialLoadAttempt += 1;
          _interstitialAd = null;
          if(_interstitialLoadAttempt>=maxfailLoadAttempt){
            _createInterstitialAd();
            }
      }));
}

void _showInterstitialAd(){
  if(_interstitialAd!= null){
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad){
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
  }
}

    final colorconst = ColorConst();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        _showInterstitialAd();
        await apiprovider.getComment(widget.indexx);
        if (signincontroller.isGuest.value == 'guest'){
          context.pushNamed('ARTICLEDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {
                "from": "SeenArticle",
                "index": "${widget.indexx}"});
          // Router.neglect(context, () {
          //   context.goNamed('SIGNINPAGE');
          // });
        } else {
          context.pushNamed('ARTICLEDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {
                "from": "SeenArticle",
                "index": "${widget.indexx}"});
        }

        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('Readed', widget.blogDetail.id);
         String? userid = sharedPreferences.getString('userId');
       List savedArticleId = await apiprovider.getSavedArticle(userid);
        for(int i=0; i<savedArticleId.length; i++){

        detailpageController.articleId.add(savedArticleId[i]['articleId']);
        }
      detailpageController.articleId.forEach((element) {
        print("this is all details");
        print(element.toString().contains(widget.blogDetail.id.toString()));
      if(element.toString().contains(widget.blogDetail.id.toString())){
        detailpageController.isArticleSaved.value = true;
      }else{
        detailpageController.isArticleSaved.value = false;
      }
    });

        var allldata = sharedPreferences.getInt('Readed');

        isRead = await apiprovider.postApi('/post/mark-read', {'postId': "${widget.blogDetail.id}"});

        widget.blogDetail.read == true;
        await  apiprovider.getArticleStatus();
      homePageController.readArticleId.value = [];
           homePageController.allPostId.value = [];
     for(int i =0; i<homePageController.readArticle.length; i++){
        homePageController.readArticleId.add(homePageController.readArticle[i]['articleId']);
       }
       for(int i =0; i<homePage1Controller.allpostdata.length; i++){
        homePageController.allPostId.add(homePage1Controller.allpostdata[i].id);
       }
       for(int i = 0; i<homePageController.allPostId.length; i++){
        if(homePageController.readArticleId.contains(homePageController.allPostId[i])){
          homePage1Controller.copydata[i].read = true;
           homePage1Controller.allpostdata[i].read = true;

          // homepage1controller.allpostdata.add({"read": true});
        }else{
          homePage1Controller.copydata[i].read = false;
          homePage1Controller.allpostdata[i].read = false;
        }
       }
    
        setState(() {
          
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          // color:widget.blogDetail.read == true? Colors.grey.withOpacity(0.3): colorconst.transparentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Stack(
                  children: [
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 18 / 100,
                        width: MediaQuery.of(context).size.height * 16 / 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image:
                          widget.blogDetail.featuredImageSrc != null?
                          NetworkImage(widget.blogDetail.featuredImageSrc, scale: 0.5,):
                         const NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                          widget.blogDetail.read == true ?colorconst.blackColor : colorconst.transparentColor, BlendMode.saturation)
                          ),
                        ),
                      ),
                    ),widget.blogDetail.read == true ?
                    Positioned(
                      bottom: 0,
                      left: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check, color: colorconst.whiteColor,),
                          Text("Read", style: TextStyle(color: colorconst.whiteColor),),
                        ],
                      ),
                    ):const SizedBox()
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  
                ),
                // padding: const EdgeInsets.all(16.0),
                //  width: c_width,
                height: MediaQuery.of(context).size.height * 18 / 100,
                width: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row(
                      // children: const [
                        // Text(
                        //   "The Boys",
                        //   style: TextStyle(
                        //     color: Color(0xfff00A17B),
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.w500
                        //   ),
                        // ),
                        // SizedBox(width: 100,),
                      // ],
                    // ),
                    InkWell(
                      // onTap: () async {
                      //   if (signincontroller.isGuest.value == 'guest') {
                      //     context.pushNamed('SIGNINPAGE');
                      //   } else {
                      //     context.pushNamed('ARTICLEDETAILPAGE',
                      //         extra: widget.blogDetail,
                      //         queryParams: {"index": "${widget.indexx}"});
                      //   }
                      //   final SharedPreferences sharedPreferences =
                      //       await SharedPreferences.getInstance();
                      //   sharedPreferences.setInt('Readed', widget.blogDetail.id);
                      //   var allldata = sharedPreferences.getInt('Readed');
                      //   isRead = await apiprovider.postApi(
                      //       'post/mark-read', {"postId": widget.blogDetail.id});
                      // },
                      child: Html(
                      data:widget.blogDetail.read == true ? "<p>${widget.blogDetail.title.rendered.length>120? widget.blogDetail.title.rendered.substring(0, 120)+'.......' : widget.blogDetail.title.rendered }</p>" : "<h4>${widget.blogDetail.title.rendered.length>120? widget.blogDetail.title.rendered.substring(0, 120)+'.......' : widget.blogDetail.title.rendered }</h4>",
                      // style: {
                      //   ''           
                      // },
                        // overflow: TextOverflow.ellipsis,
                        // maxLines: 3,
                        // style: const TextStyle(
                        //     height: 2, fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: ()async{
                            await Share.share(widget.blogDetail.link);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text("Share",
                                style: TextStyle(
                                  color: widget.blogDetail.read == true? Colors.grey: colorconst.blackColor,
                                ),
                                ),
                                SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: Image(
                                      image: AssetImage(
                                        "assets/icons/icon_share.png",
                                      ),color: widget.blogDetail.read == true? Colors.grey: colorconst.blackColor,
                                  ))
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text("2.5k",
                            style: TextStyle(
                              color: widget.blogDetail.read == true? Colors.grey: colorconst.blackColor,
                            ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                height: 22,
                                width: 22,
                                child: Image(
                                  image:const AssetImage(
                                    "assets/icons/heart.png",
                                  ),color: widget.blogDetail.read == true? Colors.grey: colorconst.blackColor,
                                 )
                              )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
