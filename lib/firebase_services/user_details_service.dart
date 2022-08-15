import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final String? fullName;
  final String? status;
  final String? partnerName;
  final String? partnerStatus;
  final DateTime? weddingDate;

  UserService({
    this.fullName,
    this.status,
    this.partnerName,
    this.partnerStatus,
    this.weddingDate,
  });

  // factory UserService.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return UserService(
  //       fullName: data?['fullName'],
  //       status: data?['status'],
  //       partnerName: data?['partnerName'],
  //       partnerStatus: data?['partnerStatus'],
  //       weddingDate: data?['weddingDate']);
  // }
  // Map<String, dynamic> toFirestore() {
  //   return {
  //     if(fullName != null) "name" : fullName,
  //     if(status != null) "status": status,
  //     if(partnerName != null) "partnerName": partnerName,
  //     if(partnerStatus != null) "partnerStatus": partnerStatus,
  //     if(weddingDate != null) "weddingDate": weddingDate
  //   }
  // }

  // Create a CollectionReference called users that references the firestore collection

  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addProfileDetails() async {
    try {
      db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Profile')
          .doc('Partner 1')
          .set({
        if (fullName != null) "name": fullName,
        if (status != null) "status": status,
      }, SetOptions(merge: true)).catchError(
              (error) => print("Failed to merge Profile data: $error"));
      db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Profile')
          .doc('Partner 2')
          .set({
        if (partnerName != null) "partnerName": partnerName,
        if (partnerStatus != null) "partnerStatus": partnerStatus,
      }, SetOptions(merge: true)).catchError(
              (error) => print("Failed to merge Profile data: $error"));
      db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Profile')
          .doc('Wedding Date')
          .set({
        if (weddingDate != null) "weddingDate": weddingDate
      }, SetOptions(merge: true)).catchError(
              (error) => print("Failed to merge Profile data: $error"));
    } catch (e) {
      print("Failed to add user: $e");
    }
  }

  // Future<void> getProfileDetails() async {
  //   try db.collection('users')
  //       .doc(_auth.currentUser!.uid)
  //       .collection('Profile')
  //       .doc('Partner 1').get()
  // }
}