import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GuestService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addGuest(
      {required String name,
      required String email,
      required String cell,
      required String relationship,
      bool rsvpStatus = false}) async {
    try {
      db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Guests')
          .add({
        'name': name,
        'email': email,
        'cell': cell,
        'relationship': relationship,
        'rsvpStatus': rsvpStatus
      });
    } catch (e) {
      print("Failed to add guest: $e");
    }
  }
}