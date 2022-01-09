import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/models/produkte.dart';

import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';

class MehrfachAuswahlBottomSheetViewModel extends BaseViewModel {
  //dependency injection
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();

  int _produktAnzahl = 1;
  bool warnungPlus = false;
  bool warnungMinus = true;
  bool warnungAuswahlAnzahl = false;

  late Produkt _produkt;
  late WarenkorbElement _warenkorbElement;
  late WarenkorbElementLight _warenkorbElementLight;

  int get produktAnzahl => _produktAnzahl;

  double get warenkorbPreis => _warenkorbElement.endPreis;

  List<AuswahlElement> get mehrfachAuswahl =>
      _warenkorbElement.mehrfachAuswahl!;

  /// Hier werden die WarenkorbElemente und Hilfselemente erstellt
  void setUp(Produkt produkt) {
    _warenkorbElement = WarenkorbElement(
      name: produkt.name,
      subtitle: produkt.subtitle,
      anzahl: _produktAnzahl,
      mehrfachAuswahlVorhanden: true,
      mehrfachAuswahl: [],
      produkt: produkt,
      endPreis: produkt.price,
      mengenWahl: MengenAuswahl(title: "Platzhalter", aufpreis: 0),
      //endAuswahl: produkt.anfangsAuswahl[0],
    );
    _warenkorbElementLight = WarenkorbElementLight(
      name: produkt.name,
      mehrfachAuswahlVorhanden: true,
      mehrfachAuswahl: [],
      mengenWahl: MengenAuswahl(title: "Platzhalter", aufpreis: 0),
    );
    _produkt = produkt;
  }

  ///Hier wird die neu getroffene Auswahl verarbeitet
  ///Wenn die Auswahl bereits vorhanden ist wird sie entfernt
  ///Ansonsten wird sie hinzugefügt solange die maximale Anzahl noch nicht erreicht ist.
  bool addToAuswahl(AuswahlElement auswahlElement) {
    List<AuswahlElement> temp = _warenkorbElement.mehrfachAuswahl ?? [];
    final int _maxAnzahl = _produkt.auswahlAnzahl ?? 3;

    if (temp.contains(auswahlElement)) {
      warnungAuswahlAnzahl = false;
      temp.remove(auswahlElement);
    } else {
      if (temp.length < _maxAnzahl) {
        temp.add(auswahlElement);
      } else {
        warnungAuswahlAnzahl = true;
      }
    }
    temp.sort((a, b) => a.title.length.compareTo(b.title.length));

    _warenkorbElement = _warenkorbElement.copyWith(
      mehrfachAuswahl: temp,
    );

    _warenkorbElementLight = _warenkorbElementLight.copyWith(
      mehrfachAuswahl: temp,
    );
    notifyListeners();
    return false;
  }

  ///Diese Funktion dient dazu zum Abschluss des BottomSheets das WarenkorbElement zum Warenkorb hinzuzufügen
  void addToCart() {
    _warenkorbElement = _warenkorbElement.copyWith(anzahl: _produktAnzahl);
    if (!_warenkorbService.pruefeObVorhanden(
        _warenkorbElementLight, _warenkorbElement)) {
      _warenkorbService.addtoWarenkorb(
          _warenkorbElement, _warenkorbElementLight);
    }
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
