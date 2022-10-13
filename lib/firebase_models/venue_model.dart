import 'package:google_maps_flutter/google_maps_flutter.dart';

class VenueModel {
  String name;
  String cell;
  String email;
  String web;
  int maxGuests;
  LatLng latLng;

  VenueModel({
    required this.name,
    required this.cell,
    required this.email,
    required this.web,
    required this.maxGuests,
    required this.latLng,
  });

  VenueModel.fromMap(Map<String, dynamic> firestoreMap)
      : name = firestoreMap['name'],
        cell = firestoreMap['cell'],
        email = firestoreMap['email'],
        web = firestoreMap['web'],
        maxGuests = firestoreMap['maxGuests'],
        latLng = LatLng(
          firestoreMap['latLong'].latitude,
          firestoreMap['latLong'].longitude,
        );
}