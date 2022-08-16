import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/model/all_tags_model.dart';
import 'package:tvtalk/model/select_your_intrest_model.dart';
import 'package:tvtalk/routers.dart';
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

 List choice2 = [];
 List selectedtags = [];
 String? sendSelectedtags;

getcallapi()async{
    await  apiProvider.get();
    print("alltagsmodelss");
    print("print data");
    // print(yourIntrestController.allTagsModel!.data![0].id);
    print(allTags);
    print(yourIntrestController.allTagsModel);
    setState(() { });
}
@override
  void initState() {
    // TODO: implement initState
  super.initState();
   getcallapi();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: InkWell(
            onTap: (){apiProvider.get();},
            child: const Text(
              "Select Your Intrest",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
      body: 
          Column(
            children: [
              const TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color(0xfffF2F1F1),
                  hintText: "Search interest",
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 10,),
              if(yourIntrestController.allTagsModel !=null)
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                      itemCount:6,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 5,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                            return 
                                 InkWell(
                                  onTap: (){
                                  // choice2.add(choices[index]);  
                                  // print(choice2[index].title);
                                  // print(choice2);
                                    // choices[index].select = !choices[index].select;
                                      yourIntrestController.choices[index].select.toggle();
                                      // choices[index].select = yourIntrestController.yourIntrest.value;
                                    if(yourIntrestController.choices[index].select == true){
                                      // print(yourIntrestController.allTagsModel!.data![0].id);
                                      // selectedtags.add(yourIntrestController.allTagsModel!.data![index].id);
                                      // selectedtags.assign('tags', yourIntrestController.allTagsModel![index].id);
                                      selectedtags.add(yourIntrestController.allTagsModel![index].id);
                                      
                                      print("object");
                                     sendSelectedtags = selectedtags.toString().replaceAll("[", "").replaceAll("]", "");
                                    }else{
                                      selectedtags.remove(yourIntrestController.allTagsModel![index].id);
                                      // selectedtags.remove(yourIntrestController.allTagsModel!.data![index].id);
                                    }
                                      print(selectedtags);
                                    print(yourIntrestController.choices[index].select);
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: 
                                         Obx(
                                           () {
                                             return Container(
                                                  height: MediaQuery.of(context).size.height * 19 / 100,
                                                      // width:MediaQuery.of(context).size.height * 16 / 100, 
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                      image:  DecorationImage(
                                                          image:
                                                              AssetImage(yourIntrestController.choices[index].title.toString()), opacity: 0.8,
                                                         fit: BoxFit.cover),color: yourIntrestController.choices[index].select.value ? Color(0xfff0FC59A): Colors.black),
                                                );
                                           }
                                         )
                                         
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              yourIntrestController.allTagsModel![index].name.toString(),
                                              // "sds",
                                              style: const TextStyle(fontSize: 16),
                                            ),
                                               Obx(
                                                  () {
                                                   return Icon(Icons.check_circle_rounded, color: yourIntrestController.choices[index].select.value ? Colors.green : Colors.grey,);
                                                 }
                                               )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ); 
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
      floatingActionButton: InkWell(
        onTap: ()async{
          if(selectedtags.isNotEmpty){
          // await  apiProvider.postApi("/user/assignTags", {
          //   "tagId": sendSelectedtags,
          //   'tagname': 
          //   });
            // print("object");
            // context.pushNamed('HOMEPAGE');
            print(selectedtags);
          }else{
            print(selectedtags);
          }
        },





        child: Container(
        width: MediaQuery.of(context).size.width -20,
        height: MediaQuery.of(context).size.height*6/100,
        decoration: BoxDecoration(
        color: Colors.black,
          borderRadius: BorderRadius.circular(10)
        ),
        child:const Center(
          child: Text("Continue",
          style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        letterSpacing: 3
          ),
          ),
        )
      ),
      ),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
