import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'ResultView.dart';
import 'mapView.dart';

void main() {
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        primaryColor: Colors.orangeAccent,
        backgroundColor: Colors.orange[50],
        accentColor: Colors.orangeAccent,
        appBarTheme: AppBarTheme(textTheme: TextTheme(headline6: TextStyle(color: Colors.white))),
        //canvasColor: Colors.yellow,
        //Color.fromRGBO(10, 199, 169, 1),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: '다잇다'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget guideButton(String name, String imageSource){
    return Container(width:100, height:150,
      child: FlatButton(
        child: Container(
            width:100, height: 140,
            child:Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height:10),
                Container(width: 70,height: 70,decoration: BoxDecoration(shape: BoxShape.circle,color: Theme.of(context).backgroundColor),
                  child:Center(child: Image.asset(imageSource,width: 50, height: 60, fit: BoxFit.contain,))
                  ,),
                Container(height: 12),
                Text(name, textAlign: TextAlign.center,),
                Container(height: 12),
              ],
            )
        ),
        onPressed: () {
          /*...*/

        },

      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("다잇", ),centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton.extended(
        icon: Icon( Icons.map, color: Colors.white,),
        label: Text("Go!", style: TextStyle(color: Colors.white),),
        onPressed: (){
          Get.toNamed('/map',);
        },
      ),

      body: ListView(
        children: [
          Container(
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageUrl: "https://knowmywork.com/wp-content/uploads/2017/09/Android-Native-Express-Ad-in-RecyclerView-e1507394886156.jpg",)

          ),
          Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(10),
              elevation: 2,
              child: ListTile(
                title: Text("앱 사용 설명서", style: TextStyle(color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),),leading: Icon(Icons.book, color: Theme.of(context).accentColor,),
              )
          ),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),margin: EdgeInsets.all(10),
            elevation: 2,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(padding: EdgeInsets.only(left: 30, top: 20, bottom: 10),
                  child: Text(
                      '뭐 먹을까?',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Theme.of(context).accentColor)
                  ),
                ),
                Wrap(alignment: WrapAlignment.spaceEvenly,
                  children: [
                    guideButton("전체", "images/theme/block.png"),
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

