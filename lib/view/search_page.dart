import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/widgets/blog_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
final homePageController = Get.find<HomePageController>();
TextEditingController searchcontroller = TextEditingController();
  var homePage1Controller = Get.find<HomePage1Controller>();
  var fontSize = AdaptiveTextSize();
  final signincontroller = Get.find<SignInController>();
    var scaffoldKey = GlobalKey<ScaffoldState>();
  final yourIntrestController = Get.find<YourIntrestController>();
String? sendingTags;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("modelll");
    print(yourIntrestController.alltagsDetails);
    print(yourIntrestController.alltagsName);
    print(yourIntrestController.allTagsModel);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop:()async{
        print("Back button Press");
        yourIntrestController.tagselectfromsearch.clear();
            sendingTags = '';
            // _isSelected = false;
        return true;
        },
       child: Scaffold(
          appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(fontSize.getadaptiveTextSize(context, 70)),
          child: AppBar(
            toolbarHeight: 100.0,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xfffFFDC5C),
            actions: [
              Obx(() {
                return homePageController.searchIcon.value
                    ? SizedBox()
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Center(
                            child: SizedBox(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 80 / 100,
                              child: TextFormField(
                                controller: searchcontroller,
                                onChanged: homePage1Controller.searchFunction,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  
                                  border: OutlineInputBorder(),
                                  hintText: 'Search',
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
               
              }),
              Obx((){
                return IconButton(
                    onPressed:(){
                     homePageController.searchIcon.toggle();
                      homePage1Controller.searchArticle.clear(); 
                      },
                    icon: homePageController.searchIcon.value
                        ? const Image(
                            image: AssetImage("assets/icons/icon_search.png"),
                            height: 24,
                          )
                        : InkWell(
                            onTap:()async{
                              homePage1Controller.nosearch = "".obs;
                              homePageController.searchIcon.toggle();
                              searchcontroller.clear();
                              homePage1Controller.searchArticle.clear();
                            },
                            child:const Icon(
                              Icons.cancel,
                              color: Colors.black,
                            ),
                          ));
              }),
            const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Obx(() {
                return homePage1Controller.searchArticle.isNotEmpty &&
                        homePage1Controller.nosearch != ""
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        // scrollDirection: Axis.vertical,
                        itemCount: homePage1Controller.searchArticle.length,
                        itemBuilder: (context, index){
                          return BlogCard(
                            indexx: index,
                            context: context,
                            blogDetail: homePage1Controller.searchArticle[index],
                          );
                        },
                      )
                    :  
                    (homePage1Controller.searchArticle.isNotEmpty)
                    ?
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: homePage1Controller.searchArticle.length,
                      itemBuilder: (context, ind) {
                        return InkWell(
                          onTap: ()async{
                            int? tagid;
                            yourIntrestController.allTagsModel.forEach((element) {
                              if(element.name.toLowerCase().trim() == homePage1Controller.searchArticle.toString().replaceAll("[", "").replaceAll("]", "").trim()){
                                tagid = element.id;
                              }
                             });
                             homePage1Controller.allpostdata = [].obs;
                             apiprovider.allPost = [];
                             await apiprovider.getPost(tagid);
                             context.pushNamed('TAGSEARCHPAGE', queryParams: {'tagName': homePage1Controller.searchArticle.toString().replaceAll("[", "").replaceAll("]", "")});                          print(yourIntrestController.allTagsModel);
                            // Router.neglect(context, () {context.goNamed('TAGSEARCHPAGE',queryParams: {'tagName': homePage1Controller.searchArticle.toString().replaceAll("[", "").replaceAll("]", "")} );},);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color:const Color(0xffFFDC5C),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: Center(child: Text(homePage1Controller.searchArticle[ind], style: 
                              const TextStyle(
                                fontSize: 20
                              )
                            ,))),
                          ),
                        );
                      }
                    ):
                    homePage1Controller.searchArticle.isEmpty &&
                            homePage1Controller.nosearch != ""
                        ? const Center(child: Text(" No Data Found"))
                        :            Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:const EdgeInsets.all(8.0),
                child: _titleContainer("Choose Tags"),
              ),
            ),
            Padding(padding:const EdgeInsets.only(left: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 10,
                children:[
                  for(int i= 0; i< yourIntrestController.allTagsModel.length; i++)
                  filterChipWidget(chipName: yourIntrestController.allTagsModel[i].name, chipId:yourIntrestController.allTagsModel[i].id)
                ],
              ),
            ),
            )
          ],
          );
              }),
            ],
          ),
        ),
          ),
          floatingActionButton: InkWell(
                onTap: () async {
             if(yourIntrestController.tagselectfromsearch.isNotEmpty){
              sendingTags = yourIntrestController.tagselectfromsearch.value
                              .toString()
                                      .replaceAll("[", "")
                                      .replaceAll("]", "");
                                      print(sendingTags);
            apiprovider.allPost = [];
            homePage1Controller.allpostdata = [].obs;
            homePage1Controller.copydata = [].obs;
            await  apiprovider.getPost(sendingTags);
            context.pushNamed('TAGSEARCHPAGE');
            yourIntrestController.tagselectfromsearch.clear();
            sendingTags = '';
                    }
      
                },
                child:Obx((){
                    return Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: MediaQuery.of(context).size.height * 6 / 100,
                        decoration: BoxDecoration(
                            color:yourIntrestController.tagselectfromsearch.isNotEmpty ? Colors.black: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.white, fontSize: 16, letterSpacing: 3),
                          ),
                        ));
                  }
                ),
              ),
        floatingActionButtonLocation:    
        FloatingActionButtonLocation.centerFloat,
           ),
      )
      );
  }
}



Widget _titleContainer(String Mytitle){
return Text(
  Mytitle,
  style: TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold
  ),
);
}

class filterChipWidget extends StatefulWidget {
  final String chipName;
  final int chipId;
  const filterChipWidget({Key? key,required this.chipName, required this.chipId}) : super(key: key);

  @override
  State<filterChipWidget> createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;
  List selectedtag = [];
  // int? allTags;
    final yourIntrestController = Get.find<YourIntrestController>();
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName), 
      labelStyle: TextStyle(color: Colors.black,),
      disabledColor: Color.fromARGB(255, 144, 144, 144),
      selected: _isSelected,
      onSelected: (isSelected){
        setState((){
          _isSelected = isSelected;
          if(_isSelected){
            // print(selectedtag);
            yourIntrestController.tagselectfromsearch.add(widget.chipId);
            print(yourIntrestController.tagselectfromsearch);
          }
          else{
          yourIntrestController.tagselectfromsearch.remove(widget.chipId);
          }
        });
      },
      selectedColor: Color(0xfffFFDC5C),
      );
  }
}