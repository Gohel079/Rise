import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:rise_and_grow/base/basePage.dart';
import 'package:rise_and_grow/base/bloc/base_bloc.dart';
import 'package:rise_and_grow/base/components/screen_utils/flutter_screenutil.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/screens/home/home_screen_bloc.dart';
import 'package:rise_and_grow/screens/home/tab/home/home_tab.dart';
import 'package:rise_and_grow/screens/home/tab/profile/profile_tab.dart';
import 'package:rise_and_grow/screens/home/tab/settings/settings_tab.dart';

import '../../base/constants/app_constant.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';
import '../../base/widgets/image_view.dart';
import '../../utils/common_utils.dart';

class HomeScreen extends BasePage<HomeScreenBloc> {
  const HomeScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
   return _HomeScreenState();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const HomeScreen());
  }

}

class _HomeScreenState extends BasePageState<HomeScreen,HomeScreenBloc> {

  HomeScreenBloc bloc = HomeScreenBloc();
  int _selectedIndex = 0;

  PersistentTabController? _controller;
  int? selectedIndex;

 /* final List<Widget> _widgetOptions = <Widget>[
    ProfileTab(),
    HomeTab(),
    SettingsTab(),
  ];*/


  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
  }
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(body:
    PersistentTabView(
      context,
      controller: _controller,
      navBarHeight: 60,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: white,
        // onWillPop: (p0) async {
        //   await showDialog(
        //     context: context,
        //     useSafeArea: true,
        //     builder: (final p0) => Container(
        //       height: 50,
        //       width: 50,
        //       color: Colors.white,
        //       child: ElevatedButton(
        //         child: const Text("Close"),
        //         onPressed: () {
        //           Navigator.pop(p0);
        //         },
        //       ),
        //     ),
        //   );
        //   return false;
        // },
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      // popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.all,
      decoration: const NavBarDecoration(border:
      Border(top: BorderSide(color: darkGrayTextColor,width: 1))),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
        onItemSelected: (final index) {
          setState(() {
            _controller?.index = index;
          });
        }
    ),);









     /* Scaffold(
      appBar: AppBar(
        title: Row(children: [

           const CircleAvatar(
             backgroundColor: Colors.transparent,
             maxRadius: 25,
             minRadius: 24,
             backgroundImage: AssetImage(AppImages.profileDP),
           ),
          SizedBox(width: 10.w,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Text('Good Morning 🖐',
                style: styleSmall3.copyWith(
                  color: white,
                  fontWeight: FontWeight.w600,
                )),

            SizedBox(height: 3.h,),
            Text('Pradeep Patel',
                style: styleMedium2.copyWith(
                  color: white,
                  fontWeight: FontWeight.w700,
                )),

          ],)
        ],),

        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        actions:   [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            const Icon(Icons.search,color: white,size: 27,),
            SizedBox(width: 13.w,),
            const ImageView(image: AppImages.notificationImage,
                imageType: ImageType.asset),
            SizedBox(width: 10.w,),
          ],)
      ],),
    body: _widgetOptions.elementAt(_selectedIndex)
    ,bottomNavigationBar: Container(
      decoration: const BoxDecoration(
          border: Border(top:
          BorderSide(color: lightGray, width: 1.5))),
      child: BottomNavigationBar(
        iconSize: 30,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedLabelStyle: styleMedium1.copyWith(
            fontWeight: FontWeight.w600),
        unselectedLabelStyle: styleMedium1.copyWith(
            fontWeight: FontWeight.w600) ,
        selectedItemColor: secondaryColor,
        selectedIconTheme: const IconThemeData(color: secondaryColor),
        unselectedIconTheme:  const IconThemeData(color: darkGrayTextColor),
        items:  const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.all(4.0),
              child: ImageIcon(AssetImage(AppImages.imgFillProfile)),
            ),
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(AppImages.imgProfileBlank))),
              label: "Profile",
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.all(4.0),
              child: ImageIcon(AssetImage(AppImages.imgHome)),
            ) ,
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(AppImages.imgHomeBlank)),
              ),
              label: "Home",
              // backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.all(4.0),
              child: ImageIcon(AssetImage(AppImages.imgSettings)),
            ) ,
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: ImageIcon(AssetImage(AppImages.imgSettings)),
              ) ,
              label: "Settings",
              // backgroundColor: Colors.green
          ),
        ],

      ),
    ),);*/
  }

  List<Widget> _buildScreens() {
    return [
      ProfileTab(),
      HomeTab(),
      SettingsTab(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [

      PersistentBottomNavBarItem(
        textStyle:  styleSmall4.copyWith(
            fontWeight: FontWeight.w600),
        icon: const Icon(CupertinoIcons.person_fill),
        inactiveIcon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: secondaryColor,
        inactiveColorPrimary: darkGrayTextColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        textStyle:  styleSmall4.copyWith(
            fontWeight: FontWeight.w600),
        inactiveIcon: const Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: secondaryColor,
        inactiveColorPrimary: darkGrayTextColor,
      ),
      PersistentBottomNavBarItem(
        textStyle:  styleSmall4.copyWith(
          fontWeight: FontWeight.w600),
        icon: const Icon(Icons.settings),
        inactiveIcon: const Icon(Icons.settings_outlined),
        title: ("Settings"),

        activeColorPrimary: secondaryColor,
        inactiveColorPrimary:darkGrayTextColor,
      ),
     /* PersistentBottomNavBarItem(
        contentPadding: 6.0,
          activeColorPrimary: secondaryColor,
          inactiveColorPrimary: lightBlack,
        title:  "Profile" ,
        inactiveIcon:  const ImageIcon(AssetImage(AppImages.imgProfileBlank)) ,
          icon: const ImageIcon(AssetImage(AppImages.imgFillProfile))),
      PersistentBottomNavBarItem(
          activeColorPrimary: secondaryColor,
        inactiveColorPrimary: lightBlack,
        title:  "Home" ,
        inactiveIcon:  const ImageIcon(AssetImage(AppImages.imgHomeBlank)) ,
          icon: const  ImageIcon(AssetImage(AppImages.imgHome))),
      PersistentBottomNavBarItem(
        iconSize: 40,

          activeColorPrimary: secondaryColor,
          inactiveColorPrimary: lightBlack,
        title:  "Settings" ,
        inactiveIcon:  const ImageIcon(AssetImage(AppImages.imgSettings)) ,
          icon:  ImageIcon(AssetImage(AppImages.imgSettings)))*/
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  HomeScreenBloc getBloc() {
    return bloc;
  }


  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",style: TextStyle(color: Colors.black),),
      onPressed: () {
        // return true;
      },
    );

    Widget cancelButton = TextButton(
      child: const Text("Cancel",style:
      TextStyle(color: Colors.black)),
      onPressed: () {
        return;
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("CLOSE"),
      content: Text("Are sure want exit?"),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}