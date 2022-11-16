import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taboola_sdk/publisher_info.dart';
import 'package:taboola_sdk/standard/taboola_standard.dart';
import 'package:taboola_sdk/standard/taboola_standard_builder.dart';
import 'package:taboola_sdk/standard/taboola_standard_listener.dart';
import 'package:taboola_sdk/taboola.dart';
import 'package:tvtalk/admob_service.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/theme.dart';
import 'package:tvtalk/view/dialog/theme_dialog.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;
import 'package:timeago/timeago.dart' as timeago;
import 'package:tvtalk/view/home_page.dart';
import 'package:tvtalk/view/home_page1.dart';
import 'package:tvtalk/view/profile_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/get_comment_model.dart';

final settingState = GlobalKey<HomePage1State>();
class ArticleDetailPage extends StatefulWidget {
  dynamic postData;
  Map feedindex;
  final from;
  ArticleDetailPage({Key? key, this.postData,  required this.feedindex, this.from }) : super(key: key);

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final urlImages = [
    'assets/images/slider1.png',
    'assets/images/slider2.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png',
  ];

  Stream streamController(pageindex)=> Stream.fromFuture(
        apiprovider.getComment(homepage1controller.copydata[pageindex].id)
  );


  ScrollController scrollController = ScrollController();
  List<TextEditingController>? replayController;
  final themedialog = ThemeDialog();
  bool commentShow = false;
  final apiprovider = ApiProvider();
  final commentController = TextEditingController();
  // final replayController = TextEditingController();
  var detailpageController = Get.find<DetailPageController>();
  final getallcommment = GetComment();
  final textSize =  AdaptiveTextSize();
  final getcomment = GetComment();
  PageController? pageController;
  int? pageindex;

final adMobService  = AdMobService();
final signincontroller = Get.find<SignInController>();
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _createInterstitialAd();
    Taboola.setLogsEnabled(true);
    apiprovider.getComment(widget.postData.id);
    int indexint = int.parse(widget.feedindex['index']);
    pageController = PageController(initialPage: indexint);
  }

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd?.dispose();
  }
  InterstitialAd? _interstitialAd;
  int _interstitialLoadAttempt =0;
  final homepage1controller = Get.find<HomePage1Controller>();
  final colorconst = ColorConst();

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

Future<bool>willpop()async{
context.goNamed("HOMEPAGE");
return Future.value(false);
  }
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        onPageChanged: (value)async {
          if((value + 1) % 3 == 0){
            _showInterstitialAd(); 
          }
         await apiprovider.getComment(homepage1controller.copydata[value].id);
         await apiprovider.postApi('/post/mark-read', {'postId': "${homepage1controller.copydata[value].id}"});
         homepage1controller.allpostdata[value].read = true;
         homepage1controller.copydata[value].read = true;
         homePageController.isArticleRead();
         settingState.currentState!.refreshWidget();
         setState((){});
        },
        itemCount: homepage1controller.copydata.length,
        controller: pageController,
        itemBuilder: (BuildContext context, int pageindex){
          return StreamBuilder(
            stream: streamController(pageindex),
            builder: (context, snapshot) {
              return CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  Obx((){
                    return SliverAppBar(
                      iconTheme: IconThemeData(
                        color: detailpageController.isDark.value
                            ? colorconst.whiteColor
                            : colorconst.blackColor,
                      ),
                      toolbarHeight: 80,
                      pinned: true,
                      snap: false,
                      floating: false,
                      expandedHeight: 250.0,
                      flexibleSpace: DecoratedBox(
                        decoration: BoxDecoration(
                            color: detailpageController.isDark.value
                                ? colorconst.blackColor
                                : colorconst.mainColor),
                        child: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: Container(
                            decoration: BoxDecoration(
                image: DecorationImage(
                image: homepage1controller.allpostdata[pageindex].featuredImageSrc != null?
                widget.feedindex['from'] == 'SavedArticle'?
                NetworkImage(homePageController.savedArticles[pageindex].featuredImageSrc, scale: 0.5):
                widget.feedindex['from'] == 'SearchArticle'?
                NetworkImage(homepage1controller.searchArticle[pageindex].featuredImageSrc, scale: 0.5):
                NetworkImage(homepage1controller.allpostdata[pageindex].featuredImageSrc, scale: 0.5):
                const NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                      fit: BoxFit.cover,)
                      ),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                                onTap:(){
                                  themedialog.showThemeDialog(context, "knkn");
                                },
                                child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Obx(() {
                                      return Image(
                                        image: const AssetImage(
                                          "assets/icons/font_family.png",
                                        ),
                                        color: detailpageController.isDark.value
                                            ? colorconst.whiteColor
                                            : colorconst.blackColor,
                                      );
                                    })))),
                           Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 5),
                            child: InkWell(
                              onTap: () {
                               
                              },
                              child: SizedBox(
                                  height: 25,
                                  width: 25,
                                   child: Obx(() {
                                    return Image(
                                      image:const AssetImage(
                                        "assets/icons/heart.png",
                                      ) ,
                                      color: detailpageController.isDark.value
                                          ? colorconst.whiteColor
                                          : colorconst.blackColor,
                                    );
                                  })),
                            )),
                        Padding(
                            padding:const EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: ()async{
                                await Share.share(widget.postData.link);
                              },
                              child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: Obx(() {
                                    return Image(
                                      image: const AssetImage(
                                        "assets/icons/share.png",
                                      ),
                                      color: detailpageController.isDark.value
                                          ? colorconst.whiteColor
                                          : colorconst.blackColor,
                                    );
                                  })),
                            )),
                        const SizedBox(
                          width: 15,
                        )
                      ],
                      bottom: PreferredSize(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: 
                                // Obx(() {
                                //   return 
                                  buildIndicatorTrending(ind: pageindex)
                                // }),
                              ),
                        preferredSize: Size.fromHeight(0))
                    );
                  }),
                  SliverToBoxAdapter(
                    child: Obx(() {
                      return Container(
                        color: detailpageController.isDark.value
                            ? colorconst.blackColor
                            : colorconst.whiteColor, //Dark theme
                        height: 20,
                      );
                    }),
                  ),
                       SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                            return Obx(() {
                              return Container(
                                color: detailpageController.isDark.value
                                    ? colorconst.blackColor
                                    : colorconst.whiteColor, //dark Theme
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      // Center(child: buildIndicator( pageindex)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Html(
                                            data: "<p>${
                                            widget.feedindex['from'] == 'SavedArticle'? 
                                            homePageController.savedArticles[pageindex].title.rendered:
                                            widget.feedindex['from'] == 'SearchArticle'? 
                                             homepage1controller.searchArticle[pageindex].title.rendered:
                                             homepage1controller.copydata[pageindex].title.rendered}</p>",    
                                            style:{
                                                'p': Style(
                                                  margin: EdgeInsets.zero,
                                                  padding: EdgeInsets.zero,
                                                  width: MediaQuery.of(context).size.width,
                                                 fontSize: const FontSize(18),
                                                 color: detailpageController.isDark.value
                                                  ? colorconst.whiteColor
                                                  : colorconst.blackColor,
                                                ),
                                            }
                                            // widget.postData.title.rendered,
                                            // style: TextStyle(
                                            //   fontSize: 20,
                                            //   fontWeight: FontWeight.w700,
                                            //   fontFamily: 'Poppins',
                                            //   color: detailpageController.isDark.value
                                            //       ? colorconst.whiteColor
                                            //       : colorconst.blackColor,
                                            // ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // Container(
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.yellow,
                                          //       borderRadius: BorderRadius.circular(9)),
                                          //   child: const Padding(
                                          //     padding: EdgeInsets.all(8.0),
                                          //     child: FittedBox(
                                          //       fit: BoxFit.fitHeight,
                                          //       child: Text(
                                          //         "The Boys",
                                          //         style: TextStyle(
                                          //             fontWeight: FontWeight.w600),
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                            Text(widget.feedindex['from'] == 'SavedArticle' ?
                                              homePageController.savedArticles[pageindex].date.toString().split(" ").first:
                                              widget.feedindex['from'] == 'SearchArticle' ?
                                                  homepage1controller.searchArticle[pageindex].date.toString().split(" ").first:
                                                  homepage1controller.copydata[pageindex].date.toString().split(" ").first,
                                                style:  TextStyle(color: colorconst.greyColor,
                                                fontSize: 12
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: (){
                                                        scrollController.animateTo(scrollController.position.maxScrollExtent-300,
                                                     duration: const Duration(milliseconds: 500),
                                                     curve: Curves.easeInOut);
                                                    },
                                                    child: Text(
                                                      "${detailpageController.commentData?.data?.comments?.rows?.length} Comments",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            detailpageController.isDark.value
                                                                ? colorconst.whiteColor
                                                                : colorconst.blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.comment,
                                                    color: detailpageController.isDark.value
                                                        ? colorconst.whiteColor
                                                        : colorconst.blackColor,
                                                    size: 20,
                                                  )
                                                ],
                                              ),
                                              Obx(() {
                                                  return Row(
                                                    children: [
                                                     InkWell(
                                                      onTap: ()async{
                                                        widget.postData.read == true;
                                                        detailpageController.isArticleSaved.toggle();
                                                          final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                                           String? userid = sharedPreferences.getString('userId');
                                                        await apiprovider.saveArticle('/user/save-articles', {
                                                          'articleId': homepage1controller.copydata[pageindex].id.toString(),
                                                          'userId': userid
                                                        });
                                                     
                                                        if(apiprovider.RegisterResponse['message']== 'Article Add Sucessfully'){
                                                        Flushbar(
                                                           backgroundColor: colorconst.greenColor,
                                                           message: "Article Saved to My saved Article Section",
                                                            duration: Duration(seconds: 2),
                                                            ).show(context);
                                                        }else if(apiprovider.RegisterResponse['message']== 'Article removed Sucessfully'){
                                                          Flushbar(
                                                           backgroundColor: colorconst.redColor,
                                                           message: "Article Removed from your My saved Article Section",
                                                            duration: Duration(seconds: 2),
                                                            ).show(context);
                                                        }else{
                                                          
                                                        }
                                                      },
                                                       child: detailpageController.isArticleSaved.value == true ? Text(
                                                          "Saved",
                                                          style:
                                                              TextStyle(color: colorconst.greyColor),
                                                        ) : detailpageController.isArticleSaved.value == false ? Text("Save", 
                                                        style:
                                                              TextStyle(color: colorconst.greyColor),
                                                        ):const SizedBox(),
                                                     ),
                                                    detailpageController.saveArticles == true ?
                                                    const Image(image: AssetImage("assets/icons/iconsave.png")):
                                                    const Image(image: AssetImage("assets/icons/iconsave.png"))
                                                    ],
                                                  );
                                                }
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: detailpageController.isDark.value
                                          ? colorconst.whiteColor
                                          : colorconst.blackColor,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Html(
                                              data:widget.feedindex['from'] == 'SavedArticle' ? 
                                              homePageController.savedArticles[pageindex].content.rendered :
                                              widget.feedindex['from'] == 'SearchArticle'?
                                                homepage1controller.searchArticle[pageindex].content.rendered:
                                               homepage1controller.copydata[pageindex].content.rendered,
                                              style: {
                                                'blockquote P': Style(
                                                  fontWeight: FontWeight.w900,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                                'figure': Style(
                                                  width: MediaQuery.of(context).size.width,
                                                  margin: EdgeInsets.zero,
                                                  padding: EdgeInsets.zero
                                                ),
                                                'p': Style(
                                                    fontSize: FontSize(detailpageController
                                                                .fontSize ==
                                                            12
                                                        ? 12
                                                        : detailpageController.fontSize ==
                                                                14
                                                            ? 14
                                                            : detailpageController.fontSize ==
                                                                    16
                                                                ? 16
                                                                : detailpageController.fontSize ==
                                                                        18
                                                                    ? 18
                                                                    : detailpageController
                                                                                .fontSize ==
                                                                            20
                                                                        ? 20
                                                                        : detailpageController.fontSize ==
                                                                                22
                                                                            ? 22
                                                                            : detailpageController.fontSize ==
                                                                                    24
                                                                                ? 24
                                                                                : null),
                                                    fontFamily: detailpageController
                                                                .fontFamily.value ==
                                                            1
                                                        ? "QUICKSAND"
                                                        : detailpageController.fontFamily.value ==
                                                                2
                                                            ? "NOTO SERIF"
                                                            : detailpageController
                                                                        .fontFamily.value ==
                                                                    3
                                                                ? "Montserrat"
                                                                : detailpageController
                                                                            .fontFamily
                                                                            .value ==
                                                                        4
                                                                    ? "VIDALOKA"
                                                                    : "POPPINS",
                                                    color: detailpageController.isDark.value
                                                        ? colorconst.whiteColor
                                                        : colorconst.blackColor),
                                                'h2': Style(
                                                    fontSize: FontSize(detailpageController
                                                                .fontSize ==
                                                            12
                                                        ? 12
                                                        : detailpageController.fontSize ==
                                                                14
                                                            ? 14
                                                            : detailpageController.fontSize ==
                                                                    16
                                                                ? 16
                                                                : detailpageController.fontSize ==
                                                                        18
                                                                    ? 18
                                                                    : detailpageController
                                                                                .fontSize ==
                                                                            20
                                                                        ? 20
                                                                        : detailpageController.fontSize ==
                                                                                22
                                                                            ? 22
                                                                            : detailpageController.fontSize ==
                                                                                    24
                                                                                ? 24
                                                                                : null),
                                                    fontFamily: detailpageController
                                                                .fontFamily.value ==
                                                            1
                                                        ? "QUICKSAND"
                                                        : detailpageController.fontFamily.value ==
                                                                2
                                                            ? "NOTO SERIF"
                                                            : detailpageController
                                                                        .fontFamily.value ==
                                                                    3
                                                                ? "Montserrat"
                                                                : detailpageController
                                                                            .fontFamily
                                                                            .value ==
                                                                        4
                                                                    ? "VIDALOKA"
                                                                    : "POPPINS",
                                                    color: detailpageController.isDark.value
                                                        ? colorconst.whiteColor
                                                        : colorconst.blackColor),
                                                'figcaption': Style(
                                                    fontSize: const FontSize(12),
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic),
                                                'img src': Style(
                                                  //  color: colorconst.blueColor
                                                  width: 20,
                                                ),
                                                'li': Style(
                                                    fontSize: FontSize(detailpageController
                                                                .fontSize ==
                                                            12
                                                        ? 12
                                                        : detailpageController.fontSize ==
                                                                14
                                                            ? 14
                                                            : detailpageController.fontSize ==
                                                                    16
                                                                ? 16
                                                                : detailpageController.fontSize ==
                                                                        18
                                                                    ? 18
                                                                    : detailpageController
                                                                                .fontSize ==
                                                                            20
                                                                        ? 20
                                                                        : detailpageController.fontSize ==
                                                                                22
                                                                            ? 22
                                                                            : detailpageController.fontSize ==
                                                                                    24
                                                                                ? 24
                                                                                : null),
                                                    fontFamily: detailpageController
                                                                .fontFamily.value ==
                                                            1
                                                        ? "QUICKSAND"
                                                        : detailpageController.fontFamily.value ==
                                                                2
                                                            ? "NOTO SERIF"
                                                            : detailpageController
                                                                        .fontFamily.value ==
                                                                    3
                                                                ? "Montserrat"
                                                                : detailpageController
                                                                            .fontFamily
                                                                            .value ==
                                                                        4
                                                                    ? "VIDALOKA"
                                                                    : "POPPINS",
                                                    color: detailpageController.isDark.value
                                                        ? colorconst.whiteColor
                                                        : colorconst.blackColor)
                                              },
                                              onAnchorTap:
                                                  (url, context, attributes, element)async {
                                                     if(await canLaunchUrl(Uri.parse(url!))){
                                                      await  launchUrl(Uri.parse(url));
                                                    }else{
                                                      throw 'Could  not launch $url';
                                                    }
                                                   
                                                  },
                                              onLinkTap: (String? url,
                                                  RenderContext context,
                                                  Map<String, String> attributes,
                                                  dom.Element? element){
                                  
                                                //open URL in webview, or launch URL in browser, or any other logic here
                                              }),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                            const CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    'https://picsum.photos/id/237/200/300'),
                                              ),
                                             const SizedBox(
                                                width: 10,
                                              ),
                                              Text("Article by",
                                                  style:
                                                      detailpageController.fontfamily("")),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text("Unknown",
                                                  style:
                                                      detailpageController.fontfamily(""))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                      child: Divider(
                                        color: detailpageController.isDark.value
                                            ? colorconst.whiteColor
                                            : colorconst.blackColor,
                                      ),
                                    ),
                                    Padding(
                                      padding:const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text(
                                        "Similar Articles",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: detailpageController.isDark.value
                                                ? colorconst.whiteColor
                                                : colorconst.blackColor,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                   const SizedBox(
                                      height: 20,
                                    ),
                                    CarouselSlider.builder(
                                      options: CarouselOptions(
                                          height: 300.0,
                                          // autoPlay: true,
                                          enableInfiniteScroll: false,
                                          onPageChanged: ((index, reason) {
                                            // homePage1 = index;
                                            detailpageController.DetailScroll.value = index;
                                          })),
                                      itemCount: homepage1controller.allpostdata.length,
                                      itemBuilder: ((context, index, realIndex) {
                                        final urlImage =homepage1controller.allpostdata[index].featuredImageSrc;
                                        return buildSimilarImage(context, urlImage, index,);
                                      }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    // Obx(() {
                                    //   return
                                       Obx(() {
                                           return Center(child: buildIndicatorSimple());
                                         }
                                       ),
                                    // }),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      color: detailpageController.isDark.value
                                          ? colorconst.whiteColor
                                          : colorconst.blackColor,
                                    ),
                                    signincontroller.isGuest.value == 'guest'
                                   ?  InkWell(
                                    onTap: (){
                                      context.pushNamed("SIGNINPAGE");
                                    },
                                    child: Text("Login to add comment"))  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Obx((){   
                           replayController = [
                          for (int i = 1; i <= detailpageController.commentData!.data!.comments!.rows!.length; i++)
                            TextEditingController()
                                                ];
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                      "Comments(${detailpageController.commentData!.data!.comments!.count})",
                                                      style:
                                                          detailpageController.fontfamily("")),
                                                  Row(
                                                    children: [
                                                      Obx(() {
                                                        return detailpageController
                                                                .CommentShow.value
                                                            ? InkWell(
                                                              onTap: (){
                                                                 detailpageController.CommentShow
                                                                .toggle();
                                                              },
                                                              child: Text("Hide Comments",
                                                                  style: detailpageController
                                                                      .fontfamily("")),
                                                            )
                                                            : detailpageController
                                                                        .commentData!
                                                                        .data!
                                                                        .comments!
                                                                        .count !=
                                                                    0
                                                                ? InkWell(
                                                                  onTap: () {
                                                                     detailpageController.CommentShow
                                                                .toggle();
                                                                  },
                                                                  child: Text(
                                                                      "Show Comments",
                                                                      style: TextStyle(
                                                                        color:
                                                                            detailpageController
                                                                                    .isDark.value
                                                                                ? Colors.grey
                                                                                : colorconst.blackColor,
                                                                      ),
                                                                    ),
                                                                )
                                                                : SizedBox();
                                                      }),
                                                      InkWell(
                                                          onTap: () {
                                                            detailpageController.CommentShow
                                                                .toggle();
                                                          },
                                                          child: detailpageController
                                                                      .commentData!
                                                                      .data!
                                                                      .comments!
                                                                      .count !=
                                                                  0
                                                              ? SizedBox(
                                                                  height: 18,
                                                                  width: 18,
                                                                  child: Image(
                                                                    image: AssetImage(
                                                                        "assets/icons/expend_icon.webp"),
                                                                    color: detailpageController
                                                                            .isDark.value
                                                                        ? Colors.grey
                                                                        : colorconst.blackColor,
                                                                  ))
                                                              : SizedBox())
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Container(
                                                width: MediaQuery.of(context).size.width *
                                                    90 /
                                                    100,
                                                height:
                                                    textSize.getadaptiveTextSize(context, 45),
                                                padding:
                                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: TextFieldColor),
                                                child: TextFormField(
                                                    controller: commentController,
                                                    // controller: widget.controller,
                                                    decoration: InputDecoration(
                                                      suffixIcon: InkWell(
                                                          onTap: () {
                                                            apiprovider.postApi(
                                                                '/post/create-comment', {
                                                              'postId':
                                                                  widget.postData.id.toString(),
                                                              'content': commentController.text
                                                            });
                                                            if (apiprovider.statuscode == 200) {
                                                              if(commentController.text != ""){
                                                                final snackBar = SnackBar(
                                                                backgroundColor: colorconst.greenColor,
                                                                content: const Text(
                                                                    "Comment add sucessfully"),
                                                                action: SnackBarAction(
                                                                  label: '',
                                                                  onPressed: () {
                                                                    // Some code to undo the change.
                                                                  },
                                                                ),
                                                              );
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(snackBar);
                                                              }else{
                                                                final snackBar = SnackBar(
                                                                backgroundColor: colorconst.redColor,
                                                                content: const Text(
                                                                    "Write something to add comment"),
                                                                action: SnackBarAction(
                                                                  label: '',
                                                                  onPressed: () {
                                                                    // Some code to undo the change.
                                                                  },
                                                                ),
                                                              );
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(snackBar);
                                                              }
                                                              
                                                                  setState(() {
                                                                    
                                                                  });
                                                            }
                                                            commentController.clear();
                                                            apiprovider
                                                                .getComment(widget.postData.id);
                                                          },
                                                          child: const SizedBox(
                                                              height: 10,
                                                              width: 10,
                                                              child: Image(
                                                                  image: AssetImage(
                                                                      "assets/icons/icon_check.png")))),
                                                      fillColor: const Color(0xffFEDC5D),
                                                      border: InputBorder.none,
                                                      label: Text(
                                                        "Add your comment ",
                                                      ),
                                                    )),
                                              ),
                                             
                                                 detailpageController
                                                          .commentData!.data!.comments!.count !=
                                                      0
                                                  ? Obx(() {
                                                      return detailpageController
                                                              .CommentShow.value
                                                          ? Column(
                                                              children: [
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                      
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                     ListView.builder(
                                                                      shrinkWrap: true,
                                                                      physics:
                                                                          const ScrollPhysics(),
                                                                      itemCount:
                                                                          detailpageController
                                                                              .commentData!
                                                                              .data!
                                                                              .comments!
                                                                              .rows!
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context, index) {
                                                                        return ExpendedComment(
                                                                            index,
                                                                            detailpageController
                                                                                .commentData!
                                                                                .data!
                                                                                .comments!
                                                                                .rows![index]
                                                                                .replies!
                                                                                .length);
                                                                      },
                                                                    )
                                                                 
                                      
                                                                // ExpendedComment(2),
                                                                // ExpendedComment(1),
                                                              ],
                                                            )
                                                          : SmallContainer();
                                                    })
                                                  : Text("no comment yet")
                                              
                                            ],
                                          );
                                        }
                                      ),
                                    ),
                                    const Divider(),
                                     taboolaStandard,
                                  ],
                                ),
                              );
                            });
                          },
                          childCount: 1,
                        ),
                      )
                ],
              );
            }
          );
        }
      ),
    );
  }

  Widget SmallContainer(){
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                 CircleAvatar(
                  backgroundImage: detailpageController
                      .commentData!.data!.comments!.rows![0].user!.image != null ?
                       NetworkImage("https://tv-talk.hackerkernel.com${detailpageController.commentData!.data!.comments!.rows![0].user!.image}"):
                      NetworkImage('https://picsum.photos/id/237/200/300', ),
                  
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  detailpageController
                      .commentData!.data!.comments!.rows![0].user!.name
                      .toString(),
                  style: TextStyle(
                    color: detailpageController.isDark.value
                        ? colorconst.whiteColor
                        : colorconst.blackColor,
                  ),
                )
              ],
            ),
            Text(
              timeago.format(DateTime.parse(detailpageController.commentData!.data!.comments!.rows![0].createdAt!)),
              // DateTime.now().toString(),
              // detailpageController
              //     .commentData!.data!.comments!.rows![0].createdDate
              //     .toString(),
              style: TextStyle(color: colorconst.greyColor),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detailpageController
                    .commentData!.data!.comments!.rows![0].content
                    .toString(),
                style: detailpageController.fontfamily(""),
                textAlign: TextAlign.right,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      if (detailpageController.commentData!.data!.comments !=
                          null)
                        InkWell(
                          onTap: () {
                            apiprovider.postApi('/post/like-comment', {
                              'commentId': detailpageController
                                  .commentData!.data!.comments!.rows![0].id
                                  .toString()
                            });
                                setState(() {});
                          },
                          child: SizedBox(
                              height: 20,
                              width: 20,
                              child: detailpageController.commentData!.data!.comments!.rows![0].commentLikes != 0 
                                  ? Image(
                                      image: AssetImage(
                                          'assets/icons/icon_heart.png'),
                                    )
                                  : Image(
                                      image: AssetImage(
                                          'assets/icons/icon_interest.png'),
                                    )),
                        ),
                      Text(
                        detailpageController
                            .commentData!.data!.comments!.rows![0].commentLikes
                            .toString(),
                        style: TextStyle(
                          color: detailpageController.isDark.value
                              ? colorconst.whiteColor
                              : colorconst.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.reply_sharp,
                        color: detailpageController.isDark.value
                            ? colorconst.whiteColor
                            : colorconst.blackColor,
                      ),
                      Text(
                        "Replies",
                        style: TextStyle(
                          color: detailpageController.isDark.value
                              ? colorconst.whiteColor
                              : colorconst.blackColor,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget CommentReply(int index, int ind) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundImage: detailpageController.commentData!.data!.comments!.rows![index].replies![ind].user!.image != null?
                  NetworkImage('https://tv-talk.hackerkernel.com/${detailpageController.commentData!.data!.comments!.rows![index].replies![ind].user!.image}'):
                  NetworkImage("https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg")
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              detailpageController.commentData!.data!.comments!.rows![index]
                  .replies![ind].user!.name
                  .toString(),
              style: TextStyle(
                  color: detailpageController.isDark.value
                      ? colorconst.whiteColor
                      : colorconst.blackColor),
            )
          ],
        ),
       const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              // horizontal: 20,
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  detailpageController.commentData!.data!.comments!.rows![index]
                      .replies![ind].content
                      .toString(),
                  style: detailpageController.fontfamily("")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Icon(
                      //   Icons.heart_broken,
                      //   color: detailpageController.isDark.value
                      //       ? colorconst.whiteColor
                      //       : colorconst.blackColor,
                      // ),
                      Text(
                        "",
                        style: TextStyle(
                            color: detailpageController.isDark.value
                                ? colorconst.whiteColor
                                : colorconst.blackColor),
                      ),
                    ],
                  ),
                  Text(
                    // timeago.format(DateTime.parse('2022-09-09 09:26:12')),
                    timeago.format(DateTime.parse(detailpageController.commentData!.data!.comments!.rows![ind].createdAt!)),
                    style:  TextStyle(color: colorconst.greyColor),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 0,
        )
      ],
    );
  }

  Widget ExpendedComment(int index, int ReplyNum) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage("https://tv-talk.hackerkernel.com/${detailpageController.commentData!.data!.comments!.rows![index].user!.image}"),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  detailpageController
                      .commentData!.data!.comments!.rows![index].user!.name
                      .toString(),
                  style: TextStyle(
                      color: detailpageController.isDark.value
                          ? colorconst.whiteColor
                          : colorconst.blackColor),
                )
              ],                                        
            ),
            Text(
              timeago.format(DateTime.parse(detailpageController.commentData!.data!.comments!.rows![index].createdAt!)),
              style:  TextStyle(color: colorconst.greyColor),
            )
          ],
        ),
        Padding(
          padding:const EdgeInsets.only(
            left: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  detailpageController
                      .commentData!.data!.comments!.rows![index].content
                      .toString(),
                  style: detailpageController.fontfamily("")),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          apiprovider.postApi('/post/like-comment', {
                            'commentId': detailpageController
                                .commentData!.data!.comments!.rows![index].id
                                .toString()
                          });
                          setState(() {
                            
                          });
                        },
                        child: SizedBox(
                            height: 20,
                            width: 20,
                            child: Image(
                                image: detailpageController.commentData!.data!.comments!.rows![index].commentLikes != 0 
                                ? const AssetImage(
                                    'assets/icons/icon_heart.png', ):const AssetImage(
                                    'assets/icons/icon_interest.png',), 
                                    color: detailpageController.isDark.value == true ? colorconst.whiteColor: colorconst.blackColor,)),
                      ),
                      Text(
                        detailpageController.commentData!.data!.comments!
                            .rows![index].commentLikes
                            .toString(),
                        style: TextStyle(
                            color: detailpageController.isDark.value
                                ? colorconst.whiteColor
                                : colorconst.blackColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.reply_sharp,
                        color: detailpageController.isDark.value
                            ? colorconst.whiteColor
                            : colorconst.blackColor,
                      ),
                      Text(
                        "Replies",
                        style: TextStyle(
                            color: detailpageController.isDark.value
                                ? colorconst.whiteColor
                                : colorconst.blackColor),
                      ),
                    ],
                  )
                ],
              ),
            const  SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 90 / 100,
                height: textSize.getadaptiveTextSize(context, 45),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: TextFieldColor),
                child: TextFormField(
                    controller: replayController![index],
                    // controller: widget.controller,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: ()async {
                          await  apiprovider.postApi('/post/create-reply', {
                              'commentId': detailpageController
                                  .commentData!.data!.comments!.rows![index].id
                                  .toString(),
                              'content': replayController![index].text
                            });
                            if(apiprovider.RegisterResponse['message'] == 'Reply created successfully.'){
                              final snackBar = SnackBar(
                                                    backgroundColor: colorconst.greenColor,
                                                    content: const Text(
                                                        "Replay add sucessfully"),
                                                    action: SnackBarAction(
                                                      label: '',
                                                      onPressed: () {
                                                        // Some code to undo the change.
                                                      },
                                                    ),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                      // replayController![index].clear();
                                                      setState(() {
                                                        
                                                      }); 
                            }else if(apiprovider.RegisterResponse['message'] == 'Already replied.'){
                              final snackBar = SnackBar(
                                                    backgroundColor: colorconst.redColor,
                                                    content: const Text(
                                                        "cannot add more then one replay"),
                                                    action: SnackBarAction(
                                                      label: '',
                                                      onPressed: () {
                                                        // Some code to undo the change.
                                                      },
                                                    ),
                                                  );
                            ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                      setState(() {
                                                        
                                                      });
                          replayController![index].clear();
                            }
                            apiprovider.getComment(widget.postData.id);
                          },
                          child:const SizedBox(
                              height: 15,
                              width: 15,
                              child: Image(
                                  image:
                                      AssetImage("assets/icons/replay.png")))),
                      fillColor: const Color(0xffFEDC5D),
                      border: InputBorder.none,
                      label: const Text(
                        "Replay.",
                      ),
                    )),
              ),
              ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: detailpageController.commentData!.data!.comments!.rows![index].replies!.length,
                shrinkWrap: true,
                itemBuilder: (context, ind) {
                  return CommentReply(index, ind);
                },
              )
            ],
          ),
        ),
             Divider()
      ],
    );
  }

  Widget buildIndicatorTrending({ind}) {
    return AnimatedSmoothIndicator(
      activeIndex: ind,
      count: homepage1controller.allpostdata.length,
      effect:  JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: colorconst.blackColor),
    );
  }

  Widget buildIndicatorSimple() {
    return AnimatedSmoothIndicator(
      activeIndex: detailpageController.DetailScroll.value,
      count: homepage1controller.allpostdata.length,
      effect:  JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: colorconst.blackColor),
    );
  }

  Widget buildIndicator(ind){
    return AnimatedSmoothIndicator(
      activeIndex: ind,
      count: homepage1controller.copydata.length,
      effect: JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: colorconst.blackColor
          ),
    );
  }

  Widget buildSimilarImage(BuildContext context, String image, int index,) {
    return InkWell(
      onTap: ()async {
        await apiprovider.getComment(homepage1controller.allpostdata[index].id);
          context.pushNamed('ARTICLEDETAILPAGE',
              extra: homepage1controller.allpostdata[index],
              queryParams: {"index": "${index}"});
      },
      child: Stack(
        children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          height: 300,
          // width: 200,
          decoration: BoxDecoration(
              image:DecorationImage(
                    image:
                     image != null?
     NetworkImage(image):
      NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                    fit: BoxFit.cover,),),
        ),
        Positioned(
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
                      IconButton(
                        onPressed: () {},
                        icon: SizedBox(
                          height: 25,
                          child: Image(
                                      image:const AssetImage(
                                        "assets/icons/heart.png",
                                      ) ,
                                      color: detailpageController.isDark.value
                                          ? colorconst.whiteColor
                                          : colorconst.blackColor,
                                    ),
                        )
                      ),
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
              children:  [
                // Text(
                //   "Viking",
                //   style: TextStyle(color: Color(0xff0FC59A)),
                //   // maxLines: ,
                //   overflow: TextOverflow.ellipsis,
                // ),
                 Html(
                      data: "<P>${homepage1controller.copydata[index].title.rendered}</p>",
                      style: {
                        'p': Style(
                          color:homepage1controller.copydata[index].featuredImageSrc != null ? colorconst.whiteColor: colorconst.blackColor
                        )
                      },
                      
                    ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget Advertisment(int height) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * height / 100,
        width: MediaQuery.of(context).size.width * 90 / 100,
        color: detailpageController.isDark.value ? colorconst.whiteColor : colorconst.blackColor,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "This is a very catchy title as it is an advertise.",
            style: TextStyle(
              color: detailpageController.isDark.value
                  ? colorconst.blackColor
                  : colorconst.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
