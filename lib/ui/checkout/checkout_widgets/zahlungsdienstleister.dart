import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:measured_size/measured_size.dart';

class ZahlungsdienstleisterView extends StatelessWidget {
  final Function(Size size) measureHeight;

  final String aktuelleBezahlmethode;
  final Function(String selectedCheckbox) setCheckboxState;
  ZahlungsdienstleisterView(
      {Key? key,
      required this.measureHeight,
      required this.aktuelleBezahlmethode,
      required this.setCheckboxState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MeasuredSize(
      onChange: (Size size) => measureHeight(size),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            children: [
              BezahlAuswahlFeld(
                headerText: "PayPal",
                bezahlMethode: "PayPal",
                subtitleText: "Mit PayPal bezahlen",
                aktuelleBezahlmethode: aktuelleBezahlmethode,
                setCheckboxState: setCheckboxState,
              ),
              SizedBox(height: 2),
              BezahlAuswahlFeld(
                headerText: "GooglePay",
                bezahlMethode: "GooglePay",
                subtitleText: "Mit GooglePay bezahlen",
                aktuelleBezahlmethode: aktuelleBezahlmethode,
                setCheckboxState: setCheckboxState,
              ),
              BezahlAuswahlFeld(
                headerText: "Kredit-/Debitkarte",
                bezahlMethode: "Credit",
                subtitleText: "Mit Karte bezahlen",
                aktuelleBezahlmethode: aktuelleBezahlmethode,
                setCheckboxState: setCheckboxState,
              ),
              SizedBox(height: 2),
              BezahlAuswahlFeld(
                headerText: "Barzahlung",
                bezahlMethode: "Barzahlung",
                subtitleText: "Bei Erhalt bezahlen",
                aktuelleBezahlmethode: aktuelleBezahlmethode,
                setCheckboxState: setCheckboxState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BezahlAuswahlFeld extends StatelessWidget {
  const BezahlAuswahlFeld({
    Key? key,
    required this.aktuelleBezahlmethode,
    required this.headerText,
    required this.subtitleText,
    required this.bezahlMethode,
    required this.setCheckboxState,
  }) : super(key: key);

  final String headerText;
  final String subtitleText;
  final String bezahlMethode;
  final String aktuelleBezahlmethode;
  final Function(String selectedCheckbox) setCheckboxState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (aktuelleBezahlmethode == bezahlMethode) return;
        setCheckboxState(bezahlMethode);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: aktuelleBezahlmethode == bezahlMethode
              ? Color(0xffE5EEFF)
              : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
          child: Row(
            children: [
              Checkbox(
                value: aktuelleBezahlmethode == bezahlMethode,
                onChanged: (state) {
                  if (aktuelleBezahlmethode == bezahlMethode) return;
                  setCheckboxState(bezahlMethode);
                },
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    headerText,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    subtitleText,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Color(0xff2C3E50),
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
