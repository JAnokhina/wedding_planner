import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/firebase_services/venues_service.dart';
import 'package:wedding_planner/firebase_state_management/venue_state.dart';

import '../../firebase_models/venue_model.dart';
import '../../locator.dart';
import '../../main.dart';

class Venue extends StatefulWidget {
  const Venue({Key? key}) : super(key: key);

  @override
  State<Venue> createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  initialise() {
    Provider.of<VenueState>(context, listen: false).refreshAllVenues();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    final venueState = Provider.of<VenueState>(context);
    List<VenueModel> allVenues = venueState.allVenues;

    print('On Page Venues: ${allVenues.first.name}');
    double lat = -33.936609;
    double long = 18.587571;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(lat, long),
              zoom: 14.4746,
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(3),
          //       color: Colors.white,
          //     ),
          //     margin: const EdgeInsets.only(left: 16, right: 16, bottom: 21),
          //     padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
          //   ),
          // ),
          // Align(
          //   alignment: const Alignment(0.88, 0.53),
          //   child: SizedBox(
          //       width: 120,
          //       child: ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //             foregroundColor: Colors.black,
          //             backgroundColor: Colors.white,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(45))),
          //         child: Row(
          //           children: const [
          //             Icon(Icons.directions),
          //             Text('Directions'),
          //           ],
          //         ),
          //         onPressed: () => {
          //           // MapsLauncher.launchQuery(
          //           //     '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA'),
          //         },
          //       )),
          // ),
          // Align(
          //     alignment: const Alignment(-1, -0.9),
          //     child: IconButton(
          //       onPressed: () => {},
          //       icon: const Icon(Icons.circle),
          //       color: Colors.white,
          //       iconSize: 50,
          //     )),
          // Align(
          //     alignment: const Alignment(-0.97, -0.888),
          //     child: IconButton(
          //       onPressed: () => {
          //         context.pop(),
          //       },
          //       icon: const Icon(Icons.keyboard_arrow_left_rounded),
          //       iconSize: 40,
          //     ))
        ],
      ),
      // bottomNavigationBar: Container(
      //   color: Colors.white,
      //   width: displayWidth(context) * 0.94,
      //   height: displayHeight(context) * 0.1,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         decoration: BoxDecoration(
      //             border: Border.all(
      //               color: AppColours.primary,
      //             ),
      //             borderRadius: BorderRadius.circular(3)),
      //         child: MaterialButton(
      //           minWidth: displayWidth(context) * 0.94,
      //           onPressed: () {
      //             launchUrl(Uri.parse("tel://0826387672"));
      //           },
      //           color: Colors.white,
      //           textColor: AppColours.primary,
      //           elevation: 0,
      //           child: const Text(
      //             "Call",
      //             style: TextStyle(fontFamily: 'SFPRO-REGULAR', fontSize: 16),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // String name = '';
  // List<String> names = [];
  // return Scaffold(
  //   appBar: WPAppBar(
  //     title: 'Venue',
  //   ),
  //   body: ListView(children: [
  //     GetUserName('toczHnasqyRjI1ldvslL'),
  //     AddUser(
  //       fullName: 'Julia',
  //       age: 26,
  //       company: 'Acumen',
  //     ),
  //     Container(
  //       child: TextButton(
  //         onPressed: () {
  //           firestore
  //               .collection('users')
  //               .get()
  //               .then((QuerySnapshot querySnapshop) {
  //             querySnapshop.docs.forEach((doc) {
  //               name = doc['name'];
  //               setState(() {
  //                 names.add(name);
  //               });
  //             });
  //           });
  //         },
  //         child: Text(
  //           'Press me',
  //           style: TextStyle(color: Colors.black),
  //         ),
  //       ),
  //     ),
  //     for (var name in names) ...[Text(name)]
  //   ]),
  // );
  // }
}

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser({required this.fullName, required this.company, required this.age});

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'full_name': fullName, // John Doe
            'company': company, // Stokes and Sons
            'age': age // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    return TextButton(
      onPressed: addUser,
      child: Text(
        "Add User",
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}

// //TODO Remove hardcoded lat long and detailed card inputs
// class FullScreenMap extends StatelessWidget {
//   const FullScreenMap({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double lat = -33.936609;
//     double long = 18.587571;
//     return Scaffold(
//       body: Stack(
//         children: [
//           const GoogleMap(
//             mapType: MapType.hybrid,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(37.42796133580664, -122.085749655962),
//               zoom: 14.4746,
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(3),
//                   color: ColorPalette.white,
//                 ),
//                 margin: const EdgeInsets.only(left: 16, right: 16, bottom: 21),
//                 padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
//                 child: const DetailedCard(
//                   header: 'Event',
//                   open: true,
//                   imagePath: "",
//                   address: "",
//                   rating: 0,
//                   hours: '',
//                 )),
//           ),
//           Align(
//             alignment: const Alignment(0.88, 0.53),
//             child: SizedBox(
//                 width: 120,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       primary: ColorPalette.white,
//                       onPrimary: ColorPalette.black,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(45))),
//                   child: Row(
//                     children: const [
//                       Icon(Icons.directions),
//                       Text('Directions'),
//                     ],
//                   ),
//                   onPressed: () => {
//                     // MapsLauncher.launchQuery(
//                     //     '1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA'),
//                   },
//                 )),
//           ),
//           Align(
//               alignment: const Alignment(-1, -0.9),
//               child: IconButton(
//                 onPressed: () => {},
//                 icon: const Icon(Icons.circle),
//                 color: ColorPalette.white,
//                 iconSize: 50,
//               )),
//           Align(
//               alignment: const Alignment(-0.97, -0.888),
//               child: IconButton(
//                 onPressed: () => {
//                   context.pop(),
//                 },
//                 icon: const Icon(Icons.keyboard_arrow_left_rounded),
//                 iconSize: 40,
//               ))
//         ],
//       ),
//       bottomNavigationBar: Container(
//         color: ColorPalette.white,
//         width: displayWidth(context) * 0.94,
//         height: displayHeight(context) * 0.1,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                   border: Border.all(
//                     color: ColorPalette.primary,
//                   ),
//                   borderRadius: BorderRadius.circular(3)),
//               child: MaterialButton(
//                 minWidth: displayWidth(context) * 0.94,
//                 onPressed: () {
//                   launch("tel://0826387672");
//                 },
//                 color: ColorPalette.white,
//                 textColor: ColorPalette.primary,
//                 elevation: 0,
//                 child: const Text(
//                   "Call",
//                   style: TextStyle(fontFamily: 'SFPRO-REGULAR', fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }