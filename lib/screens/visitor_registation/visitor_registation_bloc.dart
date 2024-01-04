import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/remote/model/get_visitor_list_response_model.dart' as GetVisitor;
import 'package:rise_and_grow/remote/repository/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/constants/app_widgets.dart';

class VisitorRegistrationBloc extends BasePageBloc {

  late BehaviorSubject<List<GetVisitor.Datum>> getVisitorList;


  List<GetVisitor.Datum>? originalVisitorList = [];


  VisitorRegistrationBloc(){
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


  void onSearch(String text) {
    List<GetVisitor.Datum>? searchedList = [];

    if(text.isNotEmpty){

      searchedList = originalVisitorList?.where((element) {
        if (element.reqRequestMap != null) {
          return element.reqRequestMap?.any((visitor) {
            if (visitor.reqVisitorMap != null) {
              return visitor.reqVisitorMap?.vFirstName?.toString().toLowerCase().contains(text.toLowerCase()) == true;
            }
            return false;
          }) ?? false;
        }
        return false;
      }).toList();
    } else {
      searchedList = originalVisitorList;
    }

    if (!getVisitorList.isClosed) {
      getVisitorList.add(searchedList ?? []);
    }


  }

  @override
  void dispose() {
    getVisitorList.close();
    super.dispose();
  }


}