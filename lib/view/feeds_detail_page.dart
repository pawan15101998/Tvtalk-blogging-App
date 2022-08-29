import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/theme.dart';
import 'package:tvtalk/view/dialog/theme_dialog.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

import '../model/get_comment_model.dart';

class ArticleDetailPage extends StatefulWidget {
  dynamic postData;
  Map feedindex;
  ArticleDetailPage({Key? key, this.postData, required this.feedindex}) : super(key: key);

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


  Stream streamController()=> Stream.fromFuture(
        apiprovider.getComment(widget.postData.id)
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
  final textSize = AdaptiveTextSize();
  final getcomment = GetComment();
  PageController? pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  scrollController = ScrollController()..addListener(_reachend);
    print("inxxxxxxx");
    print(widget.feedindex['index']);
    apiprovider.getComment(widget.postData.id);
    int indexint = int.parse(widget.feedindex['index']);
    pageController = PageController(initialPage: indexint);
    getcommen()async{
    await apiprovider.getComment(widget.postData.id);
  }
  }
  final homepage1controller = Get.find<HomePage1Controller>();


  @override
  Widget build(BuildContext context) {
    print('homessss');
    // getcommen();
    // print(detailpageController.commentData!.data);
    // print(html);
    // if(detailpageController.commentData!.data != null)
    // print(detailpageController.commentData?.data);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageView.builder(
        itemCount: homepage1controller.copydata.length,
        controller: pageController,
        itemBuilder: (BuildContext context, int pageindex) {
          return CustomScrollView(
            slivers: <Widget>[
              Obx(() {
                return SliverAppBar(
                  iconTheme: IconThemeData(
                    color: detailpageController.isDark.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  toolbarHeight: 100,
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: 250.0,
                  flexibleSpace: DecoratedBox(
                    decoration: BoxDecoration(
                        color: detailpageController.isDark.value
                            ? Colors.black
                            : Color(0xffFFDC5C)),
                    child: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/myint1.png"),
                          fit: BoxFit.fill,
                        )),
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                            onTap: () {
                              themedialog.showThemeDialog(context, "knkn");
                            },
                            child: SizedBox(
                                height: 25,
                                width: 25,
                                child: Obx(() {
                                  return Image(
                                    image: AssetImage(
                                      "assets/icons/font_family.png",
                                    ),
                                    color: detailpageController.isDark.value
                                        ? Colors.white
                                        : Colors.black,
                                  );
                                })))),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            print(detailpageController
                                .commentData!.data!.comments!.rows![0].user!.name);
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
                                      ? Colors.white
                                      : Colors.black,
                                );
                              })),
                        )),
                    Padding(
                        padding:const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () async {
                            print(widget.postData.link);
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
                                      ? Colors.white
                                      : Colors.black,
                                );
                              })),
                        )),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                );
              }),
              SliverToBoxAdapter(
                child: Obx(() {
                  return Container(
                    color: detailpageController.isDark.value
                        ? Colors.black
                        : Colors.white, //Dark theme
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
                            ? Colors.black
                            : Colors.white, //dark Theme
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Center(child: buildIndicator( pageindex)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    homepage1controller.copydata[pageindex].title.rendered,
                                    // widget.postData.title.rendered,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Poppins',
                                      color: detailpageController.isDark.value
                                          ? Colors.white
                                          : Colors.black,
                                    ),
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
                                    Text(
                                          homepage1controller.copydata[pageindex].date.toString(),
                                        style: TextStyle(color: Color(0xff949494),
                                        fontSize: 12
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              print(scrollController.hasClients);
                                              // print(scrollController.position);
                                              if(scrollController.hasClients){
                                                scrollController.animateTo(500,
                                             duration: const Duration(milliseconds: 500),
                                             curve: Curves.easeInOut);
                                              }
                                             
                                            },
                                            child: Text(
                                              "${detailpageController.commentData?.data?.comments?.rows?.length} Comments",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color:
                                                    detailpageController.isDark.value
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.comment,
                                            color: detailpageController.isDark.value
                                                ? Colors.white
                                                : Colors.black,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                         const Text(
                                            "Saved",
                                            style:
                                                TextStyle(color: Color(0xff949494)),
                                          ),
                                          Icon(
                                            Icons.save,
                                            color: detailpageController.isDark.value
                                                ? Colors.white
                                                : Colors.black,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: detailpageController.isDark.value
                                  ? Colors.white
                                  : Colors.black,
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
                                      data: homepage1controller.copydata[pageindex].content.rendered,
                                      style: {
                                        'figure':Style(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero
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
                                                ? Colors.white
                                                : Colors.black),
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
                                                ? Colors.white
                                                : Colors.black),
                                        'figcaption': Style(
                                            fontSize: const FontSize(12),
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic),
                                        'img src': Style(
                                          //  color: Colors.blue
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
                                                ? Colors.white
                                                : Colors.black)
                                      },
                                      onAnchorTap:
                                          (url, context, attributes, element) {
                                        print(attributes.values);
                                      },
                                      onLinkTap: (String? url,
                                          RenderContext context,
                                          Map<String, String> attributes,
                                          dom.Element? element) {
                                        print(url);
                                        print(attributes.entries);
                                        print(element);
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
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://picsum.photos/id/237/200/300'),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Article by",
                                          style:
                                              detailpageController.fontfamily("")),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Akash Divya",
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
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                "Similar Articles",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: detailpageController.isDark.value
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                  height: 300.0,
                                  // autoPlay: true,
                                  onPageChanged: ((index, reason) {
                                    // homePage1 = index;
                                    detailpageController.DetailScroll.value = index;
                                  })),
                              itemCount: urlImages.length,
                              itemBuilder: ((context, index, realIndex) {
                                final urlImage = urlImages[index];
                                return buildSimilarImage(urlImage, index, context);
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return Center(child: buildIndicatorTrending());
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            Divider(
                              color: detailpageController.isDark.value
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: StreamBuilder(
                                stream: streamController(),
                                builder: (context, snapshot){   
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
                                                    ? Text("Hide Comments",
                                                        style: detailpageController
                                                            .fontfamily(""))
                                                    : detailpageController
                                                                .commentData!
                                                                .data!
                                                                .comments!
                                                                .count !=
                                                            0
                                                        ? Text(
                                                            "Show Comments",
                                                            style: TextStyle(
                                                              color:
                                                                  detailpageController
                                                                          .isDark.value
                                                                      ? Colors.grey
                                                                      : Colors.black,
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
                                                                : Colors.black,
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
                                                    print("res");
                                                    apiprovider.postApi(
                                                        '/post/create-comment', {
                                                      'postId':
                                                          widget.postData.id.toString(),
                                                      'content': commentController.text
                                                    });
                                                    if (apiprovider.statuscode == 200) {
                                                      if(commentController.text != ""){
                                                        final snackBar = SnackBar(
                                                        backgroundColor: Colors.green,
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
                                                        backgroundColor: Colors.red,
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
                            Advertisment(12),
                            const SizedBox(
                              height: 10,
                            ),
                            Advertisment(12),
                            const SizedBox(
                              height: 10,
                            ),
                            Advertisment(12),
                            const SizedBox(
                              height: 10,
                            ),
                            Advertisment(12),
                            const SizedBox(
                              height: 10,
                            ),
                            Advertisment(12),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    });
                  },
                  childCount: 1,
                ),
              ),
            ],
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
                const CircleAvatar(
                  backgroundImage:
                      NetworkImage('https://picsum.photos/id/237/200/300'),
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
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              ],
            ),
            Text(
              detailpageController
                  .commentData!.data!.comments!.rows![0].createdAt
                  .toString(),
              style: TextStyle(color: Color(0xff949494)),
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
                              ? Colors.white
                              : Colors.black,
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
                            ? Colors.white
                            : Colors.black,
                      ),
                      Text(
                        "Replies",
                        style: TextStyle(
                          color: detailpageController.isDark.value
                              ? Colors.white
                              : Colors.black,
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
              backgroundImage:
                  NetworkImage('https://picsum.photos/id/237/200/300'),
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
                      ? Colors.white
                      : Colors.black),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
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
                      //       ? Colors.white
                      //       : Colors.black,
                      // ),
                      Text(
                        "",
                        style: TextStyle(
                            color: detailpageController.isDark.value
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                  Text(
                    detailpageController.commentData!.data!.comments!
                        .rows![index].replies![ind].createdAt
                        .toString(),
                    style: TextStyle(color: Color(0xff949494)),
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
                      NetworkImage('https://picsum.photos/id/237/200/300'),
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
                          ? Colors.white
                          : Colors.black),
                )
              ],
            ),
            Text(
              detailpageController
                  .commentData!.data!.comments!.rows![index].user!.createdAt
                  .toString(),
              style: TextStyle(color: Color(0xff949494)),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
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
                                ? AssetImage(
                                    'assets/icons/icon_heart.png', ): AssetImage(
                                    'assets/icons/icon_interest.png',), 
                                    color: detailpageController.isDark.value == true ? Colors.white: Colors.black,)),
                      ),
                      Text(
                        detailpageController.commentData!.data!.comments!
                            .rows![index].commentLikes
                            .toString(),
                        style: TextStyle(
                            color: detailpageController.isDark.value
                                ? Colors.white
                                : Colors.black),
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
                            ? Colors.white
                            : Colors.black,
                      ),
                      Text(
                        "Replies",
                        style: TextStyle(
                            color: detailpageController.isDark.value
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
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
                            print("res");
                          await  apiprovider.postApi('/post/create-reply', {
                              'commentId': detailpageController
                                  .commentData!.data!.comments!.rows![index].id
                                  .toString(),
                              'content': replayController![index].text
                            });
                            if(apiprovider.RegisterResponse['message'] == 'Reply created successfully.'){
                              final snackBar = SnackBar(
                                                    backgroundColor: Colors.green,
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
                                                    backgroundColor: Colors.red,
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
                          child: SizedBox(
                              height: 15,
                              width: 15,
                              child: Image(
                                  image:
                                      AssetImage("assets/icons/replay.png")))),
                      fillColor: const Color(0xffFEDC5D),
                      border: InputBorder.none,
                      label: Text(
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

  Widget buildIndicatorTrending() {
    return AnimatedSmoothIndicator(
      activeIndex: detailpageController.DetailScroll.value,
      count: urlImages.length,
      effect: const JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: Colors.black),
    );
  }

  Widget buildIndicator(ind) {
    return AnimatedSmoothIndicator(
      activeIndex: ind,
      count: homepage1controller.copydata.length,
      effect: JumpingDotEffect(
          dotColor: Colors.grey,
          dotHeight: 6,
          dotWidth: 6,
          activeDotColor: Colors.black),
    );
  }

  Widget buildSimilarImage(String image, int index, context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 12),
        height: 300,
        // width: 200,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
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
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.heart_broken,
                        color: Colors.white,
                      ),
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
            children: const [
              Text(
                "Viking",
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

  Widget Advertisment(int height) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * height / 100,
        width: MediaQuery.of(context).size.width * 90 / 100,
        color: detailpageController.isDark.value ? Colors.white : Colors.black,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "This is a very catchy title as it is an advertise.",
            style: TextStyle(
              color: detailpageController.isDark.value
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
