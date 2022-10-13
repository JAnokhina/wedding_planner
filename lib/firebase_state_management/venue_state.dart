import 'package:flutter/cupertino.dart';
import 'package:wedding_planner/firebase_services/venues_service.dart';
import 'package:wedding_planner/locator.dart';

import '../firebase_models/venue_model.dart';

class VenueState extends ChangeNotifier {
  List<VenueModel> _allVenues = [];
  List<VenueModel> get allVenues => _allVenues;

  set allVenues(List<VenueModel> value) {
    _allVenues = value;
    notifyListeners();
  }

  refreshAllVenues() async {
    allVenues = await locator<VenuesService>().getVenues();
    print('Venues from State: ${allVenues.first.name}');
  }
}