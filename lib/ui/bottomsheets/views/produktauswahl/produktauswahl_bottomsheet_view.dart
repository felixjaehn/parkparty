import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odometer/odometer.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

import 'produktauswahl_bottomsheet_viewmodel.dart';

class ProduktAuswahlBottomSheetView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  final Produkt produkt;
  const ProduktAuswahlBottomSheetView({
    required this.produkt,
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  //Das hier beschriebene Widget wird als BottomSheet angezeigt
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProduktAuswahlBottomSheetViewModel>.reactive(
      onModelReady: (model) => model.setUp(produkt),
      builder: (context, model, child) {
        return Padding(
            padding: EdgeInsets.only(
              left: screenWidth(context) * 0.04,
              right: screenWidth(context) * 0.04,
              bottom: 20,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        AuswahlHeaderView(
                            produkt: produkt,
                            subtitle: model.auswahlSubtitle(),
                            endPreis:
                                model.warenkorbPreis * model.produktAnzahl),
                        basicDivider,
                        if (produkt.auswahlElemente.isNotEmpty)
                          AuswahlElemente(
                            produkt: produkt,
                            aktuelleAuswahl: model.aktuelleAuswahl,
                            changeAuswahl: (auswahlElement, produkt) =>
                                model.changeAuswahl(auswahlElement, produkt),
                          ),
                        MengenAuswahlWidget(
                          produkt: produkt,
                          aktuelleMenge: model.aktuelleMenge,
                          changeMenge: (ma, produkt) =>
                              model.changeMenge(ma, produkt),
                        ),
                        if (produkt.kannPfandBecher)
                          PfandAuswahlWidget(
                            pfandAuswahl: (val) => model.pfandBecherWahl(val),
                            pfandSelected: model.pfandSelected,
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  //Container zur Mengenauswahl
                  Container(
                    height: screenHeight(context) * 0.075,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15, left: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Menge:",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: model.subtract,
                                  icon: Icon(CupertinoIcons.minus,
                                      color: model.warnungMinus
                                          ? CupertinoColors.inactiveGray
                                          : Colors.black),
                                ),
                                Container(
                                  width: 30,
                                  child: Center(
                                    child: AnimatedSlideOdometerNumber(
                                        numberTextStyle: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        odometerNumber:
                                            OdometerNumber(model.produktAnzahl),
                                        duration: Duration(milliseconds: 100),
                                        letterWidth: 14),
                                  ),
                                ),
                                IconButton(
                                  onPressed: model.add,
                                  icon: Icon(CupertinoIcons.add,
                                      color: model.warnungPlus
                                          ? CupertinoColors.inactiveGray
                                          : Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Container enthält Abbrechen/Hinzufügen Button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 46,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Abbrechen",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            onPressed: () => completer!(
                              SheetResponse(confirmed: true),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 46,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: CupertinoColors.activeGreen,
                            child: Center(
                              child: Text(
                                NumberFormat.currency(locale: 'eu', symbol: '€')
                                    .format(model.produktAnzahl *
                                        model.warenkorbPreis),
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            onPressed: () {
                              model.addToCart();
                              return completer!(
                                SheetResponse(confirmed: true),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
      viewModelBuilder: () => ProduktAuswahlBottomSheetViewModel(),
    );
  }
}

class AuswahlHeaderView extends StatelessWidget {
  const AuswahlHeaderView({
    Key? key,
    required this.produkt,
    required this.endPreis,
    required this.subtitle,
  }) : super(key: key);

  final Produkt produkt;
  final double endPreis;
  final Row subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          right: 20,
          left: 20,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  produkt.name,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            subtitle,
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  NumberFormat.currency(locale: 'eu', symbol: '€')
                      .format(endPreis),
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: CupertinoColors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PfandAuswahlWidget extends StatelessWidget {
  const PfandAuswahlWidget({
    Key? key,
    required this.pfandAuswahl,
    required this.pfandSelected,
  }) : super(key: key);

  final Function(bool val) pfandAuswahl;
  final bool pfandSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        basicDivider,
        Container(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 30, bottom: 12, top: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Lieferung im Pfandbecher:",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Color(0xff2C3E50),
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Transform.scale(
                      scale: 1.2,
                      child: Theme(
                        data: ThemeData(
                          checkboxTheme: Theme.of(context)
                              .checkboxTheme
                              .copyWith(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  side:
                                      BorderSide(width: 1, color: Colors.black),
                                  splashRadius: 0),
                        ),
                        child: Checkbox(
                          value: pfandSelected,
                          onChanged: (auswahl) => pfandAuswahl(auswahl!),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class MengenAuswahlWidget extends StatelessWidget {
  const MengenAuswahlWidget({
    Key? key,
    required this.produkt,
    required this.changeMenge,
    required this.aktuelleMenge,
  }) : super(key: key);

  final Produkt produkt;
  final Function(MengenAuswahl ma, Produkt produkt) changeMenge;
  final MengenAuswahl aktuelleMenge;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: produkt.kannPfandBecher
            ? const EdgeInsets.only(left: 12, right: 8)
            : const EdgeInsets.only(left: 12.0, right: 8.0, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: produkt.mengenAuswahl.map((MengenAuswahl mengenAuswahl) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: GestureDetector(
                  onTap: () => changeMenge(mengenAuswahl, produkt),
                  child: Container(
                    height: screenHeight(context) * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        width: 0.6,
                        color: aktuelleMenge == mengenAuswahl
                            ? CupertinoColors.activeBlue
                            : Colors.grey[700]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        mengenAuswahl.title,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: aktuelleMenge == mengenAuswahl
                                  ? CupertinoColors.activeBlue
                                  : Colors.grey[700]!,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class AuswahlElemente extends StatelessWidget {
  const AuswahlElemente({
    Key? key,
    required this.produkt,
    required this.changeAuswahl,
    required this.aktuelleAuswahl,
  }) : super(key: key);

  final Produkt produkt;
  final Function(AuswahlElement ae, Produkt produkt) changeAuswahl;
  final AuswahlElement aktuelleAuswahl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: produkt.auswahlElemente.map((AuswahlElement auswahlElement) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => changeAuswahl(auswahlElement, produkt),
              child: Container(
                height: screenHeight(context) * 0.05,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(CupertinoIcons.check_mark, color: Colors.transparent),
                    Text(
                      auswahlElement.title,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: aktuelleAuswahl == auswahlElement
                                ? CupertinoColors.activeBlue
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Icon(CupertinoIcons.check_mark,
                        color: aktuelleAuswahl == auswahlElement
                            ? CupertinoColors.activeBlue
                            : Colors.transparent),
                  ],
                ),
              ),
            ),
            basicDivider,
          ],
        );
      }).toList(),
    );
  }
}
