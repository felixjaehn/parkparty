import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:measured_size/measured_size.dart';
import 'package:parkparty/helper/ui_helpers.dart';

class LieferHinweisView extends StatelessWidget {
  ///Funktion zur Verarbeitung der erhaltenen Höhe
  final Function(Size size) measureHeight;

  ///Funktion zum Aufrufen des BottomSheets
  final Function() onTap;

  ///Der Text, welcher gerade im Hinweisfeld angezeigt wird
  final String text;
  const LieferHinweisView(
      {Key? key,
      required this.measureHeight,
      required this.onTap,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MeasuredSize(
      onChange: (Size size) => measureHeight(size),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              SizedBox(height: 6),
              GestureDetector(
                onTap: onTap,
                child: Container(
                    height: screenHeight(context) * 0.2,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      color: CupertinoColors.extraLightBackgroundGray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        text,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
