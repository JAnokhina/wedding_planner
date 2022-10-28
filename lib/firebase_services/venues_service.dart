import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_models/venue_model.dart';
import 'package:http/http.dart' as http;

class VenuesService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _error = false;
  String _errorMessage = '';

  bool get error => _error;

  String get errorMessage => _errorMessage;
  String key = 'AIzaSyAKj3hHX5bDqPyrTdFfPp6GqiqfzDUHgMo';

  getVenues() async {
    List<VenueModel> allVenues = [];
    try {
      allVenues = await db.collection('venues').get().then((docs) {
        for (var doc in docs.docs) {
          allVenues.add(VenueModel.fromMap(doc.data(), doc.id));
        }

        return allVenues.toList();
      });
      return allVenues.toList();
    } catch (e) {
      print('Failed to get venues. Error: $e');
    }
    return allVenues.toList();
  }

  getPlaceId(double lat, double long) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$key'));
    if (response.statusCode == 200) {
      try {
        _error = false;
        return json.decode(response.body)['results'][0]['place_id'];
      } on Exception catch (e) {
        _error = true;
        _errorMessage = e.toString();
        throw Exception('Failed to fetch place details.');
      }
    } else {
      _error = true;
      _errorMessage = response.body;
      throw Exception('Failed to fetch Place details.');
    }
  }
}