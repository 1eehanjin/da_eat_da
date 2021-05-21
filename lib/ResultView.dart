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
  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).accentColor,
                ),
                label: Text(
                  "홈으로",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () {
                  Get.offAll(MyHomePage(), transition: Transition.fadeIn);
                },
              ),
              FloatingActionButton.extended(
                heroTag: "Button2",
                onPressed: () async {
                  var googlePlace = GooglePlace("AIzaSyBZD_3rrGlloGukFuHASvN5M10filFEims");
                  var result = await googlePlace.search.getNearBySearch(
                      Location(lat: 37.45119, lng: 126.656338), 500,
                      type: "restaurant", keyword: "");
                  for(int i = 0; i < result.results.length; i++) {
                    print(result.results[i].name);
                  }
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
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 150,
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              )
            ],
          ),
        ),
        appBar: AppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,

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
