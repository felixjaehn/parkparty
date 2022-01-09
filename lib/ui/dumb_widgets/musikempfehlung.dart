import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';

class MusikEmpfehlung extends StatelessWidget {
  MusikEmpfehlung({
    required this.title,
    required this.interpret,
  });
  final String title;
  final String interpret;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.02),
      child: Container(
        height: screenHeight(context) * 0.25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff64BE7C),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 5,
              right: -10,
              child: Icon(CupertinoIcons.music_note_2,
                  size: 140, color: Colors.white24),
            ),
            Positioned(
              top: 25,
              left: 12,
              child: Text(
                "Sommerhit des Tages",
                style: GoogleFonts.merriweather(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 25,
              height: screenHeight(context) * 0.13,
              width: screenWidth(context) * 0.8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: screenHeight(context) * 0.08,
                          width: screenHeight(context) * 0.08,
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                              child: Transform.scale(
                                  scale: 1.4,
                                  child: Icon(Icons.music_note,
                                      color: Colors.white)))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            "von $interpret",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
