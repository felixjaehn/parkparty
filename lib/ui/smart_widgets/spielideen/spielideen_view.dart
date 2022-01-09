import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'spielideen_viewmodel.dart';

class SpielideenView extends StatelessWidget {
  const SpielideenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SpielideenViewModel>.reactive(
      builder: (context, model, child) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: 12, horizontal: screenWidth(context) * 0.02),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffF18800),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Spielideen",
                  style: GoogleFonts.merriweather(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "Entdecke die beliebtesten Kartenspiele",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(left: 28.0, top: 25),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth(context) * 0.4,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Mao Mao",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.white),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                          indent: screenWidth(context) * 0.05,
                          endIndent: screenWidth(context) * 0.15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth(context) * 0.4,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Brandeln",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.white),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                          indent: screenWidth(context) * 0.05,
                          endIndent: screenWidth(context) * 0.15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth(context) * 0.4,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Truco",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.white),
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                          indent: screenWidth(context) * 0.05,
                          endIndent: screenWidth(context) * 0.15,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: screenWidth(context) * 0.4,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Schwimmen",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Icon(CupertinoIcons.chevron_right,
                                color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SpielideenViewModel(),
    );
  }
}
