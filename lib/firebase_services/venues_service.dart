import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_models/venue_model.dart';

class VenuesService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getVenues() async {
    List<VenueModel> allVenues = [];
    try {
      allVenues = await db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Venues')
          .get()
          .then((docs) {
        for (var doc in docs.docs) {
          allVenues.add(VenueModel.fromMap(doc.data()));
        }
        return allVenues;
      });
      return allVenues;
    } catch (e) {
      print('Failed to get venues. Error: $e');
    }
    return allVenues;
  }
}