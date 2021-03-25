import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ResultView.dart';
import 'mapView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // "/" Route로 이동하면, FirstScreen 위젯을 생성합니다.
        '/': (context) => MyHomePage(title: '다잇다'),
        // "/second" route로 이동하면, SecondScreen 위젯을 생성합니다.
        '/map': (context) => MapView(),
        '/result': (context) => ResultView(),
      },
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
        title: Text(
          widget.title,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.map,
          color: Colors.white,
        ),
        label: Text(
          "Go!",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/map');
        },
      ),
      body: ListView(
        children: [
          Container(
              child: CachedNetworkImage(
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl:
                "https://knowmywork.com/wp-content/uploads/2017/09/Android-Native-Express-Ad-in-RecyclerView-e1507394886156.jpg",
          )),
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
