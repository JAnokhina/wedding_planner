import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VenueModel {
  String id;
  String name;
  String cell;
  String email;
  String web;
  int maxGuests;
  double rating;
  int pricepp;
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
    required this.pricepp,
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
        pricepp = firestoreMap['pricepp'] ?? 0,
        photos = firestoreMap['photos'].map((e) => e.toString()).toList(),
        latLng = LatLng(
          firestoreMap['latLong'].latitude,
          firestoreMap['latLong'].longitude,
        ),
        address = Address.fromMap(firestoreMap['address']);

  Map<String, dynamic> createMap() {
    return {
      if (name.isNotEmpty) 'name': name,
      if (cell.isNotEmpty) 'cell': cell,
      if (email.isNotEmpty) 'email': email,
      if (web.isNotEmpty) 'web': web,
      if (maxGuests != 0) 'maxGuests': maxGuests,
      if (rating != 0) 'rating': rating,
      if (pricepp != 0) 'pricepp': pricepp,
      if (photos.isNotEmpty) 'photos': photos,
      if (latLng.latitude != 0 && latLng.longitude != 0)
        'latLong': GeoPoint(latLng.latitude, latLng.longitude),
      'address': address.createMap(),
    };
  }
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

  Map<String, dynamic> createMap() {
    return {
      if (street.isNotEmpty) 'street': street,
      if (city.isNotEmpty) 'city': city,
      if (postalCode.isNotEmpty) 'postalCode': postalCode,
    };
  }
}

class SuggestionModel {
  String id;
  String description;

  SuggestionModel({required this.description, required this.id});
}