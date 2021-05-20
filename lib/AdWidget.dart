import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  BannerAdWidget(this.size);

  final AdSize size;

  @override
  State<StatefulWidget> createState() => BannerAdState();
}

class BannerAdState extends State<BannerAdWidget> {
  BannerAd _bannerAd;

  @override
  void initState() {
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    request: AdRequest(),
    size: AdSize.banner,
    listener: AdListener(
    onAdLoaded: (_) {
    setState(() {
    });
    },
    onAdFailedToLoad: (ad, err) {
    print('Failed to load a banner ad: ${err.message}');
    ad.dispose();
    },
    ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.blueGrey,
    width: _bannerAd.size.width.toDouble(),
    height: _bannerAd.size.height.toDouble(),
    child: AdWidget(ad: _bannerAd),
    );
  }
}

