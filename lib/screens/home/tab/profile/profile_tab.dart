import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/screens/home/tab/profile/profile_tab_bloc.dart';
import 'package:rise_and_grow/screens/login/login_screen.dart';
import 'package:rise_and_grow/screens/notification/notification_screen.dart';
import 'package:rise_and_grow/utils/shared_pref_utils.dart';

import '../../../../base/constants/app_colors.dart';
import '../../../../base/constants/app_images.dart';
import '../../../../base/constants/app_styles.dart';
import '../../../../base/widgets/custom_page_route.dart';
import '../../../../base/widgets/image_view.dart';

class ProfileTab extends BasePage<ProfileTabBloc> {


  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _profileTabState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => ProfileTab());
  }

}

class _profileTabState  extends BasePageState<ProfileTab,ProfileTabBloc>
{
  ProfileTabBloc bloc = ProfileTabBloc();
  @override
  Widget buildWidget(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Row(children: [


         Text('Profile',
             style: styleMedium2.copyWith(
               color: white,
               fontWeight: FontWeight.w600,
             )),

       ],),
       automaticallyImplyLeading: true,
       backgroundColor: secondaryColor,
       actions:   [

        /* Row(
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

           ],)*/
       ],),
     body: Container(
       color: Colors.white,
       child: Column(
         children: [
           
            SizedBox(height: 20.h,),

             CircleAvatar(backgroundImage:
            NetworkImage(getProfileImage().toString()),radius: 50,),

            SizedBox(height: 10.h,),

            Text(getEmployeeName().toString(),
                style: styleMedium3.copyWith(
                  color: lightBlack,
                  fontWeight: FontWeight.w600,
                )),


          /*  SizedBox(height: 20.h,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                title: Text('Account',
                    style: styleMedium2.copyWith(
                      color: lightBlack,
                      fontWeight: FontWeight.w500,
                    )),
                trailing:  SvgPicture.asset(
                  AppImages.icRight,
                ),
              ),
            ),
            const Divider(height: 0.5,thickness: 1,color: divider,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                title: Text('Edit Profile',
                    style: styleMedium2.copyWith(
                      color: lightBlack,
                      fontWeight: FontWeight.w500,
                    )),
                trailing:  SvgPicture.asset(
                  AppImages.icRight,
                ),
              ),
            ),
            const Divider(height: 1,color: divider,),

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
                ),
              ),
            ),
            Divider(height: 1,color: divider,),*/

           InkWell(onTap: (){
             setLogin(false);
             // Navigator.of(context).pushAndRemoveUntil(
             //   CupertinoPageRoute(
             //     builder: (BuildContext context) {
             //       return LoginScreen();
             //     },
             //   ),
             //       (_) => false,
             // );

             // Navigator.pop(context);
             showLogoutAlertDialog(context);
             // PersistentNavBarNavigator.pushNewScreen(context, screen: LoginScreen(),withNavBar: false);
           },
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: ListTile(
                 title: Text('Log Out',
                     style: styleMedium2.copyWith(
                       color: lightBlack,
                       fontWeight: FontWeight.w500,
                     )),
                 trailing:  SvgPicture.asset(
                   AppImages.icRight,
                 ),
               ),
             ),
           ),


         ],
       ),),
   );
  }

  @override
  ProfileTabBloc getBloc() {
  return bloc;
  }

  // Function to show the alert dialog
  void showLogoutAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('Logout',
              style: styleMedium2.copyWith(
            color: lightBlack,
            fontWeight: FontWeight.w600,
          )),
          content:  Text('Are you sure you want to log out?',
              style: styleMedium1.copyWith(
            color: lightBlack,
            fontWeight: FontWeight.w500,
          )),
          actions: [
            TextButton(
              onPressed: () {

                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: styleMedium2.copyWith(
                color: lightBlack,
                fontWeight: FontWeight.w500,
              )),
            ),
            TextButton(
              onPressed: () {

                Navigator.of(context).pop(); // Close the alert dialog
                PersistentNavBarNavigator.pushNewScreen(context, screen: LoginScreen(),withNavBar: false);
              },
              child: Text('Yes',
                  style: styleMedium2.copyWith(
                color: lightBlack,
                fontWeight: FontWeight.w500,
              )),
            ),
          ],
        );
      },
    );
  }

}

