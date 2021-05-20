import 'package:cached_network_image/cached_network_image.dart';
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
  @override
  Widget build(BuildContext context) {
    //Get.snackbar("알림", "위치를 변경하려면 마커를 드래그해 주세요.", snackPosition: SnackPosition.BOTTOM);
    Fluttertoast.showToast(
        msg: "위치를 변경하려면 마커를 드래그해 주세요.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Theme.of(context).accentColor,
        backgroundColor: Colors.white70,
        fontSize: 16.0);
    return Scaffold(
        floatingActionButton: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                heroTag: "Button1",
                child: Text(
                  "500m",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
              FloatingActionButton.extended(
                heroTag: "Buttton2",
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
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationEnabled: true,
                initialCameraPosition:
                    CameraPosition(target: LatLng(40, 40), zoom: 14),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0x99ffffff)),
                        child: Icon(Icons.location_on,
                            size: 50, color: Colors.amber)),
                  ],
                )),
          ],
        ));
  }
}
