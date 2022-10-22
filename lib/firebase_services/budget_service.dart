import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedding_planner/firebase_models/budget_model.dart';

class BudgetService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> setBudgetDetails(double total) async {
    try {
      db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Budget')
          .doc('Budget Breakdown')
          .set(<String, dynamic>{
        'total': total,
        'venueAndFood': (total * 0.4),
        'photos': (total * 0.15),
        'music': (total * 0.1),
        'flowers': (total * 0.1),
        'decor': (total * 0.1),
        'attire': (total * 0.05),
        'transport': (total * 0.03),
        'stationary': (total * 0.02),
        'favours': (total * 0.02),
        'cake': (total * 0.02)
      }, SetOptions(merge: true)).catchError(
              (error) => print("Failed to merge Budget data: $error"));
    } catch (e) {
      print("Failed to add budget data: $e");
    }
  }

  getBudgetData() async {
    BudgetModel budget = BudgetModel(
        total: 0,
        venueAndFood: 0,
        photos: 0,
        music: 0,
        flowers: 0,
        decor: 0,
        attire: 0,
        transport: 0,
        stationary: 0,
        favours: 0,
        cake: 0);
    try {
      await db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('Budget')
          .doc('Budget Breakdown')
          .get()
          .then((doc) => {
                budget = BudgetModel.fromMap(doc.data()!),
              });
      return budget;
    } catch (e) {
      print("Failed to get budget data: $e");
    }
    return budget;
  }
}