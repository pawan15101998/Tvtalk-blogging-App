import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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

  List choice2 = [];
  List selectedtags = [];
  List selectedTagsName = [];
  String? sendSelectedtags;
  String? sendSelectedName;
  List? copydata;

  getcallapi() async {
    await apiProvider.get();
    print("alltagsmodelss");
    print("print data");
    // print(yourIntrestController.allTagsModel!.data![0].id);
    print(allTags);
    print(yourIntrestController.allTagsModel);
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
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
        child: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          toolbarHeight: 120.0,
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: Color(0xfffFFDC5C),
          title: const Text(
            "Select Your Interest",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
      ),
      body: Column(
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
                            child: Icon(Icons.cancel))
                        : Icon(Icons.search));
              }),
              filled: true,
              fillColor: Color(0xfffF2F1F1),
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
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.direction == ScrollDirection.forward) {
                    if (!isFabVisible) setState(() => isFabVisible = true);
                  } else if (notification.direction ==
                      ScrollDirection.reverse) {
                    if (isFabVisible) setState(() => isFabVisible = false);
                  }
                  return true;
                },
                child: Obx(() {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: GridView.builder(
                        itemCount: yourIntrestController.allTagsModel.length < 7
                            ? yourIntrestController.allTagsModel.length
                            : 7,
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
                          print("objecttttttttt");
                          print(yourIntrestController.allTagsModel.length);
                          return InkWell(
                            onTap: () {
                              print("object");
                              yourIntrestController.choices[index].select.toggle();
                              if (yourIntrestController.choices[index].select ==true) {
                                selectedtags.add(yourIntrestController.allTagsModel[index].id);
                                selectedTagsName.add(yourIntrestController.allTagsModel[index].name);
                                print("object");
                                sendSelectedName = selectedTagsName.toString().replaceAll("[", "").replaceAll("]", "");
                                sendSelectedtags = selectedtags.toString().replaceAll("[", "").replaceAll("]", "");
                                print(sendSelectedName);
                                print(sendSelectedtags);
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
                                print(sendSelectedName);
                                print(sendSelectedtags);
                              }
                              print(selectedtags);
                              print(
                                  yourIntrestController.choices[index].select);
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
                                                : Colors.black),
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
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      Obx(() {
                                        return Icon(
                                          Icons.check_circle_rounded,
                                          color: yourIntrestController
                                                  .choices[index].select.value
                                              ? Colors.green
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
              ),
            )
        ],
      ),
      floatingActionButton: isFabVisible == false
          ? InkWell(
              onTap: () async {
                if (selectedtags.isNotEmpty) {
                  await apiProvider.postApi("/user/assignTags",
                      {"tagId": sendSelectedtags, 'tagname': sendSelectedName});
                 
                        var tagsss=  await apiProvider.getTags();
     print("sd");
     print(tagsss);
    for(var i= 0; i<tagsss['data'].length; i++){
     tagdata.add(tagsss['data'][i]['tagId']);
    }
     print("objectTagss");
    print(sendingTags);
sendingTags = tagdata.toString().replaceAll("[", "").replaceAll("]", "");
homepage1controller.userTags.value = sendingTags;
print(sendingTags);
      await apiProvider.getPost(sendingTags);
      await apiProvider.getprofile();
                  context.pushNamed('HOMEPAGE');
                  yourIntrestController.choices[0].select.value = false;
                  yourIntrestController.choices[1].select.value = false;
                  yourIntrestController.choices[2].select.value = false;
                  yourIntrestController.choices[3].select.value = false;
                  yourIntrestController.choices[4].select.value = false;
                  yourIntrestController.choices[5].select.value = false;
                  yourIntrestController.choices[6].select.value = false;
                  // sendSelectedName = "";
                  // sendSelectedtags = "";
                  print(selectedtags);
                } else {
                  print(selectedtags);
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height * 6 / 100,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "Continue",
                      style: TextStyle(
                          color: Colors.white, fontSize: 16, letterSpacing: 3),
                    ),
                  )),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
