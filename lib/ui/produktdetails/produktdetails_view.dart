import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:odometer/odometer.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/ui/produktdetails/produktdetails_widgets.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked/stacked.dart';

import 'produktdetails_viewmodel.dart';

class ProduktDetailsView extends StatelessWidget {
  const ProduktDetailsView({
    required this.produkt,
  });
  final Produkt produkt;
  @override
  Widget build(BuildContext context) {
    final _maxHeight = screenHeight(context) * 0.84;
    final _minHeight = screenHeight(context) * 0.62;
    return ViewModelBuilder<ProduktDetailsViewModel>.reactive(
      onModelReady: (model) {
        model.setUp(produkt);
      },
      viewModelBuilder: () => ProduktDetailsViewModel(),
      builder: (context, model, child) => Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: model.panelController,
            maxHeight: _maxHeight,
            minHeight: _minHeight,
            panelSnapping: false,
            body: _body(context, () => model.goBack(), produkt.imageLink),
            panelBuilder: (sc) =>
                _panel(context, sc, _maxHeight, model.pageController, model),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
        ],
      ),
    );
  }

  Widget _panel(
    BuildContext context,
    ScrollController sc,
    double maxHeight,
    PageController pc,
    ProduktDetailsViewModel model,
  ) {
    double _maxHeight = maxHeight;

    double _handleHeight = 40;
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: _handleHeight,
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Container(
                  height: 3,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification? overscroll) {
                  overscroll!.disallowGlow();
                  return true;
                },
                child: Material(
                  child: ListView(
                    controller: sc,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        height: _maxHeight - 50,
                        child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          allowImplicitScrolling: false,
                          controller: pc,
                          children: [
                            _buildAuswahlScreen(context, model, produkt),
                            _buildMainDetails(context, model, _maxHeight,
                                _handleHeight, produkt),
                            AllergieHinweise(
                              allergene: produkt.allergene,
                              zusatzstoffe: produkt.zusatzstoffe,
                              goBack: () => model.showMainScreen(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildAuswahlScreen(
      BuildContext context, ProduktDetailsViewModel model, Produkt produkt) {
    return model.hinzugefuegt
        ? Padding(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CupertinoColors.activeGreen),
                  child: Center(
                    child: Transform.scale(
                      scale: 2.1,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Erfolgreich hinzugefügt",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "Das Produkt wurde erfolgreich zum Warenkorb hinzugefügt",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: 18),
                CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    child: Center(
                      child: Text(
                        "Zum Warenkorb",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    onPressed: model.openCheckout),
                SizedBox(height: 6),
                GestureDetector(
                  onTap: model.hideBanner,
                  child: Container(
                    height: 40,
                    child: Text(
                      "Schließen",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ))
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DetailsHeader(
                    title: produkt.name,
                    auswahlInfo: model.subtitle(model.warenkorbElement),
                    preis: model.warenkorbPreis),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(thickness: 0.4, color: CupertinoColors.opaqueSeparator),
              Column(
                children: produkt.auswahlElemente.map(
                  (AuswahlElement auswahlElement) {
                    final bool _aktuelleAuswahl =
                        model.aktuelleAuswahl == auswahlElement;
                    final double _aufpreisDifferenz = auswahlElement.aufpreis -
                        model.aktuelleAuswahl.aufpreis;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: GestureDetector(
                            onTap: () =>
                                model.changeAuswahl(auswahlElement, produkt),
                            child: Container(
                              height: screenHeight(context) * 0.05,
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        auswahlElement.title,
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: _aktuelleAuswahl
                                                  ? CupertinoColors.activeBlue
                                                  : Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      if (!_aktuelleAuswahl &&
                                          _aufpreisDifferenz != 0)
                                        Text(
                                          _aufpreisDifferenz > 0
                                              ? "(+${NumberFormat.currency(locale: 'eu', symbol: '€').format(_aufpreisDifferenz)})"
                                              : "(${NumberFormat.currency(locale: 'eu', symbol: '€').format(_aufpreisDifferenz)})",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.grey[700],
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Icon(CupertinoIcons.check_mark,
                                      color: _aktuelleAuswahl
                                          ? CupertinoColors.activeBlue
                                          : Colors.transparent),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Divider(
                            thickness: 0.4,
                            color: CupertinoColors.opaqueSeparator),
                      ],
                    );
                  },
                ).toList(),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: produkt.mengenAuswahl
                        .map((MengenAuswahl mengenAuswahl) {
                      final bool _aktuelleAuswahl =
                          model.aktuelleMenge == mengenAuswahl;
                      final double _aufpreisDifferenz =
                          mengenAuswahl.aufpreis - model.aktuelleMenge.aufpreis;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: GestureDetector(
                            onTap: () =>
                                model.changeMenge(mengenAuswahl, produkt),
                            child: Container(
                              height: produkt.mengenAuswahl.length == 1
                                  ? 45
                                  : screenHeight(context) * 0.086,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: _aktuelleAuswahl
                                    ? CupertinoColors.activeBlue
                                    : null,
                                border: _aktuelleAuswahl
                                    ? null
                                    : Border.all(
                                        width: 0.6,
                                        color:
                                            model.aktuelleMenge == mengenAuswahl
                                                ? CupertinoColors.activeBlue
                                                : Colors.grey[700]!,
                                      ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    mengenAuswahl.title,
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: _aktuelleAuswahl
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  if (!_aktuelleAuswahl &&
                                      _aufpreisDifferenz != 0)
                                    Text(
                                      _aufpreisDifferenz > 0
                                          ? "(+${NumberFormat.currency(locale: 'eu', symbol: '€').format(_aufpreisDifferenz)})"
                                          : "(${NumberFormat.currency(locale: 'eu', symbol: '€').format(_aufpreisDifferenz)})",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Divider(thickness: 0.4, color: CupertinoColors.opaqueSeparator),
              if (produkt.kannPfandBecher)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: Container(
                              height: screenHeight(context) * 0.11,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Pfandbecher",
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Container(
                                    height: 40,
                                    child: Transform.scale(
                                      scale: 0.9,
                                      child: CupertinoSwitch(
                                          value: model.pfandSelected,
                                          onChanged: (auswahl) =>
                                              model.pfandBecherWahl(auswahl)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: screenHeight(context) * 0.11,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Menge",
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Container(
                                      width: 140,
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: model.subtract,
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Icon(CupertinoIcons.minus,
                                                  color: model.warnungMinus
                                                      ? CupertinoColors
                                                          .inactiveGray
                                                      : Colors.black),
                                            ),
                                          ),
                                          Container(
                                            width: 30,
                                            child: Center(
                                              child:
                                                  AnimatedSlideOdometerNumber(
                                                      numberTextStyle:
                                                          GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      odometerNumber:
                                                          OdometerNumber(model
                                                              .produktAnzahl),
                                                      duration: Duration(
                                                          milliseconds: 100),
                                                      letterWidth: 12),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: model.add,
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Icon(CupertinoIcons.add,
                                                  color: model.warnungPlus
                                                      ? CupertinoColors
                                                          .inactiveGray
                                                      : Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              if (!produkt.kannPfandBecher)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                width: 140,
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                            odometerNumber: OdometerNumber(
                                                model.produktAnzahl),
                                            duration:
                                                Duration(milliseconds: 100),
                                            letterWidth: 12),
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
                            ]),
                      )),
                ),
              SizedBox(height: 16),
              AbbrechenAuswahlWidget(
                onTap: () => model.showMainScreen(),
                addToCart: () => model.addToCart(),
                endPreis: model.warenkorbPreis * model.produktAnzahl,
              ),
            ],
          );
  }

  Widget _buildMainDetails(BuildContext context, ProduktDetailsViewModel model,
      double maxHeight, double handleHeight, Produkt produkt) {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            height: maxHeight,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      DetailsHeader(
                          title: produkt.name,
                          subtitle: model.getPrettyString(produkt.kategorie),
                          preis: produkt.price),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: GestureDetector(
                          onTap: () {
                            model.showAuswahl();
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: CupertinoColors.activeBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(CupertinoIcons.add, color: Colors.white),
                                SizedBox(width: 6),
                                Text(
                                  "Zur Bestellung hinzufügen",
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          produkt.beschreibung,
                          style: manyLinesText,
                        ),
                      ),
                      Divider(
                          indent: 30,
                          endIndent: 30,
                          height: 25,
                          color: CupertinoColors.opaqueSeparator),
                      produkt.zutatenListe.isNotEmpty
                          ? ZutatenListe(
                              zutaten: produkt.zutatenListe,
                              openHinweise: () {
                                model.showHinweise();
                              })
                          : Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, top: 24),
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      model.showHinweise();
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Allergiehinweise",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(CupertinoIcons.arrow_right,
                                            color: Colors.black, size: 22),
                                      ],
                                    ),
                                  )),
                            ),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 18),
                //   child: RecommendationList(),
                // ),
                // SizedBox(height: handleHeight + 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, Function() goBack, String imageLink) {
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: screenHeight(context) * 0.52,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageLink),
              ),
            ),
          ),
          Positioned(
            width: screenWidth(context) * 0.92,
            top: MediaQuery.of(context).viewPadding.top + 15,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black54),
                  child: IconButton(
                    onPressed: () => goBack(),
                    icon:
                        Icon(CupertinoIcons.chevron_back, color: Colors.white),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black54),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(CupertinoIcons.share, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
