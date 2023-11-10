import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rise_and_grow/screens/home/tab/home/home_tab.dart';
import 'package:rise_and_grow/screens/home/tab/profile/profile_tab.dart';
import 'package:rise_and_grow/screens/home/tab/settings/settings_tab.dart';

import '../../base/basePage.dart';
import '../../base/bloc/base_bloc.dart';
import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../../base/widgets/custom_page_route.dart';
import 'home_screen_bloc.dart';

class HomeScreen1 extends BasePage<HomeScreenBloc> {
  const HomeScreen1({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() {
    return _HomeScreen1State();
  }

  static Route<dynamic> route() {
    return CustomPageRoute(
        builder: (context) => const HomeScreen1());
  }

}

class _HomeScreen1State extends BasePageState<HomeScreen1,HomeScreenBloc> {

  HomeScreenBloc bloc = HomeScreenBloc();
  int _selectedIndex = 1;

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: _buildScreens()[_selectedIndex],
          bottomNavigationBar: _buildBottomNavBar()
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavBar() {
    return Container(
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
              child: Icon(CupertinoIcons.person_fill),
            ),
            icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(CupertinoIcons.person)
            ),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.home),
            ) ,
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.home_outlined),
            ),
            label: "Home",
            // backgroundColor: Colors.green
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.settings),
            ) ,
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.settings_outlined),
            ) ,
            label: "Settings",
            // backgroundColor: Colors.green
          ),
        ],

      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      ProfileTab(),
      HomeTab(
        // bottomNavigationBar: _buildBottomNavBar(),
      ),
      SettingsTab(),
    ];
  }

  @override
  HomeScreenBloc getBloc() {
    return bloc;
  }

}