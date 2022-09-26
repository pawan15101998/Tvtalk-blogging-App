import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/text_style.dart';

class SavedBlogCard extends StatefulWidget {
  const SavedBlogCard(
      {Key? key,
      required this.indexx,
      required this.context,
      required this.blogDetail})
      : super(key: key);

  final BuildContext context;
  final blogDetail;
  final indexx;
  @override
  State<SavedBlogCard> createState() => _SavedBlogCardState();
}

final apiprovider = ApiProvider();
final signincontroller = Get.find<SignInController>();
var isRead;

class _SavedBlogCardState extends State<SavedBlogCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print("over details");
        print(widget.indexx);
        print(widget.blogDetail);
        await apiprovider.getComment(widget.indexx);
        if (signincontroller.isGuest.value == 'guest') {
          context.pushNamed('ARTICLEDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {
                "from": "SavedArticle",
                "index": "${widget.indexx}"});
          // Router.neglect(context, () {
          //   context.goNamed('SIGNINPAGE');
          // });
        } else {
          context.pushNamed('ARTICLEDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {
                "from": "SavedArticle",
                "index": "${widget.indexx}"});
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
        String? userid = sharedPreferences.getString('userId');
       List savedArticleId = await apiprovider.getSavedArticle(userid);
       print(savedArticleId);
       detailpageController.articleId = [];
        for(int i=0; i<savedArticleId.length; i++){
       print("sdas,as");
       print(savedArticleId[i]['articleId']);
       print(detailpageController.articleId);
          detailpageController.articleId.add(savedArticleId[i]['articleId']);
        }
      detailpageController.articleId.forEach((element){
      print(widget.blogDetail.id);
      print(element);
      print("jkhdaskvhfd");
      print(element.toString().contains(widget.blogDetail.id.toString()));
      if(element.toString().contains(widget.blogDetail.id.toString())){
        detailpageController.isArticleSaved.value = true;
      }else{
        detailpageController.isArticleSaved.value = false;
      }
    });
      print("is article saved or not");
    print(detailpageController.isArticleSaved.value);
        print("All saved articleid");
        print(detailpageController.articleId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 16 / 100,
                    width: MediaQuery.of(context).size.height * 16 / 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image:
                      widget.blogDetail.featuredImageSrc != null?
                      NetworkImage(widget.blogDetail.featuredImageSrc, scale: 0.5):
                     NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                      widget.blogDetail.read == true ?  Colors.grey : Colors.transparent, BlendMode.saturation)
                      ),),
                  ),widget.blogDetail.read == true ?
                  Positioned(
                    bottom: 0,
                    left: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const [
                        Icon(Icons.check, color: Colors.white,),
                        Text("Read", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ):const SizedBox()
                ],
              ),
            ),
            SizedBox(
              // padding: const EdgeInsets.all(16.0),
              //  width: c_width,
              // height: MediaQuery.of(context).size.height * 18 / 100,
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
                    data:  "<h4>${widget.blogDetail.title.rendered}</h4>",
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
                        onTap: () async {
                          print(widget.blogDetail.link);
                          await Share.share(widget.blogDetail.link);
                        },
                        child: Row(
                          children:const [
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
