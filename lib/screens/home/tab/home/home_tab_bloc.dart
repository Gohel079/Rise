import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/constants/app_widgets.dart';
import '../../../../remote/model/get_visitor_list_response_model.dart' as GetVisitor;

import '../../../../remote/repository/auth_repository.dart';

class HomeTabBloc extends BasePageBloc {


  late BehaviorSubject<List<GetVisitor.Datum>> getVisitorList;


  List<GetVisitor.Datum>? originalVisitorList = [];


  HomeTabBloc(){
    getVisitorList = BehaviorSubject<List<GetVisitor.Datum>>.seeded([]);
  }


  void getVisitorRegList(Map? data,Function(GetVisitor.GetVisitorResponseModel) onSuccess) {
    showLoadingDialog();
    apiGetVisitorList(data,(response) {
      hideLoadingDialog();
      onSuccess.call(response);
    }, (error) {
      hideLoadingDialog();
      showMessageBar('ERROR ${error.message ?? ""}');
    });
  }

}