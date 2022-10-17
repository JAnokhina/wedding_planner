import 'package:google_maps_flutter/google_maps_flutter.dart';

class VenueModel {
  String id;
  String name;
  String cell;
  String email;
  String web;
  int maxGuests;
  double rating;
  LatLng latLng;
  Address address;
  List<dynamic> photos;

  VenueModel({
    required this.id,
    required this.name,
    required this.cell,
    required this.email,
    required this.web,
    required this.maxGuests,
    required this.latLng,
    required this.rating,
    required this.address,
    required this.photos,
  });

  VenueModel.fromMap(Map<String, dynamic> firestoreMap, String docId)
      : id = docId,
        name = firestoreMap['name'] ?? '',
        cell = firestoreMap['cell'] ?? '',
        email = firestoreMap['email'] ?? '',
        web = firestoreMap['web'] ?? '',
        maxGuests = firestoreMap['maxGuests'] ?? 0,
        rating = firestoreMap['rating'] ?? 0,
        photos = firestoreMap['photos'].map((e) => e.toString()).toList(),
        latLng = LatLng(
          firestoreMap['latLong'].latitude,
          firestoreMap['latLong'].longitude,
        ),
        address = Address.fromMap(firestoreMap['address']);
}

class Address {
  String street;
  String city;
  String postalCode;

  Address({
    required this.street,
    required this.city,
    required this.postalCode,
  });

  Address.fromMap(Map<String, dynamic> firestoreMap)
      : street = firestoreMap['street'],
        city = firestoreMap['city'],
        postalCode = firestoreMap['postalCode'];
}

class SuggestionModel {
  String id;
  String description;

  SuggestionModel({required this.description, required this.id});
}