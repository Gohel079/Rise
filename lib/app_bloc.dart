import 'package:rxdart/rxdart.dart';

import 'base/bloc/base_bloc.dart';
import 'base/src_bloc.dart';

class AppBloc extends BasePageBloc {
  late BehaviorSubject<bool> refreshProfile;

  AppBloc() {
    refreshProfile = BehaviorSubject.seeded(true);
  }

  void updateProfile(){
    if(!refreshProfile.isClosed){
      refreshProfile.add(true);
    }
  }

  @override
  void dispose() {
    refreshProfile.close();
  }
}
