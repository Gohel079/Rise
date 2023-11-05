import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/pdf_view/pdf_view_screen_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';

class PDFViewerScreen  extends BasePage<PDFViewScreenBloc> {
  String? pdfUrl;
   PDFViewerScreen({this.pdfUrl,super.key});


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _PDFViewerScreenState();
  }

  static Route<dynamic> route(String s) {
    return CustomPageRoute(
        builder: (context) =>  PDFViewerScreen(pdfUrl: s,));
  }
}

class _PDFViewerScreenState extends BasePageState<PDFViewerScreen,PDFViewScreenBloc> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  PDFViewScreenBloc bloc = PDFViewScreenBloc();
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 19,
        titleSpacing: 30.w,

        title: Row(children: [

          InkWell(onTap: (){
            Navigator.pop(context);
          }, child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(AppImages.icPrev,height: 14.h),
          )),

          SizedBox(width: 10.w,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text('PDF Viewer',
                style: styleMedium2.copyWith(
                  color: white,
                  fontWeight: FontWeight.w600,
                )),
          ),

        ],) ,
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
      ),
      body: Center(
        child: SfPdfViewer.network(
          widget.pdfUrl ?? "",
          key: _pdfViewerKey,
        ),
      ),
    );
  }

  @override
  PDFViewScreenBloc getBloc() {
   return bloc;
  }
}
