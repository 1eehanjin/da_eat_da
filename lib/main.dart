import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'ResultView.dart';
import 'mapView.dart';

void main() async{
  /// Make sure you add this line here, so the plugin can access the native side
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure to initialize the MobileAds sdk. It returns a future
  /// that will be completed as soon as it initializes
  await MobileAds.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/home',
      getPages: [
        GetPage(name: "/home", page: () => MyHomePage()),
        GetPage(name: "/map", page: () => MapView()),
        GetPage(name: "/result", page: () => ResultView()),
      ],
      // routes: {
      //   // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
      //   '/': (context) => MyHomePage(title: '다잇다'),
      //   // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
      //   '/map': (context) => MapView(),
      //   '/result': (context) => ResultView(),
      // },
      title: '다잇다',
      theme: ThemeData(
        primaryColor: Colors.orangeAccent,
        backgroundColor: Colors.orange[50],
        accentColor: Colors.orangeAccent,
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(headline6: TextStyle(color: Colors.white))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: '다잇다'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget guideButton(String name, String imageSource) {
    double PHONESIZE_WIDTH = MediaQuery.of(context).size.width;
    double PHONESIZE_HEIGHT = MediaQuery.of(context).size.width;
    return Container(
      width: PHONESIZE_WIDTH / 4 - 5,
      height: 150,
      child: Container(
          width: (PHONESIZE_WIDTH / 4) - 30,
          height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).backgroundColor),
                  child: Center(
                      child: Image.asset(
                    imageSource,
                    width: 50,
                    height: 60,
                    fit: BoxFit.contain,
                  )),
                ),
                onTap: () {},
              ),
              Container(height: 12),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              Container(height: 12),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(

        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("다잇다", ),centerTitle: true,

      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "Button1",
        icon: Icon( Icons.map, color: Colors.white,),
        label: Text("Go!", style: TextStyle(color: Colors.white),),
        onPressed: (){
          Get.to(MapView(),transition: Transition.fadeIn);

        },
      ),
      body: ListView(
        children: [
          NativeAds(),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(10),
              elevation: 2,
              child: ListTile(
                title: Text(
                  "앱 사용 설명서",
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold),
                ),
                leading: Icon(
                  Icons.book,
                  color: Theme.of(context).accentColor,
                ),
              )),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.all(10),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30, top: 20, bottom: 10),
                  child: Text('뭐 먹을까?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).accentColor)),
                ),
                Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    guideButton("전체", "images/theme/koreanfood.png"),
                    guideButton("한식", "images/theme/koreanfood.png"),
                    guideButton("분식", "images/theme/gimbap.png"),
                    guideButton("카페", "images/theme/cafe.png"),
                    guideButton("돈가스/회/일식", "images/theme/sushi.png"),
                    guideButton("치킨", "images/theme/chicken.png"),
                    guideButton("피자", "images/theme/pizza.png"),
                    guideButton("아시안", "images/theme/asianfood.png"),
                    guideButton("양식", "images/theme/spaguetti.png"),
                    guideButton("중국집", "images/theme/chinesefood.png"),
                    guideButton("찜/탕", "images/theme/cooking.png"),
                    guideButton("패스트푸드", "images/theme/frenchfries.png"),
                    guideButton("술", "images/theme/beer.png"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class NativeAds extends StatefulWidget {
  const NativeAds({Key key}) : super(key: key);

  @override
  _NativeAdsState createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds>
    with AutomaticKeepAliveClientMixin {
  Widget child;

  final controller = NativeAdController();

  @override
  void initState() {
    super.initState();
    controller.load();
    controller.onEvent.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (child != null) return child;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() => child = SizedBox());
        await Future.delayed(Duration(milliseconds: 20));
        setState(() => child = null);
      },
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            if (controller.isLoaded)
            NativeAd(
              height: 300,
              // unitId: MobileAds.nativeAdVideoTestUnitId,
              builder: (context, child) {
                return Material(
                  elevation: 8,
                  child: child,
                );
              },
              buildLayout: fullBuilder,
              loading: Text('loading'),
              error: Text('error'),
              icon: AdImageView(size: 40),
              headline: AdTextView(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
              media: AdMediaView(
                height: 180,
                width: MATCH_PARENT,
                elevation: 6,
                elevationColor: Colors.deepOrangeAccent,
              ),
              attribution: AdTextView(
                width: WRAP_CONTENT,
                height: WRAP_CONTENT,
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                margin: EdgeInsets.only(right: 4),
                maxLines: 1,
                text: 'Anúncio',
                decoration: AdDecoration(
                  borderRadius: AdBorderRadius.all(10),
                  border: BorderSide(color: Colors.green, width: 1),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              button: AdButtonView(
                elevation: 18,
                elevationColor: Colors.orangeAccent,
                height: MATCH_PARENT,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

AdLayoutBuilder get fullBuilder => (ratingBar, media, icon, headline,
    advertiser, body, price, store, attribuition, button) {
  return AdLinearLayout(
    padding: EdgeInsets.all(10),
    // The first linear layout width needs to be extended to the
    // parents height, otherwise the children won't fit good
    width: MATCH_PARENT,
    decoration: AdDecoration(
        gradient: AdLinearGradient(
          colors: [Colors.white, Colors.white],
          orientation: AdGradientOrientation.tl_br,
        )),
    children: [
      media,
      AdLinearLayout(
        children: [
          icon,
          AdLinearLayout(children: [
            headline,
            AdLinearLayout(
              children: [attribuition, advertiser, ratingBar],
              orientation: HORIZONTAL,
              width: MATCH_PARENT,
            ),
          ], margin: EdgeInsets.only(left: 4)),
        ],
        gravity: LayoutGravity.center_horizontal,
        width: WRAP_CONTENT,
        orientation: HORIZONTAL,
        margin: EdgeInsets.only(top: 6),
      ),
      AdLinearLayout(
        children: [button],
        orientation: HORIZONTAL,
      ),
    ],
  );
};

