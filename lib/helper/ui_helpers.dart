// Horizontal Spacing
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Styles
final TextStyle headlineText = GoogleFonts.roboto(
  textStyle:
      TextStyle(color: Colors.black, fontSize: 26, fontWeight: FontWeight.w600),
);
final TextStyle ctaText = GoogleFonts.roboto(
  textStyle:
      TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
);
final TextStyle bodyText = GoogleFonts.roboto(
  textStyle: TextStyle(
      color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.w400),
);
final TextStyle manyLinesText = GoogleFonts.roboto(
  textStyle: TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
);
final TextStyle sectionHeadline = GoogleFonts.roboto(
  textStyle:
      TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),
);
final TextStyle sectionSubHeadline = GoogleFonts.roboto(
  textStyle: TextStyle(
      color: Colors.grey[800], fontSize: 18, fontWeight: FontWeight.w300),
);
final TextStyle settingsHeader = GoogleFonts.roboto(
  textStyle:
      TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
);
final TextStyle settingsText = GoogleFonts.roboto(
  textStyle:
      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
);

final TextStyle altBodyText = GoogleFonts.notoSans(
    textStyle: TextStyle(
        color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400));

final Color kCTAColor = CupertinoColors.activeBlue;
final Color activeCTaColor = CupertinoColors.activeGreen;
final Color brandColor = Color(0xffDAA24A);
final Color pastelPink = Color(0xffFE9090);
final Color pastelPurple = Color(0xff909FFE);
final Color darkenedOrange = Color(0xffF18800);
final Color pastelGreen = Color(0xff64BE7C);
final Color picknickPurple = Color(0xffBF8EBC);
final Color cocktailBlue = Color(0xff80A6F2);
final Color alkFreeCocktailOrange = Color(0xffFEAA02);
final Color softdrinksPink = Color(0xffE39280);
final Color snacksDarkOrange = Color(0xffF26835);
final Color spirituosenBrown = Color(0xffC17D40);
final Color freizeitGreen = Color(0xff30BF62);

final BorderRadius largeRadius = BorderRadius.circular(8);
final BorderRadius smallRadius = BorderRadius.circular(4);
final BorderRadius extraSmallRadius = BorderRadius.circular(2);
final BorderRadius bottomSheetRadius = BorderRadius.vertical(
  top: Radius.circular(12),
);

// Screen Size helpers
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

//Ready to use Widgets
final Widget basicDivider =
    Divider(thickness: 0.4, color: CupertinoColors.opaqueSeparator);
