import 'package:flutter01/redux/profile/profileReducer.dart';
import 'package:meta/meta.dart';

@immutable
class GetProfileAction {
  final ProfileState profileState;

  GetProfileAction(this.profileState);
}

//action
getProfileAction(Map<String, dynamic> profile) {
  //logic
  return GetProfileAction(ProfileState(profile: profile));
}
