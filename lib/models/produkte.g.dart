// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produkte.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Produkt _$_$_ProduktFromJson(Map<String, dynamic> json) {
  return _$_Produkt(
    name: json['name'] as String,
    subtitle: json['subtitle'] as String,
    price: (json['price'] as num).toDouble(),
    mengenAuswahl: (json['mengenAuswahl'] as List<dynamic>)
        .map((e) => MengenAuswahl.fromJson(e as Map<String, dynamic>))
        .toList(),
    auswahlAnzahl: json['auswahlAnzahl'] as int?,
    documentID: json['documentID'] as String? ?? 'NoID',
    imageLink: json['imageLink'] as String? ??
        'https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260',
    kategorie: json['kategorie'] as String? ?? 'Cocktails',
    mehrfachAuswahlVorhanden:
        json['mehrfachAuswahlVorhanden'] as bool? ?? false,
    kannPfandBecher: json['kannPfandBecher'] as bool? ?? false,
    alkoholhaltig: json['alkoholhaltig'] as bool? ?? false,
    auswahlElemente: (json['auswahlElemente'] as List<dynamic>?)
            ?.map((e) => AuswahlElement.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    allergene: (json['allergene'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    zusatzstoffe: (json['zusatzstoffe'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    zutatenListe: (json['zutatenListe'] as List<dynamic>?)
            ?.map((e) => Zutat.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    beschreibung: json['beschreibung'] as String? ??
        'Dieses Produkt ist wirklich unheimlich toll. Wirklich! Es ist sogar so großartig, dass hier wer verplant hat die richtige Beschreibung in die Datenbank einzutippen.',
  );
}

Map<String, dynamic> _$_$_ProduktToJson(_$_Produkt instance) =>
    <String, dynamic>{
      'name': instance.name,
      'subtitle': instance.subtitle,
      'price': instance.price,
      'mengenAuswahl': instance.mengenAuswahl,
      'auswahlAnzahl': instance.auswahlAnzahl,
      'documentID': instance.documentID,
      'imageLink': instance.imageLink,
      'kategorie': instance.kategorie,
      'mehrfachAuswahlVorhanden': instance.mehrfachAuswahlVorhanden,
      'kannPfandBecher': instance.kannPfandBecher,
      'alkoholhaltig': instance.alkoholhaltig,
      'auswahlElemente': instance.auswahlElemente,
      'allergene': instance.allergene,
      'zusatzstoffe': instance.zusatzstoffe,
      'zutatenListe': instance.zutatenListe,
      'beschreibung': instance.beschreibung,
    };

_$_AuswahlElement _$_$_AuswahlElementFromJson(Map<String, dynamic> json) {
  return _$_AuswahlElement(
    title: json['title'] as String,
    aufpreis: (json['aufpreis'] as num?)?.toDouble() ?? 0,
    standardAuswahl: json['standardAuswahl'] as bool? ?? false,
    alkoholhaltig: json['alkoholhaltig'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_AuswahlElementToJson(_$_AuswahlElement instance) =>
    <String, dynamic>{
      'title': instance.title,
      'aufpreis': instance.aufpreis,
      'standardAuswahl': instance.standardAuswahl,
      'alkoholhaltig': instance.alkoholhaltig,
    };

_$_MengenAuswahl _$_$_MengenAuswahlFromJson(Map<String, dynamic> json) {
  return _$_MengenAuswahl(
    title: json['title'] as String,
    aufpreis: (json['aufpreis'] as num?)?.toDouble() ?? 0,
    standardAuswahl: json['standardAuswahl'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_MengenAuswahlToJson(_$_MengenAuswahl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'aufpreis': instance.aufpreis,
      'standardAuswahl': instance.standardAuswahl,
    };

_$_Zutat _$_$_ZutatFromJson(Map<String, dynamic> json) {
  return _$_Zutat(
    title: json['title'] as String,
    subtitle: json['subtitle'] as String?,
  );
}

Map<String, dynamic> _$_$_ZutatToJson(_$_Zutat instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
    };

_$_Bestellung _$_$_BestellungFromJson(Map<String, dynamic> json) {
  return _$_Bestellung(
    deviceID: json['deviceID'] as String,
    bestellInhalt: (json['bestellInhalt'] as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList(),
    bestellZeitpunkt: json['bestellZeitpunkt'] == null
        ? null
        : DateTime.parse(json['bestellZeitpunkt'] as String),
    bezahlMethode: json['bezahlMethode'] as String?,
    name: json['name'] as String?,
    mail: json['mail'] as String?,
    phone: json['phone'] as String?,
    lieferHinweis: json['lieferHinweis'] as String?,
    gesamtPreis: (json['gesamtPreis'] as num?)?.toDouble(),
    bestellFortschritt: json['bestellFortschritt'] as String? ?? 'Vorbereitung',
    ab18: json['ab18'] as bool? ?? false,
    driverID: json['driverID'] as String?,
    zustellZeitpunkt: json['zustellZeitpunkt'] == null
        ? null
        : DateTime.parse(json['zustellZeitpunkt'] as String),
    ankunftsZeit: json['ankunftsZeit'] == null
        ? null
        : DateTime.parse(json['ankunftsZeit'] as String),
  );
}

Map<String, dynamic> _$_$_BestellungToJson(_$_Bestellung instance) =>
    <String, dynamic>{
      'deviceID': instance.deviceID,
      'bestellInhalt': instance.bestellInhalt,
      'bestellZeitpunkt': instance.bestellZeitpunkt?.toIso8601String(),
      'bezahlMethode': instance.bezahlMethode,
      'name': instance.name,
      'mail': instance.mail,
      'phone': instance.phone,
      'lieferHinweis': instance.lieferHinweis,
      'gesamtPreis': instance.gesamtPreis,
      'bestellFortschritt': instance.bestellFortschritt,
      'ab18': instance.ab18,
      'driverID': instance.driverID,
      'zustellZeitpunkt': instance.zustellZeitpunkt?.toIso8601String(),
      'ankunftsZeit': instance.ankunftsZeit?.toIso8601String(),
    };

_$_BestellElement _$_$_BestellElementFromJson(Map<String, dynamic> json) {
  return _$_BestellElement(
    title: json['title'] as String,
    anzahl: json['anzahl'] as int,
    pfand: json['pfand'] as bool? ?? false,
    mengenAuswahl: json['mengenAuswahl'] as String,
    auswahlTitle: json['auswahlTitle'] as String?,
    anmerkung: json['anmerkung'] as String?,
  );
}

Map<String, dynamic> _$_$_BestellElementToJson(_$_BestellElement instance) =>
    <String, dynamic>{
      'title': instance.title,
      'anzahl': instance.anzahl,
      'pfand': instance.pfand,
      'mengenAuswahl': instance.mengenAuswahl,
      'auswahlTitle': instance.auswahlTitle,
      'anmerkung': instance.anmerkung,
    };
