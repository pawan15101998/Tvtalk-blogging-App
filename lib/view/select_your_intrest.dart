import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/model/all_tags_model.dart';
import 'package:tvtalk/model/select_your_intrest_model.dart';
import 'package:tvtalk/services/service.dart';

class SelectYourIntrest extends StatefulWidget {
  const SelectYourIntrest({Key? key}) : super(key: key);

  @override
  State<SelectYourIntrest> createState() => _SelectYourIntrestState();
}

class _SelectYourIntrestState extends State<SelectYourIntrest> {
  var fontSize = AdaptiveTextSize();
  bool selectedIntrest = false;
  var allTags = AllTagsModel();
  var yourIntrestController = Get.find<YourIntrestController>();
  var kn = Get.put(Choice(select: false.obs));
  var apiProvider = ApiProvider();
  bool isFabVisible = false;
  TextEditingController searchtagscontroller = TextEditingController();
    List tagdata = [];
  final homepage1controller = Get.find<HomePage1Controller>();
  String sendingTags = "";
  final colorconst = ColorConst();

  List choice2 = [];
  List selectedtags = [];
  List selectedTagsName = [];
  String? sendSelectedtags;
  String? sendSelectedName;
  List? copydata;

  getcallapi() async {
    await apiProvider.get();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getcallapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
        child: AppBar(
          centerTitle: true,
          iconTheme:  IconThemeData(color: colorconst.blackColor),
          toolbarHeight: 120.0,
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: colorconst.mainColor,
          title:  Text(
            "Select Your Interest",
            style: TextStyle(color: colorconst.blackColor, fontSize: 20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Column(
          children: [
            TextField(
              controller: searchtagscontroller,
              decoration: InputDecoration(
                suffixIcon: Obx(() {
                  return InkWell(
                      onTap: () {
                        // yourIntrestController.activeTextfield.toggle();
                        FocusScope.of(context).unfocus();
                      },
                      child: yourIntrestController.activeTextfield.value
                          ? InkWell(
                              onTap: () async {
                                yourIntrestController.activeTextfield.value =
                                    false;
                                FocusScope.of(context).unfocus();
                                searchtagscontroller.clear();
                                yourIntrestController.allTagsModel.value = [];
                                await getcallapi();
                              },
                              child:const Icon(Icons.cancel))
                          : const Icon(Icons.search));
                }),
                filled: true,
                fillColor:const Color(0xfffF2F1F1),
                hintText: "Search interest",
                border: InputBorder.none,
              ),
              onTap: () {
                // yourIntrestController.activeTextfield.toggle();
                if (yourIntrestController.activeTextfield.value == false) {
                  yourIntrestController.activeTextfield.value = true;
                }
              },
              onChanged: (value) async {
                copydata = yourIntrestController.allTagsModel;
                yourIntrestController.allTagsModel.value = copydata!
                    .where((i) => i.name
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
                if (searchtagscontroller.text == "") {
                  yourIntrestController.allTagsModel.value = [];
                  await getcallapi();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            if (yourIntrestController.allTagsModel != null)
              Expanded(
                child: Obx(() {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        itemCount: yourIntrestController.allTagsModel.length,
                        // itemCount: yourIntrestController.allTagsModel.length,
                        shrinkWrap: true,
                        gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 5,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              yourIntrestController.choices[index].select.toggle();
                              if (yourIntrestController.choices[index].select ==true) {
                                selectedtags.add(yourIntrestController.allTagsModel[index].id);
                                selectedTagsName.add(yourIntrestController.allTagsModel[index].name);
                                sendSelectedName = selectedTagsName.toString().replaceAll("[", "").replaceAll("]", "");
                                sendSelectedtags = selectedtags.toString().replaceAll("[", "").replaceAll("]", "");
                              } else {
                                selectedtags.remove(yourIntrestController
                                    .allTagsModel[index].id);
                                selectedTagsName.remove(yourIntrestController
                                    .allTagsModel[index].name);
                                sendSelectedName = selectedTagsName
                                    .toString()
                                    .replaceAll("[", "")
                                    .replaceAll("]", "");
                                sendSelectedtags = selectedtags
                                    .toString()
                                    .replaceAll("[", "")
                                    .replaceAll("]", "");
                                // selectedtags.remove(yourIntrestController.allTagsModel!.data![index].id);
                              }
                              
                            },
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Obx(() {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                19 /
                                                100,
                                        // height: 160,
                                        // width:MediaQuery.of(context).size.height * 16 / 100,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    yourIntrestController
                                                        .choices[index].title
                                                        .toString()),
                                                opacity: 0.8,
                                                fit: BoxFit.cover),
                                            color: yourIntrestController
                                                    .choices[index].select.value
                                                ? Color(0xfff0FC59A)
                                                : colorconst.blackColor),
                                      );
                                    })),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        yourIntrestController
                                            .allTagsModel[index].name
                                            .toString(),
                                        // "sds",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Obx(() {
                                        return Icon(
                                          Icons.check_circle_rounded,
                                          color: yourIntrestController
                                                  .choices[index].select.value
                                              ? colorconst.greenColor
                                              : Colors.grey,
                                        );
                                      })
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              )
          ],
        ),
      ),
      floatingActionButton: 
           InkWell(
              onTap: () async {
                if (selectedtags.isNotEmpty) {
                  await apiProvider.postApi("/user/assignTags",
                      {"tagId": sendSelectedtags, 'tagname': sendSelectedName});
                 
                        var tagsss=  await apiProvider.getTags();

    for(var i= 0; i<tagsss['data'].length; i++){
     tagdata.add(tagsss['data'][i]['tagId']);
    }

sendingTags = tagdata.toString().replaceAll("[", "").replaceAll("]", "");
homepage1controller.userTags.value = sendingTags;
      await apiProvider.getPost(sendingTags);
      await apiProvider.getprofile();
      for(int i = 0; i<yourIntrestController.choices.length; i++){
        yourIntrestController.choices[i].select.value = false;
      }

                } else {
                }

                  var tagsss =  await apiProvider.getTags();
              for(var i= 0; i<tagsss['data'].length; i++){
                      homepage1controller.userTagName.add(tagsss['data'][i]['tagname']);
                     }
              for(int i=0; i<yourIntrestController.allTagsModel.length; i++){
              if(homepage1controller.userTagName.toString().toLowerCase().contains(yourIntrestController.alltagsName[i].toString().toLowerCase()) ){
              yourIntrestController.allTagsModel[i].activetag = true;
               }else{
              yourIntrestController.allTagsModel[i].activetag = false;
               }
                 }
                  context.pushNamed('HOMEPAGE');
              },
              child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  decoration: BoxDecoration(
                      color: colorconst.blackColor,
                      borderRadius: BorderRadius.circular(10)),
                  child:  Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: colorconst.whiteColor, fontSize: 16, letterSpacing: 3),
                    ),
                  )),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
