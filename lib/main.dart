import 'package:ez_localization/ez_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rise_and_grow/base/constants/app_colors.dart';
import 'package:rise_and_grow/screens/splash/splash_screen.dart';

import 'app_bloc.dart';
import 'base/bloc/base_bloc_provider.dart';
import 'base/components/loader_overlay/ots.dart';
import 'base/components/screen_utils/flutter_screenutil.dart';
import 'base/constants/app_themes.dart';
import 'base/constants/app_widgets.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;

  ///Set Portrait
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: secondaryColor,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));



  runApp(BlocProvider<AppBloc>(initBloc: AppBloc(), child: const MyHomePage()));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() =>  _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {


  @override
  Widget build(BuildContext context) {
   return  OTS(
     child: EzLocalizationBuilder(
       delegate: const EzLocalizationDelegate(
           supportedLocales: [Locale('en')], locale: Locale("en")),
       builder: (BuildContext context,
           EzLocalizationDelegate ezLocalizationDelegate) {
         return ScreenUtilInit(
           designSize: const Size(390, 844),
           builder: () => MaterialApp(
             builder: (context, child) {
               return MediaQuery(
                   data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                   child: child!);
             },
             debugShowCheckedModeBanner: false,
             title: 'HITACHI',
             theme: normalTheme(context),
             home: const SplashScreen(),
             navigatorKey: navigatorKey,
             localizationsDelegates:
             ezLocalizationDelegate.localizationDelegates,
             supportedLocales: ezLocalizationDelegate.supportedLocales,
             localeResolutionCallback:
             ezLocalizationDelegate.localeResolutionCallback,
           ),
         );
       },
     ),
   );
  }



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
}


