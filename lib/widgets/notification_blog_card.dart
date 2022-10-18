import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/constant/images_constant.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/text_style.dart';

class NotificationBlogCard extends StatefulWidget {
  const NotificationBlogCard(
      {Key? key,
      required this.indexx,
      required this.context,
      required this.blogDetail})
      : super(key: key);

  final BuildContext context;
  final blogDetail;
  final indexx;
  @override
  State<NotificationBlogCard> createState() => _NotificationBlogCardState();
}

final apiprovider = ApiProvider();
final  imageConst = ImageConst();
final signincontroller = Get.find<SignInController>();

class _NotificationBlogCardState extends State<NotificationBlogCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {

        await apiprovider.getComment(widget.indexx);
        if(signincontroller.isGuest.value == 'guest'){
          context.pushNamed('NOTIFICATIONDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {
                "from": "SavedArticle",
                "index": "${widget.indexx}"});
          // Router.neglect(context, () {
          //   context.goNamed('SIGNINPAGE');
          // });
        } else {
          context.pushNamed('NOTIFICATIONDETAILPAGE',
              extra: widget.blogDetail,
              queryParams: {
                "from": "SavedArticle",
                "index": "${widget.indexx}"});
        }
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setInt('Readed', widget.blogDetail.id);
        var allldata = sharedPreferences.getInt('Readed');
        // isRead = await apiprovider
        //     .postApi('/post/mark-read', {'postId': "${widget.blogDetail.id}"});
        String? userid = sharedPreferences.getString('userId');
       List savedArticleId = await apiprovider.getSavedArticle(userid);
       detailpageController.articleId = [];
        for(int i=0; i<savedArticleId.length; i++){

          detailpageController.articleId.add(savedArticleId[i]['articleId']);
        }
      detailpageController.articleId.forEach((element){
   
      if(element.toString().contains(widget.blogDetail.id.toString())){
        detailpageController.isArticleSaved.value = true;
      }else{
        detailpageController.isArticleSaved.value = false;
      }
    });

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
                  // const NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                      imageConst.staticImage(),
                      fit: BoxFit.cover,
                      // colorFilter: ColorFilter.mode(
                      // widget.blogDetail.read == true ?  Colors.grey : colorconst.transparentColor, BlendMode.saturation)
                      ),),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Html(
                    data:  "<p>${widget.blogDetail.title.rendered.length>120? widget.blogDetail.title.rendered.substring(0, 120)+'.......' : widget.blogDetail.title.rendered }</p>",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
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
