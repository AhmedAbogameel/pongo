import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:pet_adoption/views/checkout/donation_dialog.dart';

class AdMob {

  final String _adId = 'ca-app-pub-7855093059049143/7806941900';
  final String appId = 'ca-app-pub-7855093059049143~5811333951';

  MobileAdTargetingInfo _targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['cats', 'dogs' , 'adoption'],
    childDirected: false,
    testDevices: <String>[],
  );
  
  Future<bool> showDonationVideo(BuildContext context)async{
    RewardedVideoAd rewardedVideoAd = RewardedVideoAd.instance;
    try{
      await rewardedVideoAd.load(adUnitId: _adId,targetingInfo: _targetingInfo);
      await rewardedVideoAd.show();
      rewardedVideoAd.listener =
          (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
        if (event == RewardedVideoAdEvent.rewarded) {
          showDonationDialog(context);
        }
      };
      return true;
    }catch(_){
      return false;
    }
  }
}