import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart ';
import 'dart:io';

class AdMobService {
   String get bannerAdUnitID {
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/6300978111';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/6300978111';
    }else{
      throw UnsupportedError('Unsupported Platform');
    }
  } 
   String get interstitialADUnitId {
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/1033173712';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/1033173712';
    }else{
      throw UnsupportedError('Unsupported Platform');
    }
  }
  // static InterstitialAd _interstitialAd;
  static initilized(){
    if(MobileAds.instance == null){
      MobileAds.instance.initialize();
    }
  }

   BannerAd creatBannerAd(){
    BannerAd ad =  BannerAd(
      adUnitId: bannerAdUnitID,
      size: AdSize.largeBanner,
      request:const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad){
          // isBannerAdLoaded = true;
           print("Ad loaded");
        },
        onAdFailedToLoad:(Ad ad, LoadAddError){
          ad.dispose();
        },
        onAdOpened:(ad) => print("Ad Open") ,
        onAdClosed: (ad) => print("Ad closed"),
        )
    );

    return ad;
  }
}