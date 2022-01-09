import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/payment_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VerfuegbarkeitViewModel extends BaseViewModel {
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final PaymentService _paymentService = locator<PaymentService>();
  final NavigationService _navigationService = locator<NavigationService>();

  late double _alterEndPreis = _warenkorbService.warenkorbPreis;
  double get alterPreis => _alterEndPreis;
  double get neuerPreis => _warenkorbService.warenkorbPreis;
  bool get erfolgreich => _erfolgreich();
  int get warenkorbLength => _warenkorbService.warenkorb.length;
  bool warnungPlus = true;
  bool warnungMinus = false;
  List<int> anzahlen = [];
  List<int> verfuegbar = [];
  List<int> indizes = [];
  List<WarenkorbElement> warenkorb = [];

  void setUp(dynamic input) {
    for (dynamic e in input["list"]) {
      anzahlen.add(e["warenkorbElement"].anzahl);
      verfuegbar.add(e["verfuegbar"]);
      warenkorb.add(e["warenkorbElement"]);
    }
    for (WarenkorbElement wE in warenkorb) {
      indizes.add(_warenkorbService.getItemIndex(wE));
    }
  }

  void goToKategorien() {
    _navigationService.clearTillFirstAndShow(
      Routes.kategorienView,
    );
  }

  void executePayment(String ausgewaehlteZahlung) async {
    setBusy(true);
    await _paymentService.executePayment(
        ausgewaehlteZahlung, null, null, null, null, false);
    setBusy(false);
  }

  bool verfuegbareAnzahl(index) {
    return anzahlen[index] <= verfuegbar[index];
  }

  bool _erfolgreich() {
    bool _temp = true;
    for (int i = 0; i <= anzahlen.length - 1; i++) {
      if (anzahlen[i] > verfuegbar[i]) _temp = false;
    }
    return _temp;
  }

  Row getSubtitle(WarenkorbElement wE) {
    double _kFontSize = 14;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (wE.pfandAusgewaehlt)
          Row(children: [
            Text(
              "Pfand",
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.grey[700]!,
                    fontSize: _kFontSize,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(width: 3),
            Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                  color: Colors.grey[700]!, shape: BoxShape.circle),
            ),
            SizedBox(width: 3),
          ]),
        Text(
          wE.endAuswahl == null ? "" : wE.endAuswahl!.title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[700]!,
                fontSize: _kFontSize,
                fontWeight: FontWeight.w400),
          ),
        ),
        if (wE.endAuswahl != null)
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
          wE.mengenWahl!.title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[700]!,
                fontSize: _kFontSize,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  String getZahlungsmethodenText(String ausgewaehlteZahlung) {
    switch (ausgewaehlteZahlung) {
      case "Credit":
        return "mit Karte bezahlen";
      case "PayPal":
        return "mit PayPal bezahlen";
      case "Barzahlung":
        return "bei Erhalt bezahlen";
      case "GooglePay":
        return "mit GooglePay bezahlen";
      default:
        return "Bezahlen";
    }
  }

  void addToCart(int index) {
    int warenkorbIndex = indizes[index];
    _warenkorbService.bearbeiteElement(warenkorbIndex, anzahlen[index]);
  }

  void removeElement(int index) {
    _warenkorbService.removeAtIndex(indizes[index]);
    warenkorb.removeAt(index);
    anzahlen.removeAt(index);
    verfuegbar.removeAt(index);
    indizes.removeAt(index);
    notifyListeners();
  }

  ///Diese Funktion verändert die gewählte Menge unter Beachtung der gegebenen Grenzen
  void add(int index) {
    if (anzahlen[index] < verfuegbar[index]) {
      anzahlen[index] += 1;
      addToCart(index);
    }
    if (_plusWarnung(index)) {
      warnungPlus = true;
    }
    if (!_minusWarnung(index)) {
      warnungMinus = false;
    }

    notifyListeners();
  }

  void subtract(int index) {
    if (anzahlen[index] > 1) {
      anzahlen[index] -= 1;
      addToCart(index);
    }
    if (_minusWarnung(index)) {
      warnungMinus = true;
    }
    if (!_plusWarnung(index)) {
      warnungPlus = false;
    }
    notifyListeners();
  }

  bool _plusWarnung(int index) {
    if (anzahlen[index] >= verfuegbar[index]) {
      warnungPlus = true;
      notifyListeners();
      return true;
    }
    warnungPlus = false;
    notifyListeners();
    return false;
  }

  bool _minusWarnung(int index) {
    if (anzahlen[index] == 1) {
      warnungMinus = true;
      notifyListeners();
      return true;
    }
    return false;
  }
}
