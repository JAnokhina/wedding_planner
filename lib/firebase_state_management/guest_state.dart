import 'package:flutter/material.dart';
import 'package:wedding_planner/firebase_services/guest_service.dart';
import 'package:wedding_planner/locator.dart';
import '../firebase_models/guest_model.dart';

class GuestState extends ChangeNotifier {
  List<GuestModel> _allGuests = [];
  List<GuestModel> get allGuests => _allGuests;

  set allGuests(List<GuestModel> value) {
    _allGuests = value;
    notifyListeners();
  }

  refreshAllGuests() async {
    allGuests = await locator<GuestService>().fetchGuests();
  }
}