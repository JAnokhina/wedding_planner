import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../firebase_models/profile_model.dart';

class ProfileService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addProfileDetails(ProfileModel profileData) async {
    try {
      db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          // .collection('Profile')
          // .doc('Wedding Date')
          .set(profileData.createMap(), SetOptions(merge: true))
          .catchError((error) => print("Failed to merge Profile data: $error"));
    } catch (e) {
      print("Failed to add profile data: $e");
    }
  }

  getProfileData() async {
    ProfileModel profile = ProfileModel(
        partner1: Partner(name: '', status: ''),
        partner2: Partner(name: '', status: ''),
        weddingDate: DateTime.now());
    try {
      await db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get()
          .then((doc) => {
                // profile = ProfileModel.fromMap(doc.data()!),
                profile = ProfileModel.fromMap(doc.data()!),
              });
      return profile;
    } catch (e) {
      print("Failed to get profile data: $e");
    }
    return profile;
  }

  // Future<void> addProfileDetails(ProfileModel profileData) async {
  //   try {
  //     db
  //         .collection('users')
  //         .doc(_auth.currentUser!.uid)
  //         .collection('Profile')
  //         .doc('Partner 1')
  //         .set({
  //       if (profileData.partner1.name.isNotEmpty)
  //         "name": profileData.partner1.name,
  //       if (profileData.partner1.status.isNotEmpty)
  //         "status": profileData.partner1.status,
  //     }, SetOptions(merge: true)).catchError(
  //             (error) => print("Failed to merge Profile data: $error"));
  //     db
  //         .collection('users')
  //         .doc(_auth.currentUser!.uid)
  //         .collection('Profile')
  //         .doc('Partner 2')
  //         .set({
  //       if (profileData.partner2.name.isNotEmpty)
  //         "name": profileData.partner2.name,
  //       if (profileData.partner2.status.isNotEmpty)
  //         "status": profileData.partner2.status,
  //     }, SetOptions(merge: true)).catchError(
  //             (error) => print("Failed to merge Profile data: $error"));
  //     db
  //         .collection('users')
  //         .doc(_auth.currentUser!.uid)
  //         .collection('Profile')
  //         .doc('Wedding Date')
  //         .set({
  //       if (profileData.weddingDate != null)
  //         "weddingDate": profileData.weddingDate
  //     }, SetOptions(merge: true)).catchError(
  //             (error) => print("Failed to merge Profile data: $error"));
  //   } catch (e) {
  //     print("Failed to add user: $e");
  //   }
  // }

  // Future<ProfileModel> getProfileData() async {
  //   // this doesn't work. it's not getting the DateTime value but giving error.
  //   ProfileModel profileData = ProfileModel(
  //       partner1: Partner(name: '', status: ''),
  //       partner2: Partner(name: '', status: ''),
  //       weddingDate: DateTime.now());
  //   String name1 = '';
  //   String name2 = '';
  //   String status1 = '';
  //   String status2 = '';
  //   DateTime weddingTime = DateTime.now();
  //
  //   try {
  //     await db
  //         .collection('users')
  //         .doc(_auth.currentUser!.uid)
  //         .collection('Profile')
  //         .doc('Partner 1')
  //         .get()
  //         .then((DocumentSnapshot doc) {
  //       print('Doc Data ${doc.get('name')}');
  //       name1 = doc.get('name');
  //       print('Assigned : $name1');
  //       return profileData(ProfileModel(
  //           partner1: Partner(name: name1, status: ''),
  //           partner2: Partner(name: '', status: ''),
  //           weddingDate: DateTime.now()));
  //     });
  //     // print('WEDDING DATE TIME');
  //     // print(weddingTime);
  //     // return weddingTime;
  //   } catch (e) {
  //     print("Failed to add user: $e");
  //   }
  //   return weddingTime.toDate();
  // }

  // Future<DateTime> getWeddingDate() async {
  //   // this doesn't work. it's not getting the DateTime value but giving error.
  //   Timestamp weddingTime =
  //       Timestamp(DateTime.now().microsecondsSinceEpoch ~/ (1000 * 1000), 0);
  //   try {
  //     await db
  //         .collection('users')
  //         .doc(_auth.currentUser!.uid)
  //         .collection('Profile')
  //         .doc('Wedding Date')
  //         .get()
  //         .then((DocumentSnapshot doc) {
  //       print('Doc Data ${doc.get('weddingDate')}');
  //       weddingTime = doc.get('weddingDate');
  //       print('Assigned : $weddingTime');
  //       return weddingTime.toDate();
  //     });
  //     // print('WEDDING DATE TIME');
  //     // print(weddingTime);
  //     // return weddingTime;
  //   } catch (e) {
  //     print("Failed to add user: $e");
  //   }
  //   return weddingTime.toDate();
  // }
}