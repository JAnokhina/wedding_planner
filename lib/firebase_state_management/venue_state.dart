import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wedding_planner/firebase_services/venues_service.dart';
import 'package:wedding_planner/locator.dart';

import '../firebase_models/venue_model.dart';

class VenueState extends ChangeNotifier {
  List<VenueModel> _allVenues = [];
  List<VenueModel> get allVenues => _allVenues;
  List<VenueModel> _venuesByCity = [];
  List<VenueModel> get venuesByCity => _venuesByCity;
  Set<String> _availableCities = {};
  Set<String> get availableCities => _availableCities;

  set allVenues(List<VenueModel> value) {
    _allVenues = value;
    notifyListeners();
  }

  set venuesByCity(List<VenueModel> value) {
    _venuesByCity = value;
    notifyListeners();
  }

  set availableCities(Set<String> value) {
    _availableCities = value;
    notifyListeners();
  }

  getPlaceId(LatLng latLng) async {
    await locator<VenuesService>()
        .getPlaceId(latLng.latitude, latLng.longitude);
  }

  sortVenuesByCity() {
    List<VenueModel> venues = allVenues.toList();
    List<VenueModel> sortedVenues = [];

    venues.sort((a, b) => a.address.city.compareTo(b.address.city));

    print('Sorted Venues:');

    for (var venue in venues) {
      availableCities.add(venue.address.city);

      print('${venue.address.city}, ${venue.name}');
    }
    print('Cities:: $availableCities');
  }

  refreshAllVenues() async {
    allVenues = await locator<VenuesService>().getVenues();
    print('Venues from State: ${allVenues.first.name}');
  }
}