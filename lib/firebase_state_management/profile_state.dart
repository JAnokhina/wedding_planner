import 'package:flutter/cupertino.dart';
import 'package:wedding_planner/firebase_services/profile_service.dart';
import 'package:wedding_planner/models/profile_model.dart';

import '../locator.dart';

class ProfileState extends ChangeNotifier {
  Partner _partner1 = Partner(name: '', status: '');
  Partner _partner2 = Partner(name: '', status: '');
  ProfileModel _profile = ProfileModel(
      partner1: Partner(name: '', status: ''),
      partner2: Partner(name: '', status: ''),
      weddingDate: DateTime.now());
  DateTime _weddingDate = DateTime.now();

  Partner get partner1 => _partner1;
  Partner get partner2 => _partner2;
  ProfileModel get profile => _profile;
  DateTime get weddingDate => _weddingDate;

  set partner1(Partner value) {
    _partner1 = value;
    notifyListeners();
  }

  set profile(ProfileModel value) {
    _profile = value;
    notifyListeners();
  }

  set partner2(Partner value) {
    _partner2 = value;
    notifyListeners();
  }

  set weddingDate(DateTime value) {
    _weddingDate = value;
    notifyListeners();
  }

  editProfileData(ProfileModel profileData) async {
    await locator<ProfileService>().addProfileDetails(profileData);
  }

  refreshProfileData() async {
    profile = await locator<ProfileService>().getProfileData();
  }

  // refreshWeddingDate() async {
  //   weddingDate = await locator<ProfileService>().getWeddingDate();
  //   print('State time: $weddingDate');
  // }
}