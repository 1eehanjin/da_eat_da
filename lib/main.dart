import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:showcaseview/showcaseview.dart';
import 'ResultView.dart';
import 'mapView.dart';
import 'package:showcaseview/showcase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  /// Make sure you add this line here, so the plugin can access the native side
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure to initialize the MobileAds sdk. It returns a future
  /// that will be completed as soon as it initializes
  await MobileAds.initialize();

  runApp(
    ShowCaseWidget(
      autoPlay: false,
      autoPlayDelay: Duration(seconds: 8),
      autoPlayLockEnable: false,
      builder: Builder(
        builder: (context) => MyApp(),
      ),
      onStart: (index, key) {
        print('onStart: $index, $key');
      },
      onComplete: (index, key) {
        print('onComplete: $index, $key');
      },
    ),
  );
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

      home: ShowCaseWidget(
        builder: Builder(
          builder: (context) => MyHomePage(title: '다잇다'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      'PREFERENCES_IS_FIRST_LAUNCH_STRING';

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();

  BuildContext myContext;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) =>
    //     ShowCaseWidget.of(context).startShowCase([_one, _two, _three, _four]));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result)
          ShowCaseWidget.of(myContext)
              .startShowCase([_one, _two, _three, _four]);
      });
    });
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(MyHomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          MyHomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING, true);

    return isFirstLaunch;
  }

  int count = 12;
  List<bool> a = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  Widget guideButton(String name, String imageSource, int numb) {
    double PHONESIZE_WIDTH = MediaQuery.of(context).size.width;
    return InkWell(
        child: Opacity(
            opacity: a[numb] ? 1 : 0.5,
            child: Container(
              width: PHONESIZE_WIDTH / 4 - 5,
              height: 130,
              child: Container(
                  width: (PHONESIZE_WIDTH / 4) - 30,
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
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
                      Container(height: 12),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ],
                  )),
            )),
        onTap: () {
          setState(() {
            if (numb == 0) {
              if (a[numb] == false) {
                a[numb] = !a[numb];
                for (int i = 1; i < a.length; i++) {
                  a[i] = a[numb];
                }
                count = 12;
              } else if (a[numb] == true) {
                a[numb] = !a[numb];
                for (int i = 1; i < a.length; i++) {
                  a[i] = a[numb];
                }
                count = 0;
              }
            } else {
              if (a[numb] == true) {
                a[numb] = !a[numb];
                count--;
              } else if (a[numb] == false) {
                a[numb] = !a[numb];
                count++;
              }
              if (count == 12) {
                a[0] = true;
              } else {
                a[0] = false;
              }
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    double PHONESIZE_WIDTH = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          "다잇다",
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Showcase(
        key: _four,
        showArrow: false,
        description: 'test121212121212121',
        child: FloatingActionButton.extended(
          heroTag: "Button1",
          icon: Icon(
            Icons.map,
            color: Colors.white,
          ),
          label: Text(
            "Go!",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Get.to(MapView(), transition: Transition.fadeIn);
          },
        ),
      ),
      body: ListView(
        children: [
          NativeAds(),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: EdgeInsets.all(10),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: Row(
                      children: [
                        Showcase(
                          key: _one,
                          child: Container(
                            child: Text('뭐 먹을까?',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).accentColor)),
                          ),
                          description: "test21212212121212",
                        )
                      ],
                    )),
                Stack(children: [
                  Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: [
                      Showcase(
                        key: _three,
                        showArrow: false,
                        child:
                            guideButton("전체", "images/theme/koreanfood.png", 0),
                        description: 'test21211212121212',
                      ),
                      guideButton("한식", "images/theme/koreanfood.png", 1),
                      guideButton("분식", "images/theme/gimbap.png", 2),
                      guideButton("카페", "images/theme/cafe.png", 3),
                      guideButton("돈가스/회/일식", "images/theme/sushi.png", 4),
                      guideButton("치킨", "images/theme/chicken.png", 5),
                      guideButton("피자", "images/theme/pizza.png", 6),
                      guideButton("아시안", "images/theme/asianfood.png", 7),
                      guideButton("양식", "images/theme/spaguetti.png", 8),
                      guideButton("중국집", "images/theme/chinesefood.png", 9),
                      guideButton("찜/탕", "images/theme/cooking.png", 10),
                      guideButton("패스트푸드", "images/theme/frenchfries.png", 11),
                      guideButton("술", "images/theme/beer.png", 12),
                    ],
                  ),
                  Showcase.withWidget(
                    key: _two,
                    child: backShowCase(),
                    description: 'test1212212121211211',
                  ),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //test
  Widget backShowCase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130,
        )
      ],
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
    return Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: (controller.isLoaded)
            ? NativeAd(
                height: 300,
                unitId: MobileAds.nativeAdVideoTestUnitId,
                builder: (context, child) {
                  return Material(
                    //elevation: 3,
                    child: child,
                  );
                },
                buildLayout: fullBuilder,
                loading: Container(
                    height: 300,
                    alignment: Alignment.center,
                    child: Text('loading')),
                error: Text('error'),
                icon: AdImageView(size: 40),
                headline: AdTextView(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                ),
                media: AdMediaView(
                  height: 180,
                  width: MATCH_PARENT,
                  //elevation: 6,
                  //elevationColor: Colors.deepOrangeAccent,
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
                    border: BorderSide(color: Colors.orangeAccent, width: 1),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                button: AdButtonView(
                  textStyle: TextStyle(color: Colors.white),
                  decoration: AdDecoration(
                      borderRadius: AdBorderRadius.all(50),
                      backgroundColor: Colors.orangeAccent),
                  height: MATCH_PARENT,
                ),
              )
            : Container(
                height: 300,
                alignment: Alignment.center,
                child: Text('loading')));
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
          colors: [Colors.orange[50], Colors.orange[50]],
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
