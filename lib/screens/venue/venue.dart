import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as mapLaunch;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wedding_planner/firebase_state_management/auth_state.dart';
import 'package:wedding_planner/firebase_state_management/profile_state.dart';
import 'package:wedding_planner/firebase_state_management/venue_state.dart';
import 'package:wedding_planner/themes.dart';
import '../../firebase_models/venue_model.dart';
import '../../main.dart';

class Venue extends StatefulWidget {
  const Venue({Key? key}) : super(key: key);

  @override
  State<Venue> createState() => _VenueState();
}

class _VenueState extends State<Venue> {
  initialise() {
    Provider.of<VenueState>(context, listen: false).refreshAllVenues();
    Provider.of<VenueState>(context, listen: false).sortVenuesByCity();
    Provider.of<AuthState>(context, listen: false).getCurrentUser();
    Provider.of<ProfileState>(context, listen: false).refreshProfileData();
  }

  Uint8List markerIcon = Uint8List(4);
  List<mapLaunch.AvailableMap> availableMaps = [];

  asyncInits() async {
    markerIcon = await getBytesFromAsset('assets/loc_heart.png', 200);
    availableMaps = await mapLaunch.MapLauncher.installedMaps;
  }

  @override
  void initState() {
    super.initState();
    initialise();
    asyncInits();
  }

  final double _zoom = 10;

  final CameraPosition _initialPosition =
      const CameraPosition(target: LatLng(-33.9321, 18.8602), zoom: 9);
  final Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    final venueState = Provider.of<VenueState>(context);
    List<VenueModel> allVenues = venueState.allVenues;
    venueState.sortVenuesByCity();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Venues'),
        centerTitle: true,
      ),
      drawer: _drawer(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            onMapCreated: _onMapCreated,
            markers: generateMarkers(),
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

  Widget _drawer() {
    String userEmail = Provider.of<AuthState>(context).userEmail;
    String name = Provider.of<ProfileState>(context).profile.partner1.name;
    final venuesState = Provider.of<VenueState>(context);
    Set<String> cities = venuesState.availableCities;
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppColours.primary),
            accountName: Text(name),
            accountEmail: Text(userEmail),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.account_circle_outlined,
                size: 42,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          const ListTile(
            title: Text("Venues"),
            leading: Icon(Icons.warehouse_outlined),
          ),
          const Divider(),
          for (var city in cities) ...[
            ListTile(
              onTap: () {
                _goToCity(city);
                Navigator.of(context).pop();
              },
              title: Text(city),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ]
        ],
      ),
    );
  }

  Future<void> _goToCity(String city) async {
    LatLng latLng = const LatLng(-33.9321, 18.8602);
    if (city == 'Stellenbosch') {
      latLng = const LatLng(-33.9321, 18.8602);
    } else if (city == 'Franschhoek') {
      latLng = const LatLng(-33.8975, 19.1523);
    } else if (city == 'Robertson') {
      latLng = const LatLng(-33.8021, 19.8875);
    } else if (city == 'Paarl') {
      latLng = const LatLng(-33.7342, 18.9621);
    }
    GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, _zoom));
  }

  Set<Marker> generateMarkers() {
    Set<Marker> markers = {};
    final venuesState = Provider.of<VenueState>(context);
    List<VenueModel> venues = venuesState.allVenues;

    // venuesState.getPlaceId(
    //     LatLng(venues.first.latLng.latitude, venues.first.latLng.longitude));

    for (var venue in venues) {
      markers.add(Marker(
          markerId: MarkerId(venue.id),
          position: LatLng(venue.latLng.latitude, venue.latLng.longitude),
          icon: BitmapDescriptor.fromBytes(markerIcon),
          onTap: () async {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                builder: (context) {
                  return Container(
                    width: displayWidth(context),
                    height: displayHeight(context) * 0.65,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              venue.name,
                              style: const TextStyle(
                                  fontFamily: 'Roboto-Regular', fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          width: displayWidth(context),
                          height: displayHeight(context) * 0.5 + 40,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: 200,
                                child: Expanded(
                                  child: ListView(
                                    // scrollDirection: Axis.horizontal,
                                    children: [
                                      venue.photos.isNotEmpty
                                          ? SizedBox(
                                              height: 200,
                                              child: ListView.separated(
                                                  physics:
                                                      const PageScrollPhysics(),
                                                  separatorBuilder: (context,
                                                          index) =>
                                                      Divider(
                                                        indent: 10,
                                                        color: Theme.of(context)
                                                            .dividerColor,
                                                      ),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      venue.photos.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    Widget item =
                                                        FullScreenWidget(
                                                      child: Container(
                                                        width: 250,
                                                        height: 250,
                                                        color:
                                                            AppColours.primary,
                                                        child: Center(
                                                          child: Image.network(
                                                            venue.photos[index],
                                                            fit: BoxFit.fill,
                                                            scale: 0.5,
                                                          ),
                                                        ),
                                                      ),
                                                    );

                                                    return item;
                                                  }),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              displayWidth(context) * 0.2, 45),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)))),
                                      onPressed: () {
                                        launchUrl(Uri(
                                            scheme: 'tel', path: venue.cell));
                                      },
                                      child: const Text('Call'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              displayWidth(context) * 0.2, 45),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)))),
                                      onPressed: () {
                                        launchUrl(Uri.parse(venue.web));
                                      },
                                      child: const Text('Web'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              displayWidth(context) * 0.2, 45),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)))),
                                      onPressed: () {
                                        launchUrl(Uri(
                                            scheme: 'mailto',
                                            path: venue.email,
                                            query: 'Wedding Venue Query'));
                                      },
                                      child: const Text('Email'),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    RatingBarIndicator(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const Icon(
                                          Icons.favorite_outlined,
                                          color: AppColours.pink,
                                        );
                                      },
                                      unratedColor: AppColours.lightPink,
                                      rating: venue.rating,
                                      itemCount: 5,
                                      itemSize: 25,
                                      direction: Axis.horizontal,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Max guest   capacity: ',
                                  ),
                                  Text(
                                    venue.maxGuests.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      fixedSize:
                                          Size(displayWidth(context), 45),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)))),
                                  onPressed: () async {
                                    launchUrl(Uri.parse(
                                        "google.navigation:q=${venue.latLng.latitude},${venue.latLng.longitude}&mode=d"));
                                    if (await canLaunchUrl(Uri.parse(
                                        "google.navigation:q=${venue.latLng.latitude},${venue.latLng.longitude}&mode=d"))) {
                                      await launchUrl(Uri.parse(
                                          "google.navigation:q=${venue.latLng.latitude},${venue.latLng.longitude}&mode=d"));
                                    } else {
                                      throw 'Could not launch ${Uri.parse("google.navigation:q=${venue.latLng.latitude},${venue.latLng.longitude}&mode=d")}';
                                    }
                                  },
                                  child: const Text('Directions'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
          }));
    }

    return markers;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }
}
//
// class AddUser extends StatelessWidget {
//   final String fullName;
//   final String company;
//   final int age;
//
//   AddUser({required this.fullName, required this.company, required this.age});
//
//   @override
//   Widget build(BuildContext context) {
//     // Create a CollectionReference called users that references the firestore collection
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//     Future<void> addUser() {
//       // Call the user's CollectionReference to add a new user
//       return users
//           .add({
//             'full_name': fullName, // John Doe
//             'company': company, // Stokes and Sons
//             'age': age // 42
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     }
//
//     return TextButton(
//       onPressed: addUser,
//       child: Text(
//         "Add User",
//       ),
//     );
//   }
// }
//
// class GetUserName extends StatelessWidget {
//   final String documentId;
//
//   GetUserName(this.documentId);
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//
//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data =
//               snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//         }
//
//         return Text("loading");
//       },
//     );
//   }
// }

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