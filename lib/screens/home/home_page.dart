import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../../themes.dart';
import '../../widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(title: 'Home'),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        child: Container(
          width: displayWidth(context),
          height: displayHeight(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColours.primary, Color.fromRGBO(255, 255, 255, 1)],
            ),
          ),
          child: // Figma Flutter Generator TopappbarWidget - RECTANGLE
              Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Container(
              //   width: displayWidth(context),
              //   height: 200,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(0),
              //       topRight: Radius.circular(0),
              //       bottomLeft: Radius.circular(15),
              //       bottomRight: Radius.circular(15),
              //     ),
              //     color: Color.fromRGBO(172, 26, 61, 1),
              //   ),
              // ),
              // // Figma Flutter Generator Group1Widget - GROUP
              // Container(
              //     width: 100,
              //     height: 100,
              //     child: Stack(children: <Widget>[
              //       Positioned(
              //           top: 0,
              //           left: 0,
              //           child: Container(
              //               width: 100,
              //               height: 100,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(15),
              //                   topRight: Radius.circular(15),
              //                   bottomLeft: Radius.circular(15),
              //                   bottomRight: Radius.circular(15),
              //                 ),
              //                 color: Color.fromRGBO(237, 205, 205, 1),
              //               ),),),
              //       Positioned(
              //           top: 70,
              //           left: 0,
              //           child: Text(
              //             'Venue',
              //             textAlign: TextAlign.center,
              //             style: TextStyle(
              //                 color: Color.fromRGBO(105, 4, 28, 1),
              //                 fontFamily: 'Century Gothic',
              //                 fontSize: 16,
              //                 letterSpacing: 0.5,
              //                 fontWeight: FontWeight.normal,
              //                 height: 1.5),
              //           ),),
              //       Positioned(
              //         top: 21,
              //         left: 34,
              //         child: SvgPicture.asset('assets/icons/location_icon.svg',
              //             semanticsLabel: 'vector'),
              //       ),
              //     ],),),
            ],
          ),
        ),
      ),
    );
  }
}