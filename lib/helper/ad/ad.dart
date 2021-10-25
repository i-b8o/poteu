import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {
  static String get bannerAdUnitId => Platform.isAndroid
      // ? "ca-app-pub-6302667653389164/5522319293"
      ? "ca-app-pub-3940256099942544/2934735716"
      : "ca-app-pub-3940256099942544/2934735716";

  static void initialize() {
    MobileAds.instance.initialize();
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
        size: AdSize.largeBanner,
        adUnitId: bannerAdUnitId,
        listener: BannerAdListener(
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
          },
        ),
        request: const AdRequest());
    return ad;
  }
}
