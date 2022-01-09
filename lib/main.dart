import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/app/app.locator.dart';
// ignore: unused_import
import 'package:parkparty/services/localstorage_service.dart';
// ignore: unused_import
import 'package:parkparty/ui/bottomnavbar/navigation_view.dart';
import 'package:parkparty/ui/bottomsheets/setup_bottom_sheet_ui.dart';
import 'package:parkparty/ui/onboarding/onboarding_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app/app.router.dart';
import 'ui/dialogs/setup_dialog_ui.dart';

late FirebaseAnalytics analytics;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupBottomSheetUi();
  //Firebase Kram
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  analytics = FirebaseAnalytics();
  setupDialogUi();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  ).then((val) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: StackedService.navigatorKey,
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics)],
        theme: ThemeData(
          toggleableActiveColor: CupertinoColors.activeBlue,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          }),
          checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2),
              ),
              side: BorderSide(width: 1.2, color: Color(0xff2C3E50)),
              splashRadius: 0),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.transparent)),
            focusedErrorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.transparent)),
            errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(color: Colors.transparent)),
            contentPadding:
                EdgeInsets.only(left: 11, right: 3, top: 2, bottom: 2),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[800]!),
            ),
            labelStyle: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
          textTheme: TextTheme(
            headline1: GoogleFonts.merriweather(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            headline2: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            caption: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            bodyText1: GoogleFonts.raleway(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            bodyText2: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: Colors.grey[700],
              ),
            ),
          ),
        ),
        //home: OnboardingView());
        home: _getStartupScreen());
  }

  Widget _getStartupScreen() {
    print("Start von Zuordnung");
    var sharedPreferencesService = locator<SharedPreferencesService>();
    if (!sharedPreferencesService.isFirstOpen) {
      return BottomNavigationView();
    }
    print("Hier hallo");
    locator<SharedPreferencesService>().isFirstOpen = false;
    return OnboardingView();
  }
}
