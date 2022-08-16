import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    Key? key,
    required this.context,
    required this.blogDetail
  }) : super(key: key);

  final BuildContext context;
  final  blogDetail;

  @override
  Widget build(BuildContext context) {
  return InkWell(
    onTap: () async{
      context.pushNamed('ARTICLEDETAILPAGE',extra: blogDetail);
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('Readed', blogDetail.id);
   var allldata = sharedPreferences.getInt('Readed');
   print(allldata);
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height:MediaQuery.of(context).size.height*18/100,
            width:  MediaQuery.of(context).size.width*25/100,
            decoration:const  BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/trendingCard1.png", ),
              fit: BoxFit.cover, 
              // colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation)
              )
            ),
          ),
          SizedBox(
            // padding: const EdgeInsets.all(16.0),
            //  width: c_width,
            height:MediaQuery.of(context).size.height*18/100,
            width: MediaQuery.of(context).size.width-150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "The Boys",
                      style: TextStyle(
                        color: Color(0xfff00A17B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    // SizedBox(width: 100,),
                  ],
                ),
                 Expanded(
                  child: Text( 
                    blogDetail.title.rendered.toString(),
                    overflow:TextOverflow.ellipsis,
                    maxLines: 3,
                    style:const TextStyle(
                      height: 2,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),
                  ),
                ), 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Share"
                        ),
                    SizedBox(height: 22, width: 22,  child: Image(image: AssetImage("assets/icons/icon_share.png",),))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "2.5k"
                        ),
                        SizedBox(width: 5,),
                   SizedBox(height: 22, width: 22,  child: Image(image: AssetImage("assets/icons/heart.png",),))
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
