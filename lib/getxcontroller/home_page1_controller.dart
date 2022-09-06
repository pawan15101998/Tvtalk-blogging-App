import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tvtalk/model/like_model.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';

class HomePage1Controller extends GetxController {
  RxInt carouselSliderIndex = 0.obs;
  RxInt carouselSliderLatestIndex = 0.obs;
  RxString userTags = ''.obs;
  RxString nosearch = "".obs;
  RxList allpostdata = [].obs;
  RxList copydata = [].obs;
  RxMap userDetails = {}.obs;
  RxList searchArticle = [].obs;
  RxString topTags = "All".obs;

searchFunction(String? val) {
    searchArticle.clear();
    nosearch.value = val!;
    if (val.isEmpty) {
      searchArticle.clear();
      return;
    } else {
      print('not empty');
      print(homePage1Controller.userTags.value);
      allpostdata.forEach((element) {
        if (element.title.rendered.toLowerCase().contains(val)){
          searchArticle = [].obs;
          searchArticle.add(element);
          print(searchArticle);
          print('value');
          return;
        } else {
          return;
        }
      });
    }
  }
}
