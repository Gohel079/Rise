import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      Navigator.pushReplacement(context, LoginScreen.route());
    });
  }
}