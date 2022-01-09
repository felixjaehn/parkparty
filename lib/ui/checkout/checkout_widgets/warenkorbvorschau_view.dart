import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:measured_size/measured_size.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/warenkorb_service.dart';

class WarenkorbVorschauView extends StatelessWidget {
  ///Funktion zur Verarbeitung der erhaltenen Höhe
  final Function(Size size) measureHeight;
  final VoidCallback onKorrigierenTapped;
  final List<WarenkorbElement> warenkorb;
  final double warenkorbPreis;
  final bool ab18;
  const WarenkorbVorschauView(
      {Key? key,
      required this.measureHeight,
      required this.warenkorb,
      required this.onKorrigierenTapped,
      required this.warenkorbPreis,
      required this.ab18})
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    "Lass uns sichergehen, dass du auch das bekommst was du haben willst.",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: warenkorb.length <= 1
                      ? screenHeight(context) * 0.19
                      : screenHeight(context) * 0.25,
                  child: CupertinoScrollbar(
                    isAlwaysShown: true,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 4, top: 10, bottom: 5),
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return WarenkorbSegment(
                            index: index,
                            warenkorbElement: warenkorb[index],
                            anzahl: warenkorb[index].anzahl,
                          );
                        },
                        itemCount: warenkorb.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            indent: 20,
                            endIndent: 20,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Gesamt:",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        NumberFormat.currency(locale: 'eu', symbol: '€')
                            .format(warenkorbPreis),
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        color: Colors.black,
                        onPressed: onKorrigierenTapped,
                        child: Text(
                          "Korrigieren",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (ab18)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Die Auswahl beinhaltet alkoholische Getränke. Diese liefern wir nur an Erwachsene aus. Wir behalten uns vor bei der Lieferung deine Volljährigkeit anhand eines Ausweisdokumentes zu überprüfen.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                SizedBox(height: 10),
              ],
            ),
          )),
    );
  }
}

class WarenkorbSegment extends StatelessWidget {
  final int anzahl;
  final int index;
  final WarenkorbElement warenkorbElement;
  const WarenkorbSegment(
      {Key? key,
      this.anzahl = 1,
      required this.warenkorbElement,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
              child: Text(
                "$anzahl",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    warenkorbElement.name,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  locator<WarenkorbService>().getSubtitle(index)
                ],
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 10, left: 12),
              child: Text(
                NumberFormat.currency(locale: 'eu', symbol: '€')
                    .format(warenkorbElement.endPreis),
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Row subtitle(index) {
    if (warenkorbElement.mehrfachAuswahlVorhanden) {
      return Row(
        children: warenkorbElement.mehrfachAuswahl!
            .map((AuswahlElement auswahlElement) {
          final bool _showComma =
              warenkorbElement.mehrfachAuswahl!.indexOf(auswahlElement) !=
                  warenkorbElement.mehrfachAuswahl!.length - 1;
          return Text(
            _showComma ? "${auswahlElement.title}, " : auswahlElement.title,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Colors.grey[700]!,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          );
        }).toList(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          warenkorbElement.endAuswahl == null
              ? ""
              : warenkorbElement.endAuswahl!.title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[700]!,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
        if (warenkorbElement.endAuswahl != null)
          Row(
            children: [
              SizedBox(width: 3),
              Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                    color: Colors.grey[700]!, shape: BoxShape.circle),
              ),
              SizedBox(width: 3),
            ],
          ),
        Text(
          warenkorbElement.mengenWahl!.title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[700]!,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
