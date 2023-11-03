import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/home/tab/settings/settings_tab_bloc.dart';

import '../../../../base/constants/app_colors.dart';
import '../../../../base/constants/app_images.dart';
import '../../../../base/constants/app_styles.dart';
import '../../../notification/notification_screen.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [


          Text('Setting',
              style: styleMedium2.copyWith(
                color: white,
                fontWeight: FontWeight.w600,
              )),

        ],),
        automaticallyImplyLeading: true,
        backgroundColor: secondaryColor,
        actions:   [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SvgPicture.asset(
                AppImages.icSearch,
                color: white,
                height: 24.h,
                width: 24.w,
              ),
              SizedBox(width: 16.w,),
              InkWell(
                onTap: (){
                  PersistentNavBarNavigator
                      .pushNewScreen(context, screen: const NotificationScreen(),
                      withNavBar: false);
                },
                child: SvgPicture.asset(AppImages.icNotification,
                  height: 24.h,
                  width: 24.w,),
              ),
              SizedBox(width: 10.w,),
            ],)
        ],),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [



            SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                title: Text('General  Setting',
                    style: styleMedium2.copyWith(
                      color: lightBlack,
                      fontWeight: FontWeight.w500,
                    )),
                trailing:  SvgPicture.asset(
                  AppImages.icRight,
                  height: 30.h,
                ),
              ),
            ),
            const Divider(height: 0.5,thickness: 1,color: divider,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                title: Text('Notification Settings',
                    style: styleMedium2.copyWith(
                      color: lightBlack,
                      fontWeight: FontWeight.w500,
                    )),
                trailing:  SvgPicture.asset(
                  AppImages.icRight,
                  height: 30.h,
                ),
              ),
            ),
            const Divider(height: 0.5,thickness: 1,color: divider,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(  
                title: Text('Password',
                    style: styleMedium2.copyWith(
                      color: lightBlack,
                      fontWeight: FontWeight.w500,
                    )),
                trailing:  SvgPicture.asset(
                  AppImages.icRight,
                  height: 30.h,
                ),
              ),
            ),
            Divider(height: 1,color: divider,),


          ],
        ),),
    );
  }

  @override
  SettingsTabBloc getBloc() {
    return bloc;
  }
}

