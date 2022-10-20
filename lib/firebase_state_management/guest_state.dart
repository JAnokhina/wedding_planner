import 'package:flutter/material.dart';
import 'package:wedding_planner/firebase_services/guest_service.dart';
import 'package:wedding_planner/locator.dart';
import '../firebase_models/guest_model.dart';

class GuestState extends ChangeNotifier {
  List<GuestListsModel> _allGuests = [];
  List<GuestListsModel> get allGuests => _allGuests;

  set allGuests(List<GuestListsModel> value) {
    _allGuests = value;
    notifyListeners();
  }

  addGuests({required List<GuestModel> guests}) async {
    await locator<GuestService>().addGuests(guests: guests);
  }

  setGuestRsvp(
      {required String docId,
      required String guestKey,
      required bool status,
      required String guestId}) async {
    await locator<GuestService>().setGuestRsvpStatus(
        docId: docId, status: status, guestId: guestId, guestKey: guestKey);
  }

  addGuestsssss({required List<GuestModel> guests}) async {
    await locator<GuestService>().addGuestsssss(guests: guests);
  }

  refreshAllGuests() async {
    allGuests = await locator<GuestService>().fetchGuests();
  }
}