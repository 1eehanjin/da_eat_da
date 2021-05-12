import 'package:cached_network_image/cached_network_image.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:showcaseview/showcaseview.dart';
import 'NativeAds.dart';
import 'ResultView.dart';
import 'mapView.dart';
import 'package:showcaseview/showcase.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  /// Make sure you add this line here, so the plugin can access the native side
  WidgetsFlutterBinding.ensureInitialized();

  /// Make sure to initialize the MobileAds sdk. It returns a future
  /// that will be completed as soon as it initializes
  if(GetPlatform.isWeb == false) {
    await MobileAds.initialize();
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
        primaryColor: Colors.amber,
        backgroundColor: Color(0xFFF2F2F2),
        accentColor: Colors.yellow[100],
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
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  GlobalKey _one = GlobalKey();
  GlobalKey _two = GlobalKey();
  GlobalKey _three = GlobalKey();
  List<AnimationController> _animationController = [];
  double firstDepth = 50;
  List<double> calculatedDepth = [];
  @override
  void initState() {

    for(int i = 0; i < 13; i++) {
      _animationController.add(AnimationController(
          duration: Duration(milliseconds: 600,), vsync: this
      )
        ..addListener(() {
          setState(() {});
        }));
      calculatedDepth.add(50);
    }
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one, _two, _three]));
  }

  int count = 12;
  List<bool> a = [
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
  double stagger(value, progress) {
    return value * (0.6 - progress);
  }
  void reverseButtonAnimation(int number){
    _animationController[number].forward();
  }
  void forwardButtonAnimation(int number){
    _animationController[number].reverse();
  }
  Widget guideButton(String name, String imageSource, int numb) {
    double PHONESIZE_WIDTH = MediaQuery.of(context).size.width;


    return Container(
        width: 100,height: 130,
      margin: EdgeInsets.only(bottom:25),
      child: GestureDetector(
          child: Opacity(
              opacity: a[numb] ? 1 : 1,
              // child: ClayContainer(
    //   width: 100,height: 130,borderRadius: 20,
    //   //surfaceColor: a[numb] ?Colors.grey[200]:Theme.of(context).backgroundColor,
    //
    //   //color: a[numb] ?Theme.of(context).accentColor:Theme.of(context).backgroundColor,
    //   spread : 8,
    //   depth: calculatedDepth[numb].toInt(),

                child: Container(
                    width: 100,
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 10,),
                        ClayContainer(color: a[numb] ? Theme.of(context).accentColor: Theme.of(context).backgroundColor,
                          width: 75,
                          height: 75,
                          borderRadius: 20,
                          //surfaceColor: a[numb] ? Theme.of(context).accentColor : Theme.of(context).backgroundColor,
                          //spread: a[numb] ? 4 : 8,color: Theme.of(context).backgroundColor,
                          depth: calculatedDepth[numb].toInt(),
                          child: Center(
                              child: Image.asset(
                                imageSource,
                                width: 50,
                                height: 60,
                                fit: BoxFit.contain,
                              )),
                        ),
                        // Container(
                        //   width: 70,
                        //   height: 70,
                        //   decoration: BoxDecoration(
                        //       shape: BoxShape.circle,
                        //       color: Theme.of(context).backgroundColor),
                        //   child: Center(
                        //       child: Image.asset(
                        //     imageSource,
                        //     width: 50,
                        //     height: 60,
                        //     fit: BoxFit.contain,
                        //   )),
                        // ),
                        Container(height: 12),
                        Text(
                          name,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: a[numb] ? Colors.black: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ],
                    )),
              //)
          ),
          onTap: () {
            setState(() {
              if (numb == 0) {
                if (a[0] == false) {
                  a[0] = true;
                  reverseButtonAnimation(numb);
                  for (int i = 1; i < a.length; i++) {
                    a[i] = true;
                    reverseButtonAnimation(i);
                  }
                  count = 12;
                } else if (a[0] == true) {
                  a[0] = false;
                  forwardButtonAnimation(numb);
                  for (int i = 1; i < a.length; i++) {
                    a[i] = false;
                    forwardButtonAnimation(i);
                  }
                  count = 0;
                }
              } else {
                if (a[numb] == true) {
                  forwardButtonAnimation(numb);
                  a[numb] = false;
                  count--;
                } else {
                  reverseButtonAnimation(numb);
                  a[numb] = true;
                  count++;
                }
                if (count == 12) {
                  forwardButtonAnimation(0);
                  a[0] = true;

                } else {
                  reverseButtonAnimation(0);
                  a[0] = false;

                }
              }
            });
          }),
    );

  }

  @override
  Widget build(BuildContext context) {

    for(int i = 0; i < 13; i++){
      calculatedDepth[i] = stagger(firstDepth, _animationController[i].value);
    }

    double PHONESIZE_WIDTH = Get.width;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // floatingActionButton:
      // MaterialButton(
      //   onPressed: () {
      //     Get.to(() => MapView(),transition:  Transition.fadeIn );
      //   },
      //   child: Hero(tag: "Button1",
      //       child: Container(
      //         width: 200, height: 60,
      //           decoration: BoxDecoration(
      //           color: Theme.of(context).accentColor,
      //           borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
      //           boxShadow: [
      //             BoxShadow(
      //                 blurRadius: 8,
      //                 offset: Offset(0, 15),
      //                 color: Theme.of(context).accentColor.withOpacity(.6),
      //                 spreadRadius: -9)
      //           ]),
      //         child: Row(mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Icon(
      //               Icons.map,
      //               color: Colors.white,),
      //               Text(
      //                 "Go!",
      //                 style: TextStyle(color: Colors.white),
      //               ),
      //           ],
      //         )
      //       ),
      //
      //
      //   ),
      // ),
      body: Stack(
        children: [

          ListView(
            children: [
              // Card(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(15)),
              //     margin: EdgeInsets.all(10),
              //     child: ListTile(
              //       title: Text(
              //         "앱 사용 설명서",
              //         style: TextStyle(
              //             color: Theme.of(context).accentColor,
              //             fontWeight: FontWeight.bold),
              //       ),
              //       leading: Icon(
              //         Icons.book,
              //         color: Theme.of(context).accentColor,
              //       ),
              //     )),
              //GetPlatform.isWeb ? Container(): NativeAds(),
              Container(
                  margin: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                  child:
                  Showcase(
                    key: _one,
                    child: Container(
                      padding: EdgeInsets.only(top:50, bottom: 30, left:10),
                      child: RichText(
                        text: TextSpan( text: '오늘의\n',
                          style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold, color: Colors.black,height: 1.3 ),
                          children: <TextSpan>[
                            TextSpan(text: '음식 테마', style: TextStyle(color: Colors.orangeAccent, fontSize: 30, fontWeight: FontWeight.bold)),
                            TextSpan(text: '는?', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold)),

                          ], ), ),
                    ),
                    description: "test",
                  )

              ),
              Container(
                // decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(25),
                //     boxShadow: [
                //       BoxShadow(
                //           blurRadius: 8,
                //           offset: Offset(0, 3),
                //           color: Colors.grey[200].withOpacity(.6),
                //           spreadRadius: 8)
                //     ]),
                // margin: EdgeInsets.all(10),padding: EdgeInsets.only(top: 30),

                child: Stack(children: [
                  Container(width: PHONESIZE_WIDTH,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,spacing: 5,
                      children: [
                        Showcase(
                          key: _three,
                          child:
                          guideButton("전체", "images/theme/koreanfood.png", 0),
                          description: 'test',
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
                  ),
                  Showcase.withWidget(
                    key: _two,
                    child: backShowCase(),
                    description: 'test',
                  ),
                ]),
              ),
            ],
          ),
          Positioned(
            bottom: 50,right: 0,
            child: MaterialButton(padding: EdgeInsets.all(0),
              onPressed: () {
                Get.to(() => MapView(),transition:  Transition.fadeIn );
              },
              child: Hero(tag: "Button1",
                child: Container(
                    width: Get.width * 0.75, height: 70,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20),),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              offset: Offset(0, 15),
                              color: Theme.of(context).primaryColor.withOpacity(.6),
                              spreadRadius: -9)
                        ]),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: PHONESIZE_WIDTH * 0.15),
                          child: Text(
                            "결정해 드릴게요!",
                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,),
                        ),
                      ],
                    )
                ),


              ),
            ),
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
          height: 190,
        )
      ],
    );
  }
}


