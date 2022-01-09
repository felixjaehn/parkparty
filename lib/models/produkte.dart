import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'produkte.freezed.dart';
part 'produkte.g.dart';

@freezed
class Produkt with _$Produkt {
  //Required for adding a custom field
  Produkt._();
  factory Produkt({
    required String name,
    required String subtitle,
    required double price,
    required List<MengenAuswahl> mengenAuswahl,
    int? auswahlAnzahl,
    @Default("NoID") String documentID,
    @Default("https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260")
        String imageLink,
    @Default("Cocktails") String kategorie,
    @Default(false) bool mehrfachAuswahlVorhanden,
    @Default(false) bool kannPfandBecher,
    @Default(false) bool alkoholhaltig,
    @Default([]) List<AuswahlElement> auswahlElemente,
    @Default([]) List<String> allergene,
    @Default([]) List<String> zusatzstoffe,
    @Default([]) List<Zutat> zutatenListe,
    @Default("Dieses Produkt ist wirklich unheimlich toll. Wirklich! Es ist sogar so großartig, dass hier wer verplant hat die richtige Beschreibung in die Datenbank einzutippen.")
        String beschreibung,
  }) = _Produkt;

  factory Produkt.fromJson(Map<String, dynamic> json) =>
      _$ProduktFromJson(json);

  ///Gibt die anfängliche Auswahl als Liste zurück. Optimalerweise hat die Liste nur ein Element.
  ///Es sollte aber auch geprüft werden ob die Liste leer ist bevor zugegriffen wird
  late final anfangsAuswahl =
      auswahlElemente.where((ae) => ae.standardAuswahl).toList();

  ///Gibt die anfängliche Mengenauswahl als Liste zurück. Optimalerweise hat die Liste nur ein Element.
  ///Es sollte aber auch geprüft werden ob die Liste leer ist bevor zugegriffen wird
  late final anfangsMenge =
      mengenAuswahl.where((ma) => ma.standardAuswahl).toList();
}

@freezed
class WarenkorbElement with _$WarenkorbElement {
  factory WarenkorbElement({
    required String name,
    required String subtitle,
    required double endPreis,
    required int anzahl,
    required Produkt produkt,
    String? anmerkung,
    List<AuswahlElement>? mehrfachAuswahl,
    AuswahlElement? endAuswahl,
    MengenAuswahl? mengenWahl,
    @Default(false) bool mehrfachAuswahlVorhanden,
    @Default(false) bool pfandAusgewaehlt,
  }) = _WarenkorbElement;
}

@freezed
class WarenkorbElementLight with _$WarenkorbElementLight {
  factory WarenkorbElementLight({
    required String name,
    List<AuswahlElement>? mehrfachAuswahl,
    AuswahlElement? endAuswahl,
    MengenAuswahl? mengenWahl,
    @Default(false) bool mehrfachAuswahlVorhanden,
    @Default(false) bool pfandAusgewaehlt,
  }) = _WarenkorbElementLight;
}

@freezed
class AuswahlElement with _$AuswahlElement {
  factory AuswahlElement({
    required String title,
    @Default(0) double aufpreis,
    @Default(false) bool standardAuswahl,
    @Default(false) bool alkoholhaltig,
  }) = _AuswahlElement;

  factory AuswahlElement.fromJson(Map<String, dynamic> json) =>
      _$AuswahlElementFromJson(json);
}

@freezed
class MengenAuswahl with _$MengenAuswahl {
  factory MengenAuswahl({
    required String title,
    @Default(0) double aufpreis,
    @Default(false) bool standardAuswahl,
  }) = _MengenAuswahl;

  factory MengenAuswahl.fromJson(Map<String, dynamic> json) =>
      _$MengenAuswahlFromJson(json);
}

@freezed
class Zutat with _$Zutat {
  factory Zutat({
    required String title,
    String? subtitle,
  }) = _Zutat;

  factory Zutat.fromJson(Map<String, dynamic> json) => _$ZutatFromJson(json);
}

@freezed
class Bestellung with _$Bestellung {
  Bestellung._();
  factory Bestellung({
    required String deviceID,
    required List<Map<String, dynamic>> bestellInhalt,
    DateTime? bestellZeitpunkt,
    String? bezahlMethode,
    String? name,
    String? mail,
    String? phone,
    String? lieferHinweis,
    double? gesamtPreis,
    @Default("Vorbereitung") String bestellFortschritt,
    @Default(false) bool ab18,
    String? driverID,
    DateTime? zustellZeitpunkt,
    DateTime? ankunftsZeit,
  }) = _Bestellung;

  factory Bestellung.fromJson(Map<String, dynamic> json) =>
      _$BestellungFromJson(json);
}

@freezed
class BestellElement with _$BestellElement {
  BestellElement._();
  factory BestellElement({
    required String title,
    required int anzahl,
    @Default(false) bool pfand,
    required String mengenAuswahl,
    String? auswahlTitle,
    String? anmerkung,
    
  }) = _BestellElement;

  factory BestellElement.fromJson(Map<String, dynamic> json) =>
      _$BestellElementFromJson(json);
}
