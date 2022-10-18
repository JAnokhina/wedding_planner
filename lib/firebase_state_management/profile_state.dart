import 'package:flutter/cupertino.dart';
import 'package:wedding_planner/firebase_services/profile_service.dart';
import '../firebase_models/profile_model.dart';
import '../locator.dart';

class ProfileState extends ChangeNotifier {
  ProfileModel _profile = ProfileModel(
      partner1: Partner(name: '', status: ''),
      partner2: Partner(name: '', status: ''),
      weddingDate: DateTime.now());

  ProfileModel get profile => _profile;

  set profile(ProfileModel value) {
    _profile = value;
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