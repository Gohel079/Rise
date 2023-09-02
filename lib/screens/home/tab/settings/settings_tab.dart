import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/screens/home/tab/settings/settings_tab_bloc.dart';

class SettingsTab extends BasePage<SettingsTabBloc> {


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _settingsTabState();
  }

}

class _settingsTabState  extends BasePageState<SettingsTab,SettingsTabBloc>{

  SettingsTabBloc bloc = SettingsTabBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return Container(color: Colors.red,);
  }

  @override
  SettingsTabBloc getBloc() {
    return bloc;
  }
}

