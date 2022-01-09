import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:odometer/odometer.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

import 'mehrfachauswahl_bottomsheet_viewmodel.dart';

class MehrfachAuswahlBottomSheetView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  final Produkt produkt;
  const MehrfachAuswahlBottomSheetView({
    required this.produkt,
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  //Das hier beschriebene Widget wird als BottomSheet angezeigt
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MehrfachAuswahlBottomSheetViewModel>.reactive(
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
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 18,
                              right: 14,
                              left: 14,
                            ),
                            child: Column(children: [
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
                                  SizedBox(width: 3),
                                  Icon(CupertinoIcons.chevron_right)
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'eu', symbol: '€')
                                        .format(model.warenkorbPreis),
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: CupertinoColors.black,
                                          fontSize: 26,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                        Divider(
                            thickness: 0.4,
                            color: CupertinoColors.opaqueSeparator),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 14,
                            left: 14,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Wähle deine Zutaten:",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Row(
                                        children: model.mehrfachAuswahl.map(
                                            (AuswahlElement auswahlElement) {
                                          final bool _showComma = model
                                                  .mehrfachAuswahl
                                                  .indexOf(auswahlElement) !=
                                              model.mehrfachAuswahl.length - 1;
                                          return Text(
                                            _showComma
                                                ? "${auswahlElement.title}, "
                                                : auswahlElement.title,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      if (model.mehrfachAuswahl.isEmpty)
                                        SizedBox(height: 19),
                                      SizedBox(height: 8),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          "${model.mehrfachAuswahl.length}/${produkt.auswahlAnzahl ?? 3}",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color:
                                                    model.warnungAuswahlAnzahl
                                                        ? CupertinoColors
                                                            .destructiveRed
                                                        : Colors.grey[800],
                                                fontSize: 15,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                      )
                                    ]),
                              )
                            ],
                          ),
                        ),
                        Divider(
                            thickness: 0.4,
                            color: CupertinoColors.opaqueSeparator),
                        Column(
                          children: produkt.auswahlElemente
                              .map((AuswahlElement auswahlElement) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      model.addToAuswahl(auswahlElement),
                                  child: Container(
                                    //height: screenHeight(context) * 0.05,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 26),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgPicture.asset('assets/success.svg',
                                              color: Colors.transparent),
                                          Text(
                                            auswahlElement.title,
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: model.mehrfachAuswahl
                                                          .contains(
                                                              auswahlElement)
                                                      ? CupertinoColors
                                                          .activeBlue
                                                      : Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          model.mehrfachAuswahl
                                                  .contains(auswahlElement)
                                              ? SvgPicture.asset(
                                                  "assets/success.svg",
                                                  color: CupertinoColors
                                                      .activeBlue)
                                              : SvgPicture.asset(
                                                  "assets/idle.svg",
                                                  color: Color(0xff4A4A4A),
                                                )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (produkt.auswahlElemente
                                        .indexOf(auswahlElement) !=
                                    produkt.auswahlElemente.length - 1)
                                  Divider(
                                      thickness: 0.4,
                                      color: CupertinoColors.opaqueSeparator),
                              ],
                            );
                          }).toList(),
                        ),
                        if (model.warnungAuswahlAnzahl)
                          Column(children: [
                            Divider(
                                thickness: 0.4,
                                color: CupertinoColors.opaqueSeparator),
                            Text(
                              "Du hast die maximale Auswahlmenge erreicht!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: CupertinoColors.destructiveRed,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ]),
                        SizedBox(height: 8),
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
                          height: 50,
                          child: CupertinoButton(
                            padding: EdgeInsets.zero,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                "Abbrechen",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.grey[900],
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
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
                          height: 50,
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
                                      fontSize: 18,
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
      viewModelBuilder: () => MehrfachAuswahlBottomSheetViewModel(),
    );
  }
}
