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
import 'package:tvtalk/model/ad_model.dart';
import 'package:tvtalk/model/notification_post_model.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/appbar.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

const maxfailLoadAttempt = 3;

class AdBlogCard extends StatefulWidget{
  var index;
  final BuildContext context;
  var title;
  var Content;
  var link;
  var adType;

   AdBlogCard(
      {Key? key, 
      required this.index,
      required this.context,
      required this.title,
      required this.Content,
      required this.link,
      required this.adType
      })
      : super(key: key);

  @override
  State<AdBlogCard> createState() => _AdBlogCardState();
}

final apiprovider = ApiProvider();
final signincontroller = Get.find<SignInController>();
// final homePageController = Get.find<HomePageController>();


getReadStatus(){
  // homePageController.readArticleId;
  // homePageController.allPostId;



  // for(int i = 0; i<homePageController.allPostId.length; i++){
  //  var result = homePageController.allPostId.contains(homePageController.readArticleId[i]);

  // }
}

class _AdBlogCardState extends State<AdBlogCard> {
  final adMobService  = AdMobService();
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getReadStatus();
    _createInterstitialAd();
    // if(widget.adType == 2){
      _controller = VideoPlayerController.network(
      "https://tv-talk.hackerkernel.com/ads/image/${widget.Content}",
    );
    _initializeVideoPlayerFuture = _controller?.initialize().then((value) =>
     _controller!.setLooping(true));
     _controller!.play();
     _controller!.setVolume(0.0);
    // }
  }

   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
     _controller?.dispose();
    _interstitialAd?.dispose();
  }
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempt =0;

  void _createInterstitialAd(){
  InterstitialAd.load(
    adUnitId: adMobService.interstitialADUnitId, 
    request:const AdRequest(), 
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
        // WebviewScaffold(
        //   appBar: appbar(context, "hemmlo"),
        //   url:await widget.link.toString());
      // _showInterstitialAd();
      homePage1Controller.appbar = true;
      await launchUrl(Uri.parse(widget.link),
      mode: LaunchMode.inAppWebView, 
      );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaY: 0),
                    child:
                    widget.adType == 2 ?
                     Container(
                      height: MediaQuery.of(context).size.height * 18 / 100,
                      width: MediaQuery.of(context).size.height * 16 / 100,
                      decoration: BoxDecoration(
                          image:  DecorationImage(
                        image:widget.Content == null ?
                         NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png')
                        : NetworkImage('https://tv-talk.hackerkernel.com/ads/image/${widget.Content}'),
                        fit: BoxFit.cover,
                        // colorFilter: ColorFilter.mode(
                        // widget.blogDetail.read == true ?colorconst.blackColor : colorconst.transparentColor, BlendMode.saturation
                        // )
                        ),
                      ),
                    ) :
                     widget.adType == 0 ?
                       Container(
                      height: MediaQuery.of(context).size.height * 18 / 100,
                      width: MediaQuery.of(context).size.height * 16 / 100,
                      child: Center(child: Text(widget.Content,
                      textAlign: TextAlign.center,
                      style:const TextStyle(
                        // fontSize: 20
                          fontWeight: FontWeight.bold
                      ),
                      )),
                    ): 
                     widget.adType == 1 ?
                      Stack(
                        children: [
                           FutureBuilder(
                          future: _initializeVideoPlayerFuture,
                          builder:(context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              return SizedBox(
                               height: MediaQuery.of(context).size.height * 18 / 100,
                               width: MediaQuery.of(context).size.height * 16 / 100,
                                child: AspectRatio(
                                  aspectRatio:_controller!.value.aspectRatio,
                                  child: VideoPlayer(_controller!),
                                  ),
                              );
                            }else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          },
                          ),
                          Positioned(
                            top: 50,
                            right: 35,
                            child:ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(CircleBorder()),
                                backgroundColor: MaterialStateProperty.all(Color.fromARGB(140, 193, 192, 192)),
                              ),
                              onPressed:(){
                                setState(() {
                                      // pause
                                      if (_controller!.value.isPlaying) {
                                        _controller!.pause();
                                      } else {
                                        // play
                                       _controller!.play();
                                    }
                                });
                              } , 
                              child:Icon(
                               _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                ),),
                          )
                        ],
                        
                      )
                     : null
                  ) 
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.all(16.0),
              //  width: c_width,
              height: MediaQuery.of(context).size.height * 18 / 100,
              width: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 25,
                    width: 35,
                    color: colorconst.mainColor,
                    child: Center(child: Text("Ad", 
                    style: TextStyle(
                      color: colorconst.whiteColor
                    ),
                    )),
                  ),
                  Text(widget.title),
                  Text("Advertisment by Tvtalk")
                ],
              ),
            ),    
          ],
        ),
      ),
    );
    
  }
}
