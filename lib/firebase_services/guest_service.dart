import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedding_planner/firebase_models/guest_model.dart';

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

  addGuests({required List<GuestModel> guests}) async {
    try {
      for (var guest in guests) {
        await db
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .collection('Guests')
            .add(guest.toMap());
      }
    } catch (e) {
      print("Failed to add guest: $e");
    }
  }

  fetchGuests() async {
    List<GuestModel> allGuests = [];
    try {
      allGuests = await db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Guests')
          .get()
          .then((guests) {
        for (var guest in guests.docs) {
          allGuests.add(GuestModel.fromMap(guest.data(), guest.id));
        }
        return allGuests.toList();
      });
      return allGuests.toList();
    } catch (e) {
      print('Failed to fetch guests. Error: $e');
    }
    return allGuests.toList();
  }
}