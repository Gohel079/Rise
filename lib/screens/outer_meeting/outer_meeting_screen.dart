import 'package:flutter/cupertino.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/screens/outer_meeting/outer_meeting_bloc.dart';

import '../../base/bloc/base_bloc.dart';
import '../../base/widgets/custom_page_route.dart';

class OuterMeetingScreen extends BasePage<OuterMeetingBloc>{
  const OuterMeetingScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _outerMeetingState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const OuterMeetingScreen());
  }

}

class _outerMeetingState extends BasePageState<OuterMeetingScreen,OuterMeetingBloc>{
  OuterMeetingBloc bloc = OuterMeetingBloc();

  @override
  Widget buildWidget(BuildContext context) {
    // TODO: implement buildWidget
    throw UnimplementedError();
  }

  @override
  OuterMeetingBloc getBloc() {
    return bloc;
  }

}