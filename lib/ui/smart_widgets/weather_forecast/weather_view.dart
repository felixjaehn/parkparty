import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'weather_viewmodel.dart';

class WetterView extends StatelessWidget {
  const WetterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WetterViewModel>.reactive(
      builder: (context, model, child) {
        if (model.wetterWidgetExists) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 12, horizontal: screenWidth(context) * 0.02),
            child: GestureDetector(
              onTap: () => model.getWeather(),
              child: model.wetterWidget,
            ),
          );
        }
        return FutureBuilder(
            future: model.getWeather(),
            builder: (context, data) {
              if (data.hasData &&
                  data.connectionState == ConnectionState.done) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: screenWidth(context) * 0.02),
                  child: GestureDetector(
                    onTap: () => model.getWeather(),
                    child: model.wetterWidget,
                  ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 12, horizontal: screenWidth(context) * 0.02),
                  child: Container(
                    height: screenHeight(context) * 0.4,
                    decoration: BoxDecoration(
                      color: Color(0xff06805E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          "Wiwawobudabim... Wo ist denn das Wetter hin?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            });
      },
      viewModelBuilder: () => WetterViewModel(),
    );
  }
}

class WetterWolken extends StatelessWidget {
  const WetterWolken({
    Key? key,
    this.temp,
    this.pop,
  }) : super(key: key);

  final int? temp;
  final int? pop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.4,
      decoration: BoxDecoration(
        color: Color(0xff06805E),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wetteraussichten",
                  style: GoogleFonts.merriweather(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "für Braunschweig in den nächsten Stunden",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -5,
            bottom: screenHeight(context) * 0.03,
            child: Container(
              child: SvgPicture.asset(
                "assets/wolke.svg",
                height: screenHeight(context) * 0.27,
                color: Color(0xffFE9090),
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: screenHeight(context) * 0.28,
            left: 12,
            height: 1,
            width: screenWidth(context) * 0.7,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
              left: 15,
              top: screenHeight(context) * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Temperatur:",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$temp°C",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Regenwahrscheinlichkeit:",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$pop%",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class WetterRegen extends StatelessWidget {
  const WetterRegen({
    Key? key,
    this.temp,
    this.pop,
  }) : super(key: key);

  final int? temp;
  final int? pop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.4,
      decoration: BoxDecoration(
        color: Color(0xff0C60F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wetteraussichten",
                  style: GoogleFonts.merriweather(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "für Braunschweig in den nächsten Stunden",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 21,
            bottom: screenHeight(context) * 0.13,
            child: Container(
              child: SvgPicture.asset(
                "assets/raindrop.svg",
                height: 60,
                color: Color(0xff00DAFF),
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            right: screenWidth(context) * 0.32,
            bottom: screenHeight(context) * 0.13,
            child: Container(
              child: SvgPicture.asset(
                "assets/raindrop.svg",
                height: 60,
                color: Color(0xff00DAFF),
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            right: screenWidth(context) * 0.17,
            bottom: screenHeight(context) * 0.21,
            child: Container(
              child: SvgPicture.asset(
                "assets/raindrop.svg",
                height: 60,
                color: Color(0xff00DAFF),
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: screenHeight(context) * 0.28,
            left: 12,
            height: 1,
            width: screenWidth(context) * 0.7,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
              left: 15,
              top: screenHeight(context) * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Temperatur:",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$temp°C",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Regenwahrscheinlichkeit:",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$pop%",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class WetterSonne extends StatelessWidget {
  const WetterSonne({
    Key? key,
    this.temp,
    this.pop,
  }) : super(key: key);

  final int? temp;
  final int? pop;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.4,
      decoration: BoxDecoration(
        color: Color(0xffFE9090),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Wetteraussichten",
                  style: GoogleFonts.merriweather(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "für Braunschweig in den nächsten Stunden",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            height: screenHeight(context) * 0.16,
            width: screenHeight(context) * 0.16,
            top: screenHeight(context) * 0.11,
            right: screenWidth(context) * 0.1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffFF7700),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffE4DE26).withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(-3, 2), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: screenHeight(context) * 0.21,
            right: 0,
            height: 2,
            width: screenWidth(context) * 0.25,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
            top: screenHeight(context) * 0.28,
            left: 12,
            height: 1,
            width: screenWidth(context) * 0.7,
            child: Container(
              color: Colors.white,
            ),
          ),
          Positioned(
              left: 15,
              top: screenHeight(context) * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Temperatur:",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$temp°C",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Regenwahrscheinlichkeit:",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "$pop%",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
