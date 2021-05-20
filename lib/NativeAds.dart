// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:native_admob_flutter/native_admob_flutter.dart';
//
// class NativeAds extends StatefulWidget {
//   const NativeAds({Key key}) : super(key: key);
//
//   @override
//   _NativeAdsState createState() => _NativeAdsState();
// }
//
// class _NativeAdsState extends State<NativeAds>
//     with AutomaticKeepAliveClientMixin {
//   Widget child;
//
//   final controller = NativeAdController();
//
//   @override
//   void initState() {
//     super.initState();
//     controller.load();
//     controller.onEvent.listen((event) {
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     if (child != null) return child;
//     return Padding(
//         padding: const EdgeInsets.only(bottom: 0),
//         child: (controller.isLoaded)
//             ? NativeAd(
//           height: 300,
//           unitId: MobileAds.nativeAdVideoTestUnitId,
//           builder: (context, child) {
//             return Material(
//               //elevation: 3,
//               child: child,
//             );
//           },
//           buildLayout: fullBuilder,
//           loading: Container(
//               height: 300,
//               alignment: Alignment.center,
//               child: Text('loading')),
//           error: Text('error'),
//           icon: AdImageView(size: 40),
//           headline: AdTextView(
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//             maxLines: 1,
//           ),
//           media: AdMediaView(
//             height: 180,
//             width: MATCH_PARENT,
//             //elevation: 6,
//             //elevationColor: Colors.deepOrangeAccent,
//           ),
//           attribution: AdTextView(
//             width: WRAP_CONTENT,
//             height: WRAP_CONTENT,
//             padding: EdgeInsets.symmetric(horizontal: 2, vertical: 0),
//             margin: EdgeInsets.only(right: 4),
//             maxLines: 1,
//             text: 'Anúncio',
//             decoration: AdDecoration(
//               borderRadius: AdBorderRadius.all(10),
//               border: BorderSide(color: Colors.orangeAccent, width: 1),
//             ),
//             style: TextStyle(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           button: AdButtonView(
//             textStyle: TextStyle(color: Colors.white),
//             decoration: AdDecoration(
//                 borderRadius: AdBorderRadius.all(50),
//                 backgroundColor: Colors.orangeAccent),
//             height: MATCH_PARENT,
//           ),
//         )
//             : Container(
//             height: 300,
//             alignment: Alignment.center,
//             child: Text('loading')));
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }
//
// AdLayoutBuilder get fullBuilder => (ratingBar, media, icon, headline,
//     advertiser, body, price, store, attribuition, button) {
//   return AdLinearLayout(
//     padding: EdgeInsets.all(10),
//     // The first linear layout width needs to be extended to the
//     // parents height, otherwise the children won't fit good
//     width: MATCH_PARENT,
//     decoration: AdDecoration(
//         gradient: AdLinearGradient(
//           colors: [Colors.orange[50], Colors.orange[50]],
//           orientation: AdGradientOrientation.tl_br,
//         )),
//     children: [
//       media,
//       AdLinearLayout(
//         children: [
//           icon,
//           AdLinearLayout(children: [
//             headline,
//             AdLinearLayout(
//               children: [attribuition, advertiser, ratingBar],
//               orientation: HORIZONTAL,
//               width: MATCH_PARENT,
//             ),
//           ], margin: EdgeInsets.only(left: 4)),
//         ],
//         gravity: LayoutGravity.center_horizontal,
//         width: WRAP_CONTENT,
//         orientation: HORIZONTAL,
//         margin: EdgeInsets.only(top: 6),
//       ),
//       AdLinearLayout(
//         children: [button],
//         orientation: HORIZONTAL,
//       ),
//     ],
//   );
// };