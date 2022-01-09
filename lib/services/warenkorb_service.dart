import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:stacked/stacked.dart';

class WarenkorbService with ReactiveServiceMixin {
  ReactiveValue<int> _warenkorbElemente = ReactiveValue<int>(0);
  int get warenkorbElemente => _warenkorbElemente.value;
  double get warenkorbPreis => _warenkorbPreis();
  double _pfandPreis = 1;
  List<WarenkorbElement> get warenkorb => _warenkorb;
  List<WarenkorbElementLight> get vergleichsHelfer => _vergleichsHelfer;
  bool alterBestaetigt = false;
  bool alkoholhaltig = false;

  List<WarenkorbElement> _warenkorb = [];
  List<WarenkorbElementLight> _vergleichsHelfer = [];

  void addAnmerkung(int index, String anmerkung) {
    _warenkorb[index] = _warenkorb[index].copyWith(anmerkung: anmerkung);
  }

  void removeAnmerkung(int index) {
    _warenkorb[index] = _warenkorb[index].copyWith(anmerkung: "");
    notifyListeners();
  }

  double getPfandPreis() {
    double _temp = 0;
    for (WarenkorbElement wE in _warenkorb) {
      if (wE.pfandAusgewaehlt) {
        _temp += _pfandPreis * wE.anzahl;
      }
    }
    return _temp;
  }

  bool get ab18 {
    for (WarenkorbElement wE in _warenkorb) {
      final bool auswahlAlkoholhaltig = wE.endAuswahl?.alkoholhaltig ?? false;
      if (wE.produkt.alkoholhaltig || auswahlAlkoholhaltig) {
        return true;
      }
    }
    return false;
  }

  void setAb18() {
    alterBestaetigt = true;
  }

  void removeAb18() {
    for (int i = 0; i <= _warenkorb.length; i++) {
      final bool auswahlAlkoholhaltig =
          _warenkorb[i].endAuswahl?.alkoholhaltig ?? false;
      if (_warenkorb[i].produkt.alkoholhaltig || auswahlAlkoholhaltig) {
        removeAtIndex(i);
      }
    }
  }

  void bearbeiteElement(int index, int anzahl) {
    _warenkorb[index] = _warenkorb[index].copyWith(anzahl: anzahl);
    alkoholhaltig = ab18;
    notifyListeners();
  }

  void removeAtIndex(int index) {
    _warenkorb.removeAt(index);
    _vergleichsHelfer.removeAt(index);
    _warenkorbElemente.value = _produktAnzahl();
    alkoholhaltig = ab18;
    notifyListeners();
  }

  int getItemIndex(WarenkorbElement wE) {
    return warenkorb.indexOf(wE);
  }

  void removeItem(WarenkorbElement wE) {
    int _index = _warenkorb.indexOf(wE);
    alkoholhaltig = ab18;
    removeAtIndex(_index);
  }

  void removeAlles() {
    _warenkorb.clear();
    _vergleichsHelfer.clear();
    _warenkorbElemente.value = 0;
    notifyListeners();
  }

  void allesUpdaten() {
    _warenkorbElemente.value = _produktAnzahl();
    notifyListeners();
  }

  ///Prüft ob selbes Objekt bereits vorhanden und ändert die Menge, falls dies der Fall ist. Gibt true zurück, wenn ersetzt wurde
  bool pruefeObVorhanden(WarenkorbElementLight warenkorbElementLight,
      WarenkorbElement warenkorbElement) {
    bool _mussErsetzen = false;
    int index = 0;
    //Wir gehen die Hilfsliste durch und prüfen ob bereits vorhanden.
    for (var i = 0; i < _vergleichsHelfer.length; i++) {
      if (warenkorbElementLight == _vergleichsHelfer[i]) {
        index = i;
        _mussErsetzen = true;
        break;
      }
    }
    //Wenn ein Objekt dieser Art noch nicht vorhanden ist, endet der Funktionsaufruf hier
    if (!_mussErsetzen) {
      return false;
    }
    //Wir berechnen die neue Anzahl
    int neueAnzahl = warenkorb[index].anzahl + warenkorbElement.anzahl;

    //Anhand dieser Anzahl wird das Objekt jetzt geupdatet
    _warenkorb[index] = _warenkorb[index].copyWith(anzahl: neueAnzahl);
    //Wir updaten ebenso den Produktzähler
    _warenkorbElemente.value = _produktAnzahl();
    return true;
  }

  void addtoWarenkorb(WarenkorbElement warenkorbElement,
      WarenkorbElementLight warenkorbElementLight) {
    _warenkorb.add(warenkorbElement);
    _warenkorbElemente.value = _produktAnzahl();
    _vergleichsHelfer.add(warenkorbElementLight);
    FirebaseAnalytics().logEvent(name: "add_to_warenkorb", parameters: {
      "anzahl": warenkorbElement.anzahl,
      "name": warenkorbElement.produkt.name
    });
    alkoholhaltig = ab18;
  }

  int _produktAnzahl() {
    int sum = 0;
    for (var i = 0; i < _warenkorb.length; i++) {
      sum += _warenkorb[i].anzahl;
    }
    return sum;
  }

  double _warenkorbPreis() {
    double sum = 0;
    for (var i = 0; i < _warenkorb.length; i++) {
      sum += _warenkorb[i].endPreis * _warenkorb[i].anzahl;
    }
    return sum;
  }

  WarenkorbService() {
    listenToReactiveValues([_warenkorbElemente]);
  }

//Reine UI Funktion
  ///Gibt die Untertitel zum WarenkorbElement anhand des Index im Warenkorb zurück
  Row getSubtitle(index) {
    double _kFontSize = 14;
    if (warenkorb[index].mehrfachAuswahlVorhanden) {
      return Row(
        children: warenkorb[index]
            .mehrfachAuswahl!
            .map((AuswahlElement auswahlElement) {
          final bool _showComma =
              warenkorb[index].mehrfachAuswahl!.indexOf(auswahlElement) !=
                  warenkorb[index].mehrfachAuswahl!.length - 1;
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
        if (warenkorb[index].pfandAusgewaehlt)
          Row(children: [
            Text(
              "P",
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
          warenkorb[index].endAuswahl == null
              ? ""
              : warenkorb[index].endAuswahl!.title,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
                color: Colors.grey[700]!,
                fontSize: _kFontSize,
                fontWeight: FontWeight.w400),
          ),
        ),
        if (warenkorb[index].endAuswahl != null)
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
          warenkorb[index].mengenWahl!.title,
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
}
