import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:flutter/material.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';

class ProduktBearbeitungViewModel extends BaseViewModel {
  //dependency injection
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();

  late bool warnungPlus;
  late bool warnungMinus;
  late bool pfandSelected;

  late int _produktAnzahl;
  late Produkt _produkt;
  late WarenkorbElement _warenkorbElement;
  late WarenkorbElementLight _warenkorbElementLight;

  int get produktAnzahl => _produktAnzahl;
  double get warenkorbPreis => _warenkorbElement.endPreis;
  WarenkorbElement get warenkorbElement => _warenkorbElement;
  Produkt get produkt => _produkt;

  dynamic get aktuelleAuswahl {
    if (_warenkorbElement.endAuswahl == null) {
      return null;
    }
    return _warenkorbElement.endAuswahl!;
  }

  MengenAuswahl get aktuelleMenge => _warenkorbElement.mengenWahl!;

  /// Hier werden die WarenkorbElemente und Hilfselemente erstellt
  void setUp(int index) {
    _warenkorbElement = _warenkorbService.warenkorb[index];
    _warenkorbElementLight = _warenkorbService.vergleichsHelfer[index];
    _produkt = _warenkorbElement.produkt;
    _produktAnzahl = _warenkorbElement.anzahl;
    warnungMinus = _warenkorbElement.anzahl == 1;
    warnungPlus = _warenkorbElement.anzahl == 69;
    pfandSelected = _warenkorbElement.pfandAusgewaehlt;
  }

  ///Hier wird die neu getroffene Auswahl verarbeitet
  bool changeAuswahl(AuswahlElement auswahlElement) {
    final double _pfandPreis = _warenkorbElement.pfandAusgewaehlt ? 1 : 0;
    _warenkorbElement = _warenkorbElement.copyWith(
        endAuswahl: auswahlElement,
        endPreis: produkt.price +
            _warenkorbElement.mengenWahl!.aufpreis +
            _pfandPreis +
            auswahlElement.aufpreis);
    _warenkorbElementLight =
        _warenkorbElementLight.copyWith(endAuswahl: auswahlElement);
    notifyListeners();
    return false;
  }

  ///Hier wird die gewählte Menge angepasst
  bool changeMenge(MengenAuswahl mengenAuswahl) {
    final double _pfandPreis = _warenkorbElement.pfandAusgewaehlt ? 1 : 0;
    _warenkorbElement = _warenkorbElement.copyWith(
        mengenWahl: mengenAuswahl,
        endPreis: produkt.price +
            _warenkorbElement.endAuswahl!.aufpreis +
            _pfandPreis +
            mengenAuswahl.aufpreis);
    _warenkorbElementLight =
        _warenkorbElementLight.copyWith(mengenWahl: mengenAuswahl);
    notifyListeners();
    return false;
  }

  ///Diese Funktion berechnet den Preis des Warenkorbprodukts anhand der Aufpreise der Auswahl
  double preisBerechnen() {
    return _produkt.price +
        _warenkorbElement.endAuswahl!.aufpreis +
        _warenkorbElement.mengenWahl!.aufpreis;
  }

  ///Diese Funktion dient dazu zum Abschluss des BottomSheets das WarenkorbElement zum Warenkorb hinzuzufügen
  void addToCart(index) {
    _warenkorbService.removeAtIndex(index);
    _warenkorbElement = _warenkorbElement.copyWith(anzahl: _produktAnzahl);
    if (!_warenkorbService.pruefeObVorhanden(
        _warenkorbElementLight, _warenkorbElement)) {
      _warenkorbService.addtoWarenkorb(
          _warenkorbElement, _warenkorbElementLight);
    }
  }

  void pfandBecherWahl(bool auswahl) {
    pfandSelected = auswahl;
    final double _pfandPreis = auswahl ? 1 : 0;
    final double _auswahlPreis = _warenkorbElement.endAuswahl == null
        ? 0
        : _warenkorbElement.endAuswahl!.aufpreis;
    _warenkorbElement = _warenkorbElement.copyWith(
        pfandAusgewaehlt: auswahl,
        endPreis: _produkt.price +
            _auswahlPreis +
            _pfandPreis +
            _warenkorbElement.mengenWahl!.aufpreis);
    _warenkorbElementLight = _warenkorbElementLight.copyWith(
      pfandAusgewaehlt: auswahl,
    );
    notifyListeners();
  }

  ///Diese Funktion evaluiert den Untertitel anhand der getroffenen Auswahl
  Row subtitle() {
    double _kFontSize = 14;
    if (_warenkorbElement.mehrfachAuswahlVorhanden) {
      return Row(
        children: _warenkorbElement.mehrfachAuswahl!
            .map((AuswahlElement auswahlElement) {
          final bool _showComma =
              _warenkorbElement.mehrfachAuswahl!.indexOf(auswahlElement) !=
                  _warenkorbElement.mehrfachAuswahl!.length - 1;
          return Text(
            _showComma ? "${auswahlElement.title}, " : auswahlElement.title,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                  color: Colors.grey[700]!,
                  fontSize: _kFontSize,
                  fontWeight: FontWeight.w400),
            ),
          );
        }).toList(),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (_warenkorbElement.pfandAusgewaehlt)
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
          _warenkorbElement.endAuswahl == null
              ? ""
              : _warenkorbElement.endAuswahl!.title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[700]!,
                fontSize: _kFontSize,
                fontWeight: FontWeight.w400),
          ),
        ),
        if (_warenkorbElement.endAuswahl != null)
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
          _warenkorbElement.mengenWahl!.title,
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

  ///Diese Funktion verändert die gewählte Menge unter Beachtung der gegebenen Grenzen
  void add() {
    if (_produktAnzahl < 69) _produktAnzahl += 1;
    if (_plusWarnung()) {
      warnungPlus = true;
    }
    if (!_minusWarnung()) {
      warnungMinus = false;
    }

    notifyListeners();
  }

  void subtract() {
    if (produktAnzahl > 1) _produktAnzahl -= 1;
    if (_minusWarnung()) {
      warnungMinus = true;
    }
    if (!_plusWarnung()) {
      warnungPlus = false;
    }
    notifyListeners();
  }

  bool _plusWarnung() {
    if (_produktAnzahl == 69) {
      return true;
    }
    return false;
  }

  bool _minusWarnung() {
    if (_produktAnzahl == 1) {
      return true;
    }
    return false;
  }
}
