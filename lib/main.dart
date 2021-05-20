import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:da_eat_da/AdWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:showcaseview/showcaseview.dart';
import 'ResultView.dart';
import 'mapView.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:showcaseview/showcase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_color/flutter_color.dart';

void main() async {
  /// Make sure you add this line here, so the plugin can access the native side
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure to initialize the MobileAds sdk. It returns a future
  /// that will be completed as soon as it initializes
  if (GetPlatform.isWeb == false) {
    MobileAds.instance.initialize();
    //MobileAds.setTestDeviceIds([]);
  }

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



class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String selectedAddress;
  @override
  void initState() {
    super.initState();
  }



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
        primaryColor: Colors.amber,
        backgroundColor: Color(0xFFF2F2F2),
        accentColor: Colors.orange[100],
        appBarTheme: AppBarTheme(
            textTheme: TextTheme(headline6: TextStyle(color: Colors.white))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: ShowCaseWidget(
        builder: Builder(
          builder: (context) => MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      'PREFERENCES_IS_FIRST_LAUNCH_STRING';



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Sendlatlng {
  double lat;
  double lng;
  Sendlatlng({this.lat, this.lng});
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  GlobalKey _four = GlobalKey();
  Position position;


    int count = 0;
    double initialDepth = 50;
    List<bool> buttonState = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    List<AnimationController> _animationController = [];
    List<double> calculatedDepth = [];
  _setInitialPosition() async {
    position = await Geolocator.getCurrentPosition();
    setState(() {});
  }

    @override
    void initState() {
    _setInitialPosition();
      for (int i = 0; i < 13; i++) {
        _animationController.add(AnimationController(
            duration: Duration(
              milliseconds: 600,
            ),
            vsync: this)
          ..addListener(() {
            setState(() {});
          }));
        calculatedDepth.add(50);
      }
      super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _isFirstLaunch().then((result) {
//         if (result)
//           ShowCaseWidget.of(context).startShowCase([_one, _two, _three, _four]);
//       });
//     });
      WidgetsBinding.instance.addPostFrameCallback((_) =>
          ShowCaseWidget.of(context).startShowCase(
              [_one, _two, _three, _four]));
    }

    Future<bool> _isFirstLaunch() async {
      final sharedPreferences = await SharedPreferences.getInstance();
      bool isFirstLaunch = sharedPreferences
          .getBool(MyHomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
          true;

      if (!isFirstLaunch)
        sharedPreferences.setBool(
            MyHomePage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

      return isFirstLaunch;
    }

    double stagger(value, progress) {
      return value * (0.6 - progress);
    }

    void forwardButtonAnimation(int buttonNumber) {
      _animationController[buttonNumber].forward();
    }

    void reverseButtonAnimation(int buttonNumber) {
      _animationController[buttonNumber].reverse();
    }

    Widget guideButton(String name, String imageSource, int buttonNumber) {
      return GestureDetector(
          child: Container(
              width: 100,
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                  ),
                  ClayContainer(
                    color: Theme
                        .of(context)
                        .accentColor
                        .mix(
                        Theme
                            .of(context)
                            .backgroundColor,
                        1 - _animationController[buttonNumber].value),
                    width: 75,
                    height: 75,
                    borderRadius: 20,
                    depth: calculatedDepth[buttonNumber].toInt(),
                    child: Center(
                        child: Image.asset(
                          imageSource,
                          width: 50,
                          height: 60,
                          fit: BoxFit.contain,
                        )),
                  ),
                  Container(height: 12),
                  Container(height: 40,
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ),
                ],
              )),
          onTap: () {
            setState(() {
              if (buttonNumber == 0) {
                if (buttonState[0] == false) {
                  buttonState[0] = true;
                  forwardButtonAnimation(0);
                  for (int i = 1; i < buttonState.length; i++) {
                    buttonState[i] = true;
                    forwardButtonAnimation(i);
                  }
                  count = 12;
                } else if (buttonState[0] == true) {
                  buttonState[0] = false;
                  reverseButtonAnimation(buttonNumber);
                  for (int i = 1; i < buttonState.length; i++) {
                    buttonState[i] = false;
                    reverseButtonAnimation(i);
                  }
                  count = 0;
                }
              } else {
                if (buttonState[buttonNumber] == true) {
                  reverseButtonAnimation(buttonNumber);
                  buttonState[buttonNumber] = false;
                  count--;
                } else {
                  forwardButtonAnimation(buttonNumber);
                  buttonState[buttonNumber] = true;
                  count++;
                }
                if (count == 12) {
                  forwardButtonAnimation(0);
                  buttonState[0] = true;
                } else {
                  reverseButtonAnimation(0);
                  buttonState[0] = false;
                }
              }
            });
          });
    }

    @override
    Widget build(BuildContext context) {
      for (int i = 0; i < 13; i++) {
        calculatedDepth[i] =
            stagger(initialDepth, _animationController[i].value);
      }
      double PHONESIZE_WIDTH = Get.width;
      return Scaffold(
        backgroundColor: Theme
            .of(context)
            .backgroundColor,
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                      child: Showcase(
                        key: _one,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 50, bottom: 30, left: 10),
                          child: RichText(
                            text: TextSpan(
                              text: '오늘의\n',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  height: 1.3),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '음식 테마',
                                    style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '는?',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                        description: "test",
                      )),
                  Container(
                    child: Stack(children: [
                      Container(
                        width: PHONESIZE_WIDTH,
                        child: Wrap(
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 5,
                          children: [
                            Showcase(
                              key: _three,
                              child: guideButton(
                                  "전체", "images/theme/koreanfood.png", 0),
                              description: 'test',
                            ),
                            guideButton("한식", "images/theme/koreanfood.png", 1),
                            guideButton("분식", "images/theme/gimbap.png", 2),
                            guideButton("카페", "images/theme/cafe.png", 3),
                            guideButton(
                                "돈가스/회/일식", "images/theme/sushi.png", 4),
                            guideButton("치킨", "images/theme/chicken.png", 5),
                            guideButton("피자", "images/theme/pizza.png", 6),
                            guideButton("아시안", "images/theme/asianfood.png", 7),
                            guideButton("양식", "images/theme/spaguetti.png", 8),
                            guideButton(
                                "중국집", "images/theme/chinesefood.png", 9),
                            guideButton("찜/탕", "images/theme/cooking.png", 10),
                            guideButton(
                                "패스트푸드", "images/theme/frenchfries.png", 11),
                            guideButton("술", "images/theme/beer.png", 12),
                          ],
                        ),
                      ),

                      Showcase.withWidget(
                        key: _two,
                        child: backShowCase(),
                        description: 'test1212212121211211',
                      ),
                    ]),
                  ),
                  Container(
                    height: 150,
                  )
                ],
              ),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(

                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Get.to(
                        MapView(),
                        transition: Transition.fadeIn,
                        arguments:
                        Sendlatlng(
                            lat: position != null ? position.latitude : 37.4500221, lng: position != null? position.longitude : 126.653488 ));
                  },

                  child: Showcase(
                    key: _four,
                    showArrow: false,
                    description: 'test121212121212121',
                    child: Hero(
                      tag: "Button1",
                      child: Container(
                        width: Get.width,
                        alignment: Alignment.center,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Theme
                                .of(context)
                                .primaryColor,

                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 8,
                                  offset: Offset(0, 15),
                                  color: Theme
                                      .of(context)
                                      .primaryColor
                                      .withOpacity(.6),
                                  spreadRadius: -9)
                            ]),
                        child: Text(
                          "결정해 드릴게요!",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),),
                    ),
                  ),
                ),
                 Container(width: PHONESIZE_WIDTH,
                   child: BannerAdWidget(AdSize.banner),
                 ),

              ],
            ),
          ],
        ),
      );
    }

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
