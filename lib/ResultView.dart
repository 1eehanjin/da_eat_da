import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ResultView extends StatefulWidget {
  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:
        Container(height:300,
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton.extended(backgroundColor:Colors.white,
                icon: Icon( Icons.home, color: Theme.of(context).accentColor,),
                label: Text("홈으로", style: TextStyle(color: Theme.of(context).accentColor),),
                onPressed: (){
                  Get.toNamed('/home');
                },
              ),
              FloatingActionButton.extended(
                icon: Icon( Icons.restaurant_menu, color: Colors.white,),
                label: Text("다시뽑기!", style: TextStyle(color: Colors.white),),

              ),
              Card(child:
                Container(width: MediaQuery.of(context).size.width - 60,height: 150, color: Colors.white,margin: EdgeInsets.all(10),


                ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),

              )
            ],
          ),
        ),
        appBar: AppBar(),
        body:Stack(
          children: [
            Container(height: MediaQuery.of(context).size.height,
              child: CachedNetworkImage(fit: BoxFit.fitHeight,
                imageUrl: "https://blog.kakaocdn.net/dn/cyXq4J/btqB2v48gwJ/skJQBJUdvTuPmKYqBM6rbK/img.png",
              ),
            ),



            Container(
                height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                        width: 200,height: 200,
                        decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0x99ffffff)),
                        child:  Icon(Icons.location_on, size: 50,color: Colors.amber)),


                  ],
                )
            ),
          ],
        )
    );
  }
}