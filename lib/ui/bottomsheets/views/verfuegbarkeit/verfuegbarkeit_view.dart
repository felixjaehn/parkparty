import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:odometer/odometer.dart';
import 'package:parkparty/helper/loadingwave.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'verfuegbarkeit_viewmodel.dart';

class VerfuegbarkeitView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  final Map<String, dynamic> input;
  const VerfuegbarkeitView({
    Key? key,
    this.request,
    this.completer,
    required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerfuegbarkeitViewModel>.reactive(
      onModelReady: (model) => model.setUp(input),
      builder: (context, model, child) {
        return Container(
          height: screenHeight(context) * 0.82,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: bottomSheetRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerRight,
                  height: 54,
                  child: IconButton(
                    icon: Icon(CupertinoIcons.xmark, size: 24),
                    onPressed: () {
                      return completer!(
                        SheetResponse(confirmed: true),
                      );
                    },
                  ),
                ),
                Text("Verfügbarkeitsproblem", style: sectionHeadline),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                      "Leider sind nicht alle von dir gewünschten Produkte verfügbar. Lass uns das beheben und deine Bestellung anpassen!",
                      style: ctaText.copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300)),
                ),
                SizedBox(
                  height: 18,
                ),
                Expanded(
                  child: Container(
                    child: model.warenkorb.length == 0
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    "assets/happy.json",
                                    height: 120,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  SizedBox(height: 20),
                                  Text(
                                    "Wunderbar! Die restlichen Produkte deines Warenkorbs sind verfügbar. Somit kannst du die Bestellung nun abschließen.",
                                    textAlign: TextAlign.center,
                                    style: ctaText.copyWith(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ]),
                          )
                        : CupertinoScrollbar(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              separatorBuilder: (context, i) {
                                return SizedBox(height: 6);
                              },
                              itemCount: model.warenkorb.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: model.verfuegbareAnzahl(index)
                                          ? Color(0xffD1F6D9)
                                          : Color(0xffE5EEFF),
                                      borderRadius: smallRadius),
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  color:
                                                      model.verfuegbareAnzahl(
                                                              index)
                                                          ? Colors.black
                                                          : CupertinoColors
                                                              .destructiveRed,
                                                  borderRadius: smallRadius,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    model.anzahlen[index]
                                                        .toString(),
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 22,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    model.warenkorb[index]
                                                        .produkt.name,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  model.getSubtitle(
                                                      model.warenkorb[index]),
                                                ],
                                              ),
                                              Expanded(child: SizedBox()),
                                              Text(
                                                NumberFormat.currency(
                                                        locale: 'eu',
                                                        symbol: '€')
                                                    .format(model
                                                        .warenkorb[index]
                                                        .endPreis),
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 14),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                model.verfuegbar[index] == 0
                                                    ? "Nicht verfügbar"
                                                    : "Nur ${model.verfuegbar[index]} verfügbar",
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 18,
                                                      color: model
                                                              .verfuegbareAnzahl(
                                                                  index)
                                                          ? Colors.transparent
                                                          : Colors.black),
                                                ),
                                              ),
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          smallRadius),
                                                  child:
                                                      model.verfuegbar[index] ==
                                                              0
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          smallRadius),
                                                                  child: IconButton(
                                                                      icon: Icon(CupertinoIcons.delete),
                                                                      onPressed: () {
                                                                        model.removeElement(
                                                                            index);
                                                                      }),
                                                                ),
                                                              ],
                                                            )
                                                          : Row(children: [
                                                              IconButton(
                                                                icon: Icon(
                                                                    CupertinoIcons
                                                                        .minus,
                                                                    color: model
                                                                            .warnungMinus
                                                                        ? Colors.grey[
                                                                            400]
                                                                        : CupertinoColors
                                                                            .activeBlue),
                                                                onPressed: () =>
                                                                    model.subtract(
                                                                        index),
                                                              ),
                                                              Container(
                                                                width: 30,
                                                                child: Center(
                                                                  child: AnimatedSlideOdometerNumber(
                                                                      numberTextStyle: GoogleFonts.roboto(
                                                                        textStyle: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                24,
                                                                            fontWeight:
                                                                                FontWeight.w500),
                                                                      ),
                                                                      odometerNumber: OdometerNumber(model.anzahlen[index]),
                                                                      duration: Duration(milliseconds: 100),
                                                                      letterWidth: 14),
                                                                ),
                                                              ),
                                                              IconButton(
                                                                icon: Icon(
                                                                    CupertinoIcons
                                                                        .add,
                                                                    color: model
                                                                            .warnungPlus
                                                                        ? Colors.grey[
                                                                            400]
                                                                        : Colors
                                                                            .black),
                                                                onPressed: () =>
                                                                    model.add(
                                                                        index),
                                                              )
                                                            ])),
                                            ],
                                          ),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ),
                  ),
                ),
                if (model.warenkorbLength != 0)
                  GestureDetector(
                    onTap: model.erfolgreich
                        ? () {
                            model.executePayment(input["method"]);
                          }
                        : () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: model.erfolgreich
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.inactiveGray,
                          borderRadius: largeRadius),
                      child: model.isBusy
                          ? Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child:
                                    SpinKitWave(color: Colors.white, size: 40),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Abgeänderte Bestellung",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17),
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'eu', symbol: '€')
                                                  .format(model.neuerPreis),
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 26),
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "(vorher ${NumberFormat.currency(locale: 'eu', symbol: '€').format(model.alterPreis)})",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          model.getZahlungsmethodenText(
                                              input["method"]),
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ]),
                                  Icon(CupertinoIcons.chevron_right_circle,
                                      color: Colors.white,
                                      size: screenHeight(context) * 0.06),
                                ],
                              ),
                            ),
                    ),
                  ),
                if (model.warenkorbLength == 0)
                  GestureDetector(
                    onTap: () => model.goToKategorien(),
                    child: Container(
                      decoration: BoxDecoration(
                          color: CupertinoColors.activeBlue,
                          borderRadius: largeRadius),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 16),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Warenkorb neu befüllen",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ),
                              Icon(CupertinoIcons.arrow_right,
                                  color: Colors.white, size: 30),
                            ]),
                      ),
                    ),
                  ),
                SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => VerfuegbarkeitViewModel(),
    );
  }
}
