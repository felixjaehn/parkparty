import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parkparty/helper/loadingwave.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/ui/checkout/checkout_widgets/daten.dart';
import 'package:parkparty/ui/checkout/checkout_widgets/standort_view.dart';
import 'package:parkparty/ui/checkout/checkout_widgets/warenkorbvorschau_view.dart';
import 'package:parkparty/ui/checkout/checkout_widgets/zahlungsdienstleister.dart';
import 'package:parkparty/ui/checkout/checkout_segment.dart';
import 'package:stacked/stacked.dart';

import 'checkout_viewmodel.dart';
import 'checkout_widgets/daten.dart';
import 'checkout_widgets/lieferhinweis.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Rebuilt Checkout");
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth(context) * 0.04,
            ),
            child: Column(
              children: [
                //Hier sind die Titelelemente enthalten
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.chevron_back),
                            onPressed: model.goBack,
                          ),
                          IconButton(
                            icon: Badge(
                                position: BadgePosition.bottomStart(
                                    bottom: -4, start: -6),
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.75, horizontal: 4),
                                shape: BadgeShape.square,
                                borderRadius: BorderRadius.circular(8),
                                elevation: 0,
                                badgeColor: CupertinoColors.activeOrange,
                                badgeContent: Text(
                                  model.warenkorbListe.length.toString(),
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0,
                                        fontSize: 12),
                                  ),
                                ),
                                child: Icon(CupertinoIcons.bag)),
                            onPressed: () => model.openWarenkorb(),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bezahlung",
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
                    ],
                  ),
                ),
                //Das ist der ProgressIndicator
                FutureBuilder(
                    future: Future.value(true),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Container(
                          height: 6,
                          child: Stack(
                            children: [
                              Container(
                                  width: screenWidth(context) * 0.92,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                              Container(
                                  width: model.scrollController.hasClients
                                      ? max(
                                          screenWidth(context) *
                                              0.92 *
                                              (model.scrollController.offset /
                                                  model
                                                      .scrollController
                                                      .position
                                                      .maxScrollExtent),
                                          0)
                                      : 0,
                                  decoration: BoxDecoration(
                                    color: CupertinoColors.activeGreen,
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                            ],
                          ),
                        ),
                      );
                    }),
                Expanded(
                  child: NotificationListener(
                    onNotification: (ScrollNotification scrollNotification) {
                      if (model.scrollController.offset >=
                              model.widgetPosition(3) - 60 &&
                          model.scrollController.offset <=
                              model.widgetPosition(3) - 10) {
                        model.validateForm();
                      }
                      model.notifyListeners();
                      return true;
                    },

                    ///Custom Scroll View, welche das wichtige beinhaltet
                    child: CustomScrollView(
                      controller: model.scrollController,
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: SizedBox(height: 2),
                        ),
                        FutureBuilder(
                          future: Future.value(true),
                          builder: (context, snapshot) {
                            return CheckoutSegment(
                              headerGeschlossen:
                                  model.scrollController.hasClients
                                      ? model.headerGeschlossen(0)
                                      : false,
                              onTap: () => model.animatePosition(0),
                              iconPath: model.getIcon(0),
                              title: "Warenkorb",
                              formView: WarenkorbVorschauView(
                                onKorrigierenTapped: () =>
                                    model.openWarenkorb(),
                                warenkorb: model.warenkorbListe,
                                warenkorbPreis: model.warenkorbPreis,
                                ab18: model.ab18,
                                measureHeight: (Size size) {
                                  model.setzeHoehe(0, size.height);
                                },
                              ),
                            );
                          },
                        ),
                        FutureBuilder(
                          future: Future.value(true),
                          builder: (context, snapshot) {
                            return CheckoutSegment(
                              headerGeschlossen:
                                  model.scrollController.hasClients
                                      ? model.headerGeschlossen(1)
                                      : false,
                              onTap: () => model.animatePosition(1),
                              iconPath: model.getIcon(1),
                              title: "Persönliche Daten",
                              hasSubtitle: true,
                              subtitleTextColor: model.headerGeschlossen(1) &&
                                      !model.allesFertig
                                  ? CupertinoColors.destructiveRed
                                  : null,
                              subtitle: model.getText(),
                              formView: DatenFormularView(
                                saveName: (String val) => model.saveName(val),
                                saveMail: (String val) => model.saveMail(val),
                                savePhone: (String val) => model.savePhone(val),
                                beiFormAbschluss: () => model.validateForm(),
                                formKey: model.datenFormKey,
                                hasSubtitle: true,
                                measureHeight: (Size size) {
                                  model.setzeHoehe(1, size.height);
                                },
                              ),
                            );
                          },
                        ),
                        FutureBuilder(
                          future: Future.value(true),
                          builder: (context, snapshot) {
                            return CheckoutSegment(
                              headerGeschlossen:
                                  model.scrollController.hasClients
                                      ? model.headerGeschlossen(2)
                                      : false,
                              onTap: () => model.animatePosition(2),
                              hasSubtitle: true,
                              subtitle: model.getBezahlmethode(true),
                              iconPath: model.getIcon(2),
                              title: "Zahlungsart",
                              formView: ZahlungsdienstleisterView(
                                setCheckboxState: (selectedCheckbox) =>
                                    model.setZahlmethode(selectedCheckbox),
                                aktuelleBezahlmethode:
                                    model.ausgewaehlteZahlung,
                                measureHeight: (Size size) {
                                  model.setzeHoehe(2, size.height);
                                },
                              ),
                            );
                          },
                        ),
                        FutureBuilder(
                          future: Future.value(true),
                          builder: (context, snapshot) {
                            return CheckoutSegment(
                              headerGeschlossen:
                                  model.scrollController.hasClients
                                      ? model.headerGeschlossen(3)
                                      : false,
                              onTap: () => model.animatePosition(3),
                              iconPath: model.getIcon(3),
                              title: "Lieferstandort",
                              formView: StandortView(
                                editLocation: () => model.editLocationView(),
                                measureHeight: (Size size) {
                                  model.setzeHoehe(3, size.height);
                                },
                              ),
                            );
                          },
                        ),
                        FutureBuilder(
                          future: Future.value(true),
                          builder: (context, snapshot) {
                            return CheckoutSegment(
                              headerGeschlossen:
                                  model.scrollController.hasClients
                                      ? model.headerGeschlossen(4)
                                      : false,
                              onTap: () => model.animatePosition(4),
                              iconPath: model.getIcon(4),
                              title: "Lieferhinweise",
                              formView: LieferHinweisView(
                                text: model.lieferHinweis,
                                onTap: () => model.openTextSheet(),
                                measureHeight: (Size size) {
                                  model.setzeHoehe(4, size.height);
                                },
                              ),
                            );
                          },
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: CupertinoColors.extraLightBackgroundGray,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8)),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      if (model.allesFertig && !model.isBusy)
                                        model.executePayment();
                                    },
                                    child: AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        decoration: BoxDecoration(
                                          color: model.allesFertig
                                              ? CupertinoColors.activeBlue
                                              : CupertinoColors.inactiveGray,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: model.isBusy
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 26),
                                                child: SpinKitWave(
                                                    size: 30,
                                                    color: Colors.white,
                                                    type:
                                                        SpinKitWaveType.start),
                                              )
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 8),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Bestellung abschließen",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 17),
                                                            ),
                                                          ),
                                                          Text(
                                                            NumberFormat
                                                                    .currency(
                                                                        locale:
                                                                            'eu',
                                                                        symbol:
                                                                            '€')
                                                                .format(model
                                                                    .warenkorbPreis),
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800,
                                                                  fontSize: 30),
                                                            ),
                                                          ),
                                                          Text(
                                                            model
                                                                .getBezahlmethode(
                                                                    false),
                                                            style: GoogleFonts
                                                                .roboto(
                                                              textStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 17),
                                                            ),
                                                          ),
                                                        ]),
                                                    Icon(
                                                        CupertinoIcons
                                                            .chevron_right_circle,
                                                        color: Colors.white,
                                                        size: screenHeight(
                                                                context) *
                                                            0.06),
                                                  ],
                                                ),
                                              )),
                                  ),
                                  if (!model.allesFertig)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        "Bitte überprüfe deine Eingaben!",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: CupertinoColors
                                                  .destructiveRed,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17),
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 14),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text:
                                            'Durch das Anklicken von \"Bestellung abschließen\" bestätigst du den Warenkorb und deine eingegebenen Daten. Zudem stimmst du unseren ',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Datenschutzbestimmungen ",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "sowie unseren ",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "AGB ",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "zu.",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: model.allesFertig ? 75 : 40),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => CheckoutViewModel(),
    );
  }
}
