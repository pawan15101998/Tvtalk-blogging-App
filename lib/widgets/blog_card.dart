import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';

class BlogCard extends StatefulWidget {
  const BlogCard(
      {Key? key,
      required this.indexx,
      required this.context,
      required this.blogDetail})
      : super(key: key);

  final BuildContext context;
  final blogDetail;
  final indexx;
  @override
  State<BlogCard> createState() => _BlogCardState();
}

final apiprovider = ApiProvider();
final signincontroller = Get.find<SignInController>();
var isRead;

class _BlogCardState extends State<BlogCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (signincontroller.isGuest.value == 'guest') {
          context.pushNamed('ARTICLEDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {"index": "${widget.indexx}"});
          // Router.neglect(context, () {
          //   context.goNamed('SIGNINPAGE');
          // });
        } else {
          context.pushNamed('ARTICLEDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {"index": "${widget.indexx}"});
        }
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('Readed', widget.blogDetail.id);
        var allldata = sharedPreferences.getInt('Readed');
        print("apireaded");
        print(widget.blogDetail.id);
        isRead = await apiprovider
            .postApi('/post/mark-read', {'postId': "${widget.blogDetail.id}"});
        print(allldata);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Container(
                height: MediaQuery.of(context).size.height * 18 / 100,
                width: MediaQuery.of(context).size.width * 25 / 100,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/trendingCard1.png"),
                  fit: BoxFit.cover,
                  // colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation)
                )),
              ),
            ),
            SizedBox(
              // padding: const EdgeInsets.all(16.0),
              //  width: c_width,
              height: MediaQuery.of(context).size.height * 18 / 100,
              width: MediaQuery.of(context).size.width - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // Text(
                      //   "The Boys",
                      //   style: TextStyle(
                      //     color: Color(0xfff00A17B),
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500
                      //   ),
                      // ),
                      // SizedBox(width: 100,),
                    ],
                  ),
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
                    child: Text(
                      widget.blogDetail.title.rendered.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          height: 2, fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          print(widget.blogDetail.link);
                          await Share.share(widget.blogDetail.link);
                        },
                        child: Row(
                          children: [
                            Text("Share"),
                            SizedBox(
                                height: 22,
                                width: 22,
                                child: Image(
                                  image: AssetImage(
                                    "assets/icons/icon_share.png",
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text("2.5k"),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                              height: 22,
                              width: 22,
                              child: Image(
                                image: AssetImage(
                                  "assets/icons/heart.png",
                                ),
                              ))
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
    );
  }
}
