import 'dart:math';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:da_eat_da/UserData.dart';
import 'package:da_eat_da/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class ResultView extends StatefulWidget {
  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  UserData userData = UserData(latitude: 37.4500221, longitude: 126.653488, radius: 500, restaurantTheme: ["중식", "한식", "일식"]);
  var googlePlace = GooglePlace("AIzaSyBZD_3rrGlloGukFuHASvN5M10filFEims");
  List<SearchResult> restaurantList = [];
  SearchResult pickedRestaurant = null;
  final _random = new Random();
  Uint8List pickedRestaurantPhoto;
  bool isPicked = false;
  String waitMessage = "주변 가게를 찾고있습니다...";
  void pickRestaurant() async {
    await makeRestaurantList();
    waitMessage = "가게를 뽑고 있습니다...";
    setState(() {

    });
    await randomPickRestaurant();
  }
  void makeRestaurantList() async {
    String myPageToken = null;
    int maxCount = 0; //혹시나 에러나서 api 과다 호출되는 것을 막기 위함
    for(int i = 0; i < userData.restaurantTheme.length; i++){
      myPageToken = await addRestaurantList(userData.restaurantTheme[i]);
      while(myPageToken != null && maxCount < 10){
         myPageToken = await addRestaurantList(userData.restaurantTheme[i], myPageToken: myPageToken);
         maxCount++;
      }
    }
  }
  Future<String> addRestaurantList(String keyword, {String myPageToken}) async {
    var result = await googlePlace.search.getNearBySearch(
    Location(lat: userData.latitude, lng: userData.longitude), userData.radius,
    type: "restaurant", keyword: keyword, pagetoken: myPageToken!= null ? myPageToken : null
    );
    if(result == null){
      return null;
    }
    for(int i = 0; i < result.results.length; i++) {
      restaurantList.add(result.results[i]);
      //print(result.results[i].name);
    }
    //print(result.nextPageToken);
    return result.nextPageToken;
  }
  void randomPickRestaurant() async {
    if(restaurantList.length == 0){
      return;
    }

    pickedRestaurant = restaurantList[_random.nextInt(restaurantList.length)];
    if(pickedRestaurant.photos != null) {
      pickedRestaurantPhoto = await this.googlePlace.photos.get(
          pickedRestaurant.photos[0].photoReference, null, 400);
    }
    else{
      pickedRestaurantPhoto = null;
    }
    isPicked = true;
    setState(() {});
  }
  Widget restaurantDetailCard(){
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 150,
        color: Colors.white,
        margin: EdgeInsets.all(10),
        child:
        (restaurantList.length == 0 || pickedRestaurant==null ?
        Text("주변에 조회되는 가게가 없습니다!"):
        Column(
          children: [
            Container(height: 100,width: 100,
                child:
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                    child:
                    pickedRestaurantPhoto != null ?
                    Image.memory(pickedRestaurantPhoto,
                      fit: BoxFit.fill,) :
                    Text("No Image")
                )
            ),
            Text(pickedRestaurant.name),
          ],
        ))
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickRestaurant();
  }
  @override
  Widget build(BuildContext context) {
    if(isPicked == false){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
          height: 200,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularProgressIndicator(),
                  Text(waitMessage)
                ],
              ),
            )

        ),
      ));
    }
    else {
      return Scaffold(
        floatingActionButton: Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                backgroundColor: Colors.white,
                heroTag: "Button1",
                icon: Icon(
                  Icons.home,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                label: Text(
                  "홈으로",
                  style: TextStyle(color: Theme
                      .of(context)
                      .primaryColor),
                ),
                onPressed: () {
                  Get.offAll(MyHomePage(), transition: Transition.fadeIn);
                },
              ),
              FloatingActionButton.extended(
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
                heroTag: "Button2",
                onPressed: () async {
                  pickRestaurant();
                },
                icon: Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                ),
                label: Text(
                  "다시뽑기!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              restaurantDetailCard()
            ],
          ),
        ),
        appBar: AppBar(),
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,

          child: GoogleMap(
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng(userData.latitude,
                    userData.longitude),
                zoom: 14),
          ),
        ),
      );
    }
  }
}
