import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/loginWithEmailResponse.dart';
import 'package:rise_and_grow/remote/repository/auth_repository.dart';

import '../../base/constants/app_widgets.dart';

class LoginScreenBloc extends BasePageBloc {

  void doVerifyUser(Map? data, Function(LoginWithEmailResponse) onSuccess) {
    showLoadingDialog();
    apiVerifyUser(data, (response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar(error.message ?? "");
    });
  }
}