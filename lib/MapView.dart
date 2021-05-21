import 'package:cached_network_image/cached_network_image.dart';
import 'package:da_eat_da/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ResultView.dart';
import 'package:geolocator/geolocator.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Set<Circle> _circles= Set.from([Circle(circleId: CircleId("myPosition"),fillColor: Color(0x50FFA500),
  center: LatLng((Get.arguments as Sendlatlng).lat, (Get.arguments as Sendlatlng).lng),
  radius: 500,strokeWidth: 0
  )]);
  @override
  Widget build(BuildContext context) {
    //Get.snackbar("알림", "위치를 변경하려면 마커를 드래그해 주세요.", snackPosition: SnackPosition.BOTTOM);
    Fluttertoast.showToast(
        msg: "위치를 변경하려면 마커를 드래그해 주세요.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white70,
        fontSize: 16.0);
    return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 100),
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                heroTag: "Button2",
                child: Text(
                  "500m",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                heroTag: "Buttton1",
                icon: Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                ),
                label: Text(
                  "Go!",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Get.to(ResultView(), transition: Transition.fadeIn);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(),
        body: Container(
          height: MediaQuery.of(context).size.height,

          child: GoogleMap(
            circles: _circles,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: CameraPosition(
                target: LatLng((Get.arguments as Sendlatlng).lat,
                    (Get.arguments as Sendlatlng).lng),
                zoom: 14),
          ),
        ),);
  }
}
