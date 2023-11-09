import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rise_and_grow/screens/created_meeting/created_meeting_screen.dart';
import 'package:rise_and_grow/screens/home/home_screen.dart';
import 'package:rise_and_grow/screens/outer_meeting/outer_meeting_screen.dart';
import 'package:rise_and_grow/screens/outer_meeting_approve/outer_meeting_approve_screen.dart';
import 'package:rise_and_grow/screens/set_meeting_date_&_time/set_meeting_date_and_time_screen.dart';

import '../../base/constants/app_colors.dart';
import '../../base/constants/app_images.dart';
import '../../base/constants/app_styles.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.icSplashLogo,
              height: 256,
            ),
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    navigateToOther();
  }

  void navigateToOther() async {
    await Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, SetMeetingDateAndTimeScreen.route());
    });
  }
}