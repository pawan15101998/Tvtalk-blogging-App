import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/model/post_model.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/view/dialog/theme_dialog.dart';
import 'package:tvtalk/widgets/text_field.dart';
import 'package:html/parser.dart' as htmlparser;
import 'package:html/dom.dart' as dom;

class ArticleDetailPage extends StatefulWidget {
  dynamic postData;
  ArticleDetailPage({Key? key, this.postData}) : super(key: key);

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

// Widget html = Html(
//   data: widget.postData.content.rendered,
//   onLinkTap: (String? url, RenderContext context, Map<String, String> attributes, dom.Element? element) {
//     //open URL in webview, or launch URL in browser, or any other logic here
//   }
// );
  final themedialog = ThemeDialog();
  bool commentShow = false;
  final commentController = TextEditingController();
  var detailpageController = Get.find<DetailPageController>();

  @override
  Widget build(BuildContext context) {
    print('homessss');
    // print(html);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
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
                decoration: BoxDecoration(color: detailpageController.isDark.value ? Colors.black : Color(0xffFFDC5C)),
                child: FlexibleSpaceBar(
                  title: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child:  Text(
                        "The Boys",
                        style: TextStyle(color:detailpageController.isDark.value ? Colors.white : Colors.black),
                      )),
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    // color: Colors.white,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/myint1.png"),
                            fit: BoxFit.fill,)),
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
                    child: SizedBox(
                        height: 25,
                        width: 25,
                        child: Obx(() {
                          return Image(
                            image: AssetImage(
                              "assets/icons/heart.png",
                            ),
                            color: detailpageController.isDark.value
                                ? Colors.white
                                : Colors.black,
                          );
                        }))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: ()async{
                        await Share.share("hello");
                      },
                      child: SizedBox(
                          height: 25,
                          width: 25,
                          child: Obx(() {
                            return Image(
                              image:const AssetImage(
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
                child: Center(
                  child: Text(
                    'Image caption brick quiz whangs.',
                    style: TextStyle(
                        fontSize: 10,
                        color: detailpageController.isDark.value
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
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
                                widget.postData.title.rendered,
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
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(9)),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: Text(
                                      "The Boys",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Today • 10 mins ago",
                                    style: TextStyle(color: Color(0xff949494)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "95 Comments",
                                        style: TextStyle(
                                          color:
                                              detailpageController.isDark.value
                                                  ? Colors.white
                                                  : Colors.black,
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
                                      Text(
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
                                  data: widget.postData.content.rendered,
                                  style: {
                                    'p': Style(
                                        fontSize: FontSize(detailpageController
                                                    .fontSize ==
                                                12
                                            ? 12
                                            : detailpageController.fontSize ==
                                                    14
                                                ? 14
                                                : detailpageController
                                                            .fontSize ==
                                                        16
                                                    ? 16
                                                    : detailpageController
                                                                .fontSize ==
                                                            18
                                                        ? 18
                                                        : detailpageController
                                                                    .fontSize ==
                                                                20
                                                            ? 20
                                                            : null),
                                        fontFamily: detailpageController
                                                    .fontFamily.value ==
                                                1
                                            ? "QUICKSAND"
                                            : detailpageController
                                                        .fontFamily.value ==
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
                                                : detailpageController
                                                            .fontSize ==
                                                        16
                                                    ? 16
                                                    : detailpageController
                                                                .fontSize ==
                                                            18
                                                        ? 18
                                                        : detailpageController
                                                                    .fontSize ==
                                                                20
                                                            ? 20
                                                            : null),
                                        fontFamily: detailpageController
                                                    .fontFamily.value ==
                                                1
                                            ? "QUICKSAND"
                                            : detailpageController
                                                        .fontFamily.value ==
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
                                    'li': Style(
                                        fontSize: FontSize(detailpageController
                                                    .fontSize ==
                                                12
                                            ? 12
                                            : detailpageController.fontSize ==
                                                    14
                                                ? 14
                                                : detailpageController
                                                            .fontSize ==
                                                        16
                                                    ? 16
                                                    : detailpageController
                                                                .fontSize ==
                                                            18
                                                        ? 18
                                                        : detailpageController
                                                                    .fontSize ==
                                                                20
                                                            ? 20
                                                            : null),
                                        fontFamily: detailpageController
                                                    .fontFamily.value ==
                                                1
                                            ? "QUICKSAND"
                                            : detailpageController
                                                        .fontFamily.value ==
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
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Comments(95)",
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
                                            : Text(
                                                "Show Comments",
                                                style: TextStyle(
                                                  color: detailpageController
                                                          .isDark.value
                                                      ? Colors.grey
                                                      : Colors.black,
                                                ),
                                              );
                                      }),
                                      InkWell(
                                          onTap: () {
                                            detailpageController.CommentShow
                                                .toggle();
                                          },
                                          child: SizedBox(
                                              height: 18,
                                              width: 18,
                                              child: Image(
                                                image: AssetImage(
                                                    "assets/icons/expend_icon.webp"),
                                                color: detailpageController
                                                        .isDark.value
                                                    ? Colors.grey
                                                    : Colors.black,
                                              )))
                                    ],
                                  )
                                ],
                              ),
                              Obx(() {
                                return detailpageController.CommentShow.value
                                    ? Column(
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          HomePageTextField(
                                              controller: commentController,
                                              textName: "Your comment here..",
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ExpendedComment(0),
                                          ExpendedComment(2),
                                          ExpendedComment(1),
                                        ],
                                      )
                                    : SmallContainer();
                              })
                            ],
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
      ),
    );
  }

  Widget SmallContainer() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
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
                  "Jessica simth",
                  style: TextStyle(
                    color: detailpageController.isDark.value
                        ? Colors.white
                        : Colors.black,
                  ),
                )
              ],
            ),
            Text(
              "27 Jul 2022 • 10:00 pm",
              style: TextStyle(color: Color(0xff949494)),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            children: [
              Text(
                  "Quick zephyrs blow, vexing daft Jim. Charged fop blew my junk TV quiz. How quickly daft jumping zebras vex.",
                  style: detailpageController.fontfamily("")),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.heart_broken,
                        color: detailpageController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                      Text(
                        "2.5k",
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

  Widget CommentReply() {
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
              "Jessica simth",
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
            children: [
              Text("TV quiz. How quickly daft jumping zebras vex.",
                  style: detailpageController.fontfamily("")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.heart_broken,
                        color: detailpageController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                      Text(
                        "2.5k",
                        style: TextStyle(
                            color: detailpageController.isDark.value
                                ? Colors.white
                                : Colors.black),
                      ),
                    ],
                  ),
                  const Text(
                    "27 Jul 2022 • 10:00 pm",
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

  Widget ExpendedComment(int ReplyNum) {
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
                  "Jessica simth",
                  style: TextStyle(
                      color: detailpageController.isDark.value
                          ? Colors.white
                          : Colors.black),
                )
              ],
            ),
            Text(
              "27 Jul 2022 • 10:00 pm",
              style: TextStyle(color: Color(0xff949494)),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 40,
          ),
          child: Column(
            children: [
              Text(
                  "Quick zephyrs blow, vexing daft Jim. Charged fop blew my junk TV quiz. How quickly daft jumping zebras vex.",
                  style: detailpageController.fontfamily("")),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.heart_broken,
                        color: detailpageController.isDark.value
                            ? Colors.white
                            : Colors.black,
                      ),
                      Text(
                        "2.5k",
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
              HomePageTextField(
                  controller: commentController,
                  textName: "Reply..",
                  width: MediaQuery.of(context).size.width),
              ListView.builder(
                itemCount: ReplyNum,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CommentReply();
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
