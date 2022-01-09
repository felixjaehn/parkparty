import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/ui/bottomsheets/views/produktauswahl/produktauswahl_bottomsheet_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'produktbearbeitung_viewmodel.dart';

class ProduktBearbeitungView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  final int index;
  const ProduktBearbeitungView({
    required this.index,
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  //Das hier beschriebene Widget wird als BottomSheet angezeigt
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProduktBearbeitungViewModel>.reactive(
      onModelReady: (model) => model.setUp(index),
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
                            produkt: model.produkt,
                            subtitle: model.subtitle(),
                            endPreis:
                                model.warenkorbPreis * model.produktAnzahl),
                        basicDivider,
                        if (model.aktuelleAuswahl != null)
                          AuswahlElemente(
                              produkt: model.produkt,
                              changeAuswahl: (ae, produkt) =>
                                  model.changeAuswahl(ae),
                              aktuelleAuswahl: model.aktuelleAuswahl),
                        MengenAuswahlWidget(
                          produkt: model.produkt,
                          aktuelleMenge: model.aktuelleMenge,
                          changeMenge: (ma, produkt) => model.changeMenge(ma),
                        ),
                        if (model.produkt.kannPfandBecher)
                          PfandAuswahlWidget(
                            pfandAuswahl: (val) => model.pfandBecherWahl(val),
                            pfandSelected: model.pfandSelected,
                          ),
                      ],
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
                                "Bestätigen",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            onPressed: () {
                              model.addToCart(index);
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
      viewModelBuilder: () => ProduktBearbeitungViewModel(),
    );
  }
}
