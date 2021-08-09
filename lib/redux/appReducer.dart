import 'package:flutter01/redux/profile/profileReducer.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ProfileState profileState;

  AppState({required this.profileState});

  factory AppState.initial() {
    return AppState(profileState: ProfileState());
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(profileState: profileReducer(state.profileState, action));
}
