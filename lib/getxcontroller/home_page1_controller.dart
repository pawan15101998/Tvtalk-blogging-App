import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tvtalk/model/like_model.dart';
import 'package:tvtalk/model/select_your_intrest_model.dart';

class HomePage1Controller extends GetxController{
 RxInt carouselSliderIndex = 0.obs;
 RxInt carouselSliderLatestIndex = 0.obs;
 RxString userTags= ''.obs;

 RxList<Like> like = <Like>[  
 Like(image: 'assets/images/slider1.png',isLike: false.obs),  
 Like(image: 'assets/images/slider2.png',isLike: false.obs),  
 Like(image: 'assets/images/slider3.png',isLike: false.obs),  
 Like(image: 'assets/images/slider4.png',isLike: false.obs),  
].obs;
RxList allpostdata = [].obs;
RxList copydata = [].obs;
}