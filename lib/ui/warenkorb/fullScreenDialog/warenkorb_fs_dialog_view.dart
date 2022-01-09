import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:odometer/odometer.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'warenkorb_fs_dialog_viewmodel.dart';

class WarenkorbDialogView extends StatelessWidget {
  final bool? alreadyInCheckout;
  const WarenkorbDialogView({Key? key, this.alreadyInCheckout = false})
      : super(key: key);

  ///Gibt die View zurück für den Fall, dass der Warenkorb leer ist
  Expanded _getViewIfEmpty(
      WarenkorbDialogViewModel model, BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 35),
                Container(
                  height: screenHeight(context) * 0.32,
                  decoration: BoxDecoration(
                    color: Color(0xffE7DFEC),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Image(
                        image: AssetImage('assets/stay-connected.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Hier sieht's leer aus!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                Container(
                    height: 1.6,
                    width: screenWidth(context) * 0.45,
                    color: Color(0xffDAA24A)),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Lass uns ein paar Produkte zu deinem Warenkorb hinzufügen. Wir werden sicherlich einiges finden, was dir gefallen kann.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 35),
                CupertinoButton(
                  color: CupertinoColors.activeBlue,
                  child: Text(
                    "Produkte entdecken",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20),
                    ),
                  ),
                  onPressed: model.goToKategorien,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _getViewWennNormal(
      WarenkorbDialogViewModel model, BuildContext context) {
    final bool _alreadyInCheckout = alreadyInCheckout ?? false;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.03),
        child: Column(
          children: [
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification? overscroll) {
                  overscroll!.disallowGlow();
                  return true;
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                        indent: 20,
                        endIndent: 20,
                        color: CupertinoColors.opaqueSeparator);
                  },
                  itemCount: model.warenkorbListe.length,
                  itemBuilder: (context, index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      height: model.checkIfExpanded(index)
                          ? model.warenkorbListe[index].anmerkung == null ||
                                  model.warenkorbListe[index].anmerkung == ""
                              ? screenHeight(context) * 0.2
                              : screenHeight(context) * 0.25
                          : model.warenkorbListe[index].anmerkung == null ||
                                  model.warenkorbListe[index].anmerkung == ""
                              ? screenHeight(context) * 0.13
                              : screenHeight(context) * 0.18,
                      child: Stack(
                        children: [
                          Positioned(
                            height: model.warenkorbListe[index].anmerkung ==
                                        null ||
                                    model.warenkorbListe[index].anmerkung == ""
                                ? screenHeight(context) * 0.13
                                : screenHeight(context) * 0.18,
                            width: screenWidth(context) * 0.94,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Badge(
                                            animationDuration:
                                                Duration(milliseconds: 100),
                                            animationType:
                                                BadgeAnimationType.scale,
                                            position: BadgePosition.bottomEnd(
                                                bottom: -7,
                                                end: model.warenkorbListe[index]
                                                            .anzahl >=
                                                        10
                                                    ? -4
                                                    : -10),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 6),
                                            shape: BadgeShape.square,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            elevation: 0,
                                            badgeColor:
                                                CupertinoColors.activeOrange,
                                            badgeContent: Text(
                                              model.warenkorbListe[index].anzahl
                                                  .toString(),
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(model
                                                      .warenkorbListe[index]
                                                      .produkt
                                                      .imageLink),
                                                ),
                                              ),
                                              height:
                                                  screenHeight(context) * 0.09,
                                              width:
                                                  screenHeight(context) * 0.09,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.warenkorbListe[index]
                                                      .name,
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                                model.getSubtitle(index),
                                                SizedBox(height: 5),
                                                GestureDetector(
                                                  onTap: () => model
                                                      .showAnmerkungBottomSheet(
                                                          index),
                                                  child: Text(
                                                    model.warenkorbListe[index]
                                                                    .anmerkung ==
                                                                null ||
                                                            model
                                                                    .warenkorbListe[
                                                                        index]
                                                                    .anmerkung ==
                                                                ""
                                                        ? "Anmerkung hinzufügen"
                                                        : "Anmerkung bearbeiten",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: CupertinoColors
                                                              .activeBlue,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(height: 5),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'eu', symbol: '€')
                                                  .format(
                                                model.warenkorbListe[index]
                                                        .endPreis *
                                                    model.warenkorbListe[index]
                                                        .anzahl,
                                              ),
                                              style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: GestureDetector(
                                                  onTap: () =>
                                                      model.expand(index),
                                                  child: model.checkIfExpanded(
                                                          index)
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .chevron_up,
                                                          size: 26)
                                                      : Icon(
                                                          CupertinoIcons
                                                              .chevron_down,
                                                          size: 26)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  if (model.warenkorbListe[index].anmerkung !=
                                          null &&
                                      model.warenkorbListe[index].anmerkung !=
                                          "")
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 8),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "\"${model.warenkorbListe[index].anmerkung!}\"",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey[700],
                                                fontWeight: FontWeight.w300,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            width: screenWidth(context) * 0.94,
                            height: screenHeight(context) * 0.07,
                            top: model.warenkorbListe[index].anmerkung ==
                                        null ||
                                    model.warenkorbListe[index].anmerkung == ""
                                ? screenHeight(context) * 0.13
                                : screenHeight(context) * 0.18,
                            child: Container(
                              child: model.checkIfExpanded(index)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey[700]!,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(4)),
                                          height: 45,
                                          width: screenWidth(context) * 0.35,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                onPressed: () =>
                                                    model.subtract(index),
                                                icon: Icon(CupertinoIcons.minus,
                                                    color: model
                                                        .evaluateColor(index)),
                                              ),
                                              Container(
                                                width: 24,
                                                child: Center(
                                                  child:
                                                      AnimatedSlideOdometerNumber(
                                                          numberTextStyle:
                                                              GoogleFonts
                                                                  .roboto(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                          odometerNumber:
                                                              OdometerNumber(model
                                                                  .warenkorbListe[
                                                                      index]
                                                                  .anzahl),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  100),
                                                          letterWidth: 10),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () =>
                                                    model.add(index),
                                                icon: Icon(CupertinoIcons.add,
                                                    color: model
                                                                .warenkorbListe[
                                                                    index]
                                                                .anzahl >=
                                                            68
                                                        ? Colors.grey
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () =>
                                                model.bearbeitung(index),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                height: 45,
                                                child: Center(
                                                  child: Text(
                                                    "Bearbeiten",
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: 0,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    )
                                  : SizedBox(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  if (model.pfandPreis != 0)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            "Davon Pfand: ${NumberFormat.currency(locale: 'eu', symbol: '€').format(model.pfandPreis)}",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  GestureDetector(
                      onTap: () {
                        if (_alreadyInCheckout) {
                          model.close();
                        } else {
                          if (!model.checkoutAllowed) {
                            print("Forbidden");
                          } else {
                            model.openCheckout();
                          }
                        }
                      },
                      child: _alreadyInCheckout
                          ? Container(
                              height: screenHeight(context) * 0.08,
                              decoration: BoxDecoration(
                                color: CupertinoColors.activeBlue,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.16),
                                    blurRadius: 6,
                                    offset: Offset(0, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Mit Bezahlung fortfahren",
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
                              ))
                          : CheckoutButton(
                              warenkorbPreis: model.warenkorbPreis,
                              checkoutAllowed: model.checkoutAllowed,
                            )),
                  SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 40,
                    child: Center(
                      child: Text(
                        model.checkoutAllowed
                            ? model.warenkorbPreis >= 10
                                ? "Kostenlose Lieferung"
                                : "Kostenlose Lieferung ab 10€"
                            : "Eine Bestellung ist bereits aktiv",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WarenkorbDialogViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: model.close,
                        icon: Icon(
                          CupertinoIcons.xmark,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: screenHeight(context) * 0.05,
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Warenkorb",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25),
                  ),
                ),
              ),
              Divider(
                color: CupertinoColors.opaqueSeparator,
                indent: screenWidth(context) * 0.15,
                endIndent: screenWidth(context) * 0.15,
              ),
              if (model.warenkorbListe.isEmpty) _getViewIfEmpty(model, context),
              if (model.warenkorbListe.isNotEmpty)
                _getViewWennNormal(model, context),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => WarenkorbDialogViewModel(),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  final double warenkorbPreis;
  final bool checkoutAllowed;
  const CheckoutButton({
    Key? key,
    required this.warenkorbPreis,
    this.checkoutAllowed = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.12,
      decoration: BoxDecoration(
        color: checkoutAllowed
            ? CupertinoColors.activeBlue
            : CupertinoColors.inactiveGray,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 6,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gesamtsumme",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                  ),
                  warenkorbPreis >= 10
                      ? Text(
                          NumberFormat.currency(locale: 'eu', symbol: '€')
                              .format(warenkorbPreis),
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          ),
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              NumberFormat.currency(locale: 'eu', symbol: '€')
                                  .format(warenkorbPreis),
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '(+1,00€)',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
              Icon(CupertinoIcons.chevron_right_circle,
                  color: Colors.white, size: screenHeight(context) * 0.06),
            ],
          )),
    );
  }
}
