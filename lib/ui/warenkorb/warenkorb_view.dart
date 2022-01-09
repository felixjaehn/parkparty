import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:parkparty/enums/location_type.dart';
import 'package:parkparty/helper/loadingwave.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/ui/dumb_widgets/progress_row.dart';
import 'package:parkparty/ui/warenkorb/warenkorb_viewmodel.dart';
import 'package:stacked/stacked.dart';

class WarenkorbView extends StatelessWidget {
  WarenkorbView({Key? key}) : super(key: key);

  Container _getEmptyState(WarenkorbViewModel model, BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 8, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Warenkorb",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => model.openWarenkorb(),
                    child: Text(
                      "Zum Warenkorb",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: CupertinoColors.activeBlue,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Momentan ist dein Warenkorb leer. Sobald du Produkte hinzufügst, findest du diese hier. Im Menü findest du weitere Informationen zur Lieferung!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 16),
                      CupertinoButton(
                        onPressed: () => model.openKategorien(),
                        color: CupertinoColors.activeBlue,
                        child: Center(
                          child: Text(
                            "Produkte entdecken",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
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

  Column bestellungAktiv(WarenkorbViewModel model, BuildContext context) {
    return Column(
      children: [
        //Container mit Titelelementen
        Container(
          height: screenHeight(context) * 0.1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Zustellung",
                        style: GoogleFonts.merriweather(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: screenWidth(context) * 0.3,
                        color: Color(0xffDAA24A),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(CupertinoIcons.ellipsis_vertical),
                onPressed: () => model.openSettings(),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          decoration:
              BoxDecoration(color: Colors.white, borderRadius: smallRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Hilfe",
                  style: ctaText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: CupertinoColors.activeBlue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 6, right: 6),
                child: Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Geschätzte Ankunftszeit:",
                        style: sectionSubHeadline.copyWith(fontSize: 16)),
                    Text("17:01 Uhr", style: sectionHeadline),
                  ],
                ),
              ),
              ProgressRowSmall(lieferStufe: 2),
              SizedBox(height: 24),
              Text(
                "Deine Bestellung wurde zubereitet",
                style: sectionSubHeadline.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                "Nächste: Der Lieferfahrer holt die Bestellung ab",
                style: sectionSubHeadline.copyWith(fontSize: 15),
              ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: smallRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lieferfortschritt",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: Stack(
                      children: [
                        Positioned(
                          height: 8,
                          width: screenWidth(context) - 48,
                          bottom: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: CupertinoColors.lightBackgroundGray,
                                  borderRadius: largeRadius),
                              child: FractionallySizedBox(
                                widthFactor: 0.4,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.activeGreen,
                                      borderRadius: largeRadius),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 16,
                          width: 16,
                          left: 5,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.activeGreen,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 16,
                          width: 16,
                          right: 5,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.lightBackgroundGray,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          height: 20,
                          width: 20,
                          left: 5,
                          bottom: 22,
                          child: Image(
                            image: AssetImage("assets/start.png"),
                          ),
                        ),
                        Positioned(
                          height: 20,
                          width: 20,
                          right: 5,
                          bottom: 22,
                          child: Image(
                            image: AssetImage("assets/end.png"),
                          ),
                        ),
                        Positioned(
                          height: 44,
                          width: 44,
                          left: (0.3) * (screenWidth(context) - 50),
                          bottom: 8,
                          child: Lottie.asset(
                            "assets/loading.json",
                            height: 150,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            onPressed: () {},
            color: CupertinoColors.activeBlue,
            child: Text(
              "Zur Lieferverfolgung",
              style: ctaText.copyWith(fontSize: 16),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: SizedBox(
            width: double.infinity,
            child: CupertinoButton(
              onPressed: () {},
              color: Colors.white,
              child: Text(
                "Bestelldetails",
                style: ctaText.copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WarenkorbViewModel>.reactive(
      onModelReady: (model) => model.startTimer(),
      builder: (context, model, child) {
        if (model.bestellungAktiv) {
          return Scaffold(
            backgroundColor: CupertinoColors.extraLightBackgroundGray,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: bestellungAktiv(model, context),
              ),
            ),
          );
        } else
          return Scaffold(
            backgroundColor: CupertinoColors.extraLightBackgroundGray,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    //Container mit Titelelementen
                    Container(
                      height: screenHeight(context) * 0.1,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Bestellungen",
                                  style: GoogleFonts.merriweather(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: screenWidth(context) * 0.3,
                                  color: Color(0xffDAA24A),
                                ),
                              ],
                            )),
                          ),
                          IconButton(
                            icon: Icon(CupertinoIcons.ellipsis_vertical),
                            onPressed: () => model.openSettings(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    //Container mit Warenkorbvorschau
                    model.warenkorbListe.isEmpty
                        ? _getEmptyState(model, context)
                        : Container(
                            height: screenHeight(context) * 0.34,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0, right: 8, left: 8),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, left: 8, right: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Warenkorb",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => model.openWarenkorb(),
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: 26,
                                            child: Text(
                                              "Zum Warenkorb",
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: CupertinoColors
                                                        .activeBlue,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Expanded(
                                    child: NotificationListener<
                                        OverscrollIndicatorNotification>(
                                      onNotification:
                                          (OverscrollIndicatorNotification?
                                              overscroll) {
                                        overscroll!.disallowGlow();
                                        return true;
                                      },
                                      child: ListView.separated(
                                        padding: EdgeInsets.only(bottom: 6),
                                        itemBuilder: (context, index) {
                                          String _produktname =
                                              model.warenkorbListe[index].name;
                                          int _anzahl = model
                                              .warenkorbListe[index].anzahl;
                                          return Container(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6,
                                                      horizontal: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Badge(
                                                      animationDuration:
                                                          Duration(
                                                              milliseconds:
                                                                  100),
                                                      animationType:
                                                          BadgeAnimationType
                                                              .scale,
                                                      position: BadgePosition
                                                          .bottomEnd(
                                                              bottom: -7,
                                                              end: _anzahl >= 10
                                                                  ? -4
                                                                  : -8),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 2,
                                                              horizontal: 6),
                                                      shape: BadgeShape.square,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      elevation: 0,
                                                      badgeColor:
                                                          CupertinoColors
                                                              .activeOrange,
                                                      badgeContent: Text(
                                                        model
                                                            .warenkorbListe[
                                                                index]
                                                            .anzahl
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              letterSpacing: 0,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          image:
                                                              DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                model
                                                                    .warenkorbListe[
                                                                        index]
                                                                    .produkt
                                                                    .imageLink),
                                                          ),
                                                        ),
                                                        height: screenHeight(
                                                                context) *
                                                            0.065,
                                                        width: screenHeight(
                                                                context) *
                                                            0.065,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 12),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              _produktname,
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                textStyle: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                            model.subtitle(
                                                                index),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'eu',
                                                            symbol: '€')
                                                        .format(
                                                      model
                                                              .warenkorbListe[
                                                                  index]
                                                              .endPreis *
                                                          model
                                                              .warenkorbListe[
                                                                  index]
                                                              .anzahl,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            SizedBox(height: 4),
                                        itemCount: model.warenkorbListe.length,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.white,
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(height: 4),
                                              if (model.pfandPreis != 0)
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Davon Pfand:",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      NumberFormat.currency(
                                                              locale: 'eu',
                                                              symbol: '€')
                                                          .format(
                                                        model.pfandPreis,
                                                      ),
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              SizedBox(height: 4),
                                              if (model.warenkorbPreis <= 10)
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Inklusive Lieferkosten:",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    Text(
                                                      "+${NumberFormat.currency(locale: 'eu', symbol: '€').format(
                                                        1,
                                                      )}",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              if (model.warenkorbPreis <= 10)
                                                SizedBox(height: 4),
                                              Container(
                                                height: 1,
                                                color: Colors.grey[600],
                                                width:
                                                    screenWidth(context) * 0.4,
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Gesamt",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    NumberFormat.currency(
                                                            locale: 'eu',
                                                            symbol: '€')
                                                        .format(
                                                      model.warenkorbPreis,
                                                    ),
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  if (model.warenkorbPreis <=
                                                      10)
                                                    SizedBox(width: 2),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    if (model.warenkorbListe.isNotEmpty) SizedBox(height: 4),
                    if (model.warenkorbListe.isNotEmpty)
                      CupertinoButton(
                        onPressed: () => model.openCheckout(),
                        color:
                            model.locationStatus == LocationStatus.liefergebiet
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.inactiveGray,
                        child: Center(
                          child: Text(
                            "Bezahlen",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 8),
                    getMapView(model),
                    SizedBox(height: 6),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 40,
                      child: Center(
                        child: Text(
                          "Aktuelle Lieferdauer: 15 Minuten",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 4)
                  ],
                ),
              ),
            ),
          );
      },
      viewModelBuilder: () => WarenkorbViewModel(),
    );
  }

  Widget getMapView(WarenkorbViewModel model) {
    LocationStatus _lS = model.locationStatus;
    switch (_lS) {
      case LocationStatus.keinLiefergebiet:
        return StandortFails(
            onTap: () => model.editLocationView(),
            warenkorbLeer: model.warenkorbListe.isEmpty,
            hinweisText:
                "Dein uns bekannter Standort befindet sich leider nicht im Liefergebiet.",
            cTaText: "Neu ermitteln");
      case LocationStatus.keinStandort:
        return StandortFails(
            onTap: () => model.editLocationView(),
            warenkorbLeer: model.warenkorbListe.isEmpty,
            hinweisText:
                "Bevor du die Bestellung abschließen kannst musst du deine aktuelle Position bestätigen.",
            cTaText: "Standort ermitteln");
      case LocationStatus.liefergebiet:
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lieferstandort",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => model.editLocationView(),
                          child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            child: Text(
                              "Neu ermitteln",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: CupertinoColors.activeBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Builder(builder: (context) {
                        Widget child;
                        if (model.showLoading) {
                          child = Container(
                            decoration: BoxDecoration(
                              borderRadius: smallRadius,
                              color: CupertinoColors.extraLightBackgroundGray,
                            ),
                            child: Center(
                              child: SpinKitWave(
                                  size: 30, color: CupertinoColors.activeBlue),
                            ),
                          );
                        } else {
                          child = GoogleMap(
                            compassEnabled: false,
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                            markers: model.marker.toSet(),
                            initialCameraPosition: model.kameraPosition,
                            onMapCreated: (GoogleMapController controller) =>
                                model.onMapCreated(context, controller),
                          );
                        }
                        return AnimatedSwitcher(
                            duration: Duration(milliseconds: 800),
                            child: child);
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      case LocationStatus.timeout:
        return StandortFails(
            onTap: () => model.editLocationView(),
            warenkorbLeer: model.warenkorbListe.isEmpty,
            hinweisText:
                "Die Gültigkeit deines letzten Standorts ist leider abgelaufen.",
            cTaText: "Neu ermitteln");
      default:
        return StandortFails(
            onTap: () => model.editLocationView(),
            warenkorbLeer: model.warenkorbListe.isEmpty,
            hinweisText:
                "Die Gültigkeit deines letzten Standorts ist leider abgelaufen.",
            cTaText: "Neu ermitteln");
    }
  }
}

class StandortFails extends StatelessWidget {
  const StandortFails({
    Key? key,
    required this.hinweisText,
    required this.cTaText,
    required this.warenkorbLeer,
    required this.onTap,
  }) : super(key: key);
  final String hinweisText;
  final String cTaText;
  final bool warenkorbLeer;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  hinweisText,
                  textAlign: TextAlign.center,
                  style: ctaText.copyWith(color: Colors.black, fontSize: 16),
                ),
                SizedBox(height: 16),
                CupertinoButton(
                  color: warenkorbLeer
                      ? CupertinoColors.inactiveGray
                      : CupertinoColors.activeBlue,
                  child: Text(cTaText),
                  onPressed: () {
                    onTap();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
