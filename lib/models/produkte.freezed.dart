// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'produkte.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Produkt _$ProduktFromJson(Map<String, dynamic> json) {
  return _Produkt.fromJson(json);
}

/// @nodoc
class _$ProduktTearOff {
  const _$ProduktTearOff();

  _Produkt call(
      {required String name,
      required String subtitle,
      required double price,
      required List<MengenAuswahl> mengenAuswahl,
      int? auswahlAnzahl,
      String documentID = "NoID",
      String imageLink =
          "https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
      String kategorie = "Cocktails",
      bool mehrfachAuswahlVorhanden = false,
      bool kannPfandBecher = false,
      bool alkoholhaltig = false,
      List<AuswahlElement> auswahlElemente = const [],
      List<String> allergene = const [],
      List<String> zusatzstoffe = const [],
      List<Zutat> zutatenListe = const [],
      String beschreibung =
          "Dieses Produkt ist wirklich unheimlich toll. Wirklich! Es ist sogar so großartig, dass hier wer verplant hat die richtige Beschreibung in die Datenbank einzutippen."}) {
    return _Produkt(
      name: name,
      subtitle: subtitle,
      price: price,
      mengenAuswahl: mengenAuswahl,
      auswahlAnzahl: auswahlAnzahl,
      documentID: documentID,
      imageLink: imageLink,
      kategorie: kategorie,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden,
      kannPfandBecher: kannPfandBecher,
      alkoholhaltig: alkoholhaltig,
      auswahlElemente: auswahlElemente,
      allergene: allergene,
      zusatzstoffe: zusatzstoffe,
      zutatenListe: zutatenListe,
      beschreibung: beschreibung,
    );
  }

  Produkt fromJson(Map<String, Object> json) {
    return Produkt.fromJson(json);
  }
}

/// @nodoc
const $Produkt = _$ProduktTearOff();

/// @nodoc
mixin _$Produkt {
  String get name => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  List<MengenAuswahl> get mengenAuswahl => throw _privateConstructorUsedError;
  int? get auswahlAnzahl => throw _privateConstructorUsedError;
  String get documentID => throw _privateConstructorUsedError;
  String get imageLink => throw _privateConstructorUsedError;
  String get kategorie => throw _privateConstructorUsedError;
  bool get mehrfachAuswahlVorhanden => throw _privateConstructorUsedError;
  bool get kannPfandBecher => throw _privateConstructorUsedError;
  bool get alkoholhaltig => throw _privateConstructorUsedError;
  List<AuswahlElement> get auswahlElemente =>
      throw _privateConstructorUsedError;
  List<String> get allergene => throw _privateConstructorUsedError;
  List<String> get zusatzstoffe => throw _privateConstructorUsedError;
  List<Zutat> get zutatenListe => throw _privateConstructorUsedError;
  String get beschreibung => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProduktCopyWith<Produkt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProduktCopyWith<$Res> {
  factory $ProduktCopyWith(Produkt value, $Res Function(Produkt) then) =
      _$ProduktCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String subtitle,
      double price,
      List<MengenAuswahl> mengenAuswahl,
      int? auswahlAnzahl,
      String documentID,
      String imageLink,
      String kategorie,
      bool mehrfachAuswahlVorhanden,
      bool kannPfandBecher,
      bool alkoholhaltig,
      List<AuswahlElement> auswahlElemente,
      List<String> allergene,
      List<String> zusatzstoffe,
      List<Zutat> zutatenListe,
      String beschreibung});
}

/// @nodoc
class _$ProduktCopyWithImpl<$Res> implements $ProduktCopyWith<$Res> {
  _$ProduktCopyWithImpl(this._value, this._then);

  final Produkt _value;
  // ignore: unused_field
  final $Res Function(Produkt) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? subtitle = freezed,
    Object? price = freezed,
    Object? mengenAuswahl = freezed,
    Object? auswahlAnzahl = freezed,
    Object? documentID = freezed,
    Object? imageLink = freezed,
    Object? kategorie = freezed,
    Object? mehrfachAuswahlVorhanden = freezed,
    Object? kannPfandBecher = freezed,
    Object? alkoholhaltig = freezed,
    Object? auswahlElemente = freezed,
    Object? allergene = freezed,
    Object? zusatzstoffe = freezed,
    Object? zutatenListe = freezed,
    Object? beschreibung = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      mengenAuswahl: mengenAuswahl == freezed
          ? _value.mengenAuswahl
          : mengenAuswahl // ignore: cast_nullable_to_non_nullable
              as List<MengenAuswahl>,
      auswahlAnzahl: auswahlAnzahl == freezed
          ? _value.auswahlAnzahl
          : auswahlAnzahl // ignore: cast_nullable_to_non_nullable
              as int?,
      documentID: documentID == freezed
          ? _value.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as String,
      imageLink: imageLink == freezed
          ? _value.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String,
      kategorie: kategorie == freezed
          ? _value.kategorie
          : kategorie // ignore: cast_nullable_to_non_nullable
              as String,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden == freezed
          ? _value.mehrfachAuswahlVorhanden
          : mehrfachAuswahlVorhanden // ignore: cast_nullable_to_non_nullable
              as bool,
      kannPfandBecher: kannPfandBecher == freezed
          ? _value.kannPfandBecher
          : kannPfandBecher // ignore: cast_nullable_to_non_nullable
              as bool,
      alkoholhaltig: alkoholhaltig == freezed
          ? _value.alkoholhaltig
          : alkoholhaltig // ignore: cast_nullable_to_non_nullable
              as bool,
      auswahlElemente: auswahlElemente == freezed
          ? _value.auswahlElemente
          : auswahlElemente // ignore: cast_nullable_to_non_nullable
              as List<AuswahlElement>,
      allergene: allergene == freezed
          ? _value.allergene
          : allergene // ignore: cast_nullable_to_non_nullable
              as List<String>,
      zusatzstoffe: zusatzstoffe == freezed
          ? _value.zusatzstoffe
          : zusatzstoffe // ignore: cast_nullable_to_non_nullable
              as List<String>,
      zutatenListe: zutatenListe == freezed
          ? _value.zutatenListe
          : zutatenListe // ignore: cast_nullable_to_non_nullable
              as List<Zutat>,
      beschreibung: beschreibung == freezed
          ? _value.beschreibung
          : beschreibung // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ProduktCopyWith<$Res> implements $ProduktCopyWith<$Res> {
  factory _$ProduktCopyWith(_Produkt value, $Res Function(_Produkt) then) =
      __$ProduktCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String subtitle,
      double price,
      List<MengenAuswahl> mengenAuswahl,
      int? auswahlAnzahl,
      String documentID,
      String imageLink,
      String kategorie,
      bool mehrfachAuswahlVorhanden,
      bool kannPfandBecher,
      bool alkoholhaltig,
      List<AuswahlElement> auswahlElemente,
      List<String> allergene,
      List<String> zusatzstoffe,
      List<Zutat> zutatenListe,
      String beschreibung});
}

/// @nodoc
class __$ProduktCopyWithImpl<$Res> extends _$ProduktCopyWithImpl<$Res>
    implements _$ProduktCopyWith<$Res> {
  __$ProduktCopyWithImpl(_Produkt _value, $Res Function(_Produkt) _then)
      : super(_value, (v) => _then(v as _Produkt));

  @override
  _Produkt get _value => super._value as _Produkt;

  @override
  $Res call({
    Object? name = freezed,
    Object? subtitle = freezed,
    Object? price = freezed,
    Object? mengenAuswahl = freezed,
    Object? auswahlAnzahl = freezed,
    Object? documentID = freezed,
    Object? imageLink = freezed,
    Object? kategorie = freezed,
    Object? mehrfachAuswahlVorhanden = freezed,
    Object? kannPfandBecher = freezed,
    Object? alkoholhaltig = freezed,
    Object? auswahlElemente = freezed,
    Object? allergene = freezed,
    Object? zusatzstoffe = freezed,
    Object? zutatenListe = freezed,
    Object? beschreibung = freezed,
  }) {
    return _then(_Produkt(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      price: price == freezed
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      mengenAuswahl: mengenAuswahl == freezed
          ? _value.mengenAuswahl
          : mengenAuswahl // ignore: cast_nullable_to_non_nullable
              as List<MengenAuswahl>,
      auswahlAnzahl: auswahlAnzahl == freezed
          ? _value.auswahlAnzahl
          : auswahlAnzahl // ignore: cast_nullable_to_non_nullable
              as int?,
      documentID: documentID == freezed
          ? _value.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as String,
      imageLink: imageLink == freezed
          ? _value.imageLink
          : imageLink // ignore: cast_nullable_to_non_nullable
              as String,
      kategorie: kategorie == freezed
          ? _value.kategorie
          : kategorie // ignore: cast_nullable_to_non_nullable
              as String,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden == freezed
          ? _value.mehrfachAuswahlVorhanden
          : mehrfachAuswahlVorhanden // ignore: cast_nullable_to_non_nullable
              as bool,
      kannPfandBecher: kannPfandBecher == freezed
          ? _value.kannPfandBecher
          : kannPfandBecher // ignore: cast_nullable_to_non_nullable
              as bool,
      alkoholhaltig: alkoholhaltig == freezed
          ? _value.alkoholhaltig
          : alkoholhaltig // ignore: cast_nullable_to_non_nullable
              as bool,
      auswahlElemente: auswahlElemente == freezed
          ? _value.auswahlElemente
          : auswahlElemente // ignore: cast_nullable_to_non_nullable
              as List<AuswahlElement>,
      allergene: allergene == freezed
          ? _value.allergene
          : allergene // ignore: cast_nullable_to_non_nullable
              as List<String>,
      zusatzstoffe: zusatzstoffe == freezed
          ? _value.zusatzstoffe
          : zusatzstoffe // ignore: cast_nullable_to_non_nullable
              as List<String>,
      zutatenListe: zutatenListe == freezed
          ? _value.zutatenListe
          : zutatenListe // ignore: cast_nullable_to_non_nullable
              as List<Zutat>,
      beschreibung: beschreibung == freezed
          ? _value.beschreibung
          : beschreibung // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Produkt extends _Produkt with DiagnosticableTreeMixin {
  _$_Produkt(
      {required this.name,
      required this.subtitle,
      required this.price,
      required this.mengenAuswahl,
      this.auswahlAnzahl,
      this.documentID = "NoID",
      this.imageLink =
          "https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260",
      this.kategorie = "Cocktails",
      this.mehrfachAuswahlVorhanden = false,
      this.kannPfandBecher = false,
      this.alkoholhaltig = false,
      this.auswahlElemente = const [],
      this.allergene = const [],
      this.zusatzstoffe = const [],
      this.zutatenListe = const [],
      this.beschreibung =
          "Dieses Produkt ist wirklich unheimlich toll. Wirklich! Es ist sogar so großartig, dass hier wer verplant hat die richtige Beschreibung in die Datenbank einzutippen."})
      : super._();

  factory _$_Produkt.fromJson(Map<String, dynamic> json) =>
      _$_$_ProduktFromJson(json);

  @override
  final String name;
  @override
  final String subtitle;
  @override
  final double price;
  @override
  final List<MengenAuswahl> mengenAuswahl;
  @override
  final int? auswahlAnzahl;
  @JsonKey(defaultValue: "NoID")
  @override
  final String documentID;
  @JsonKey(
      defaultValue:
          "https://images.pexels.com/photos/338713/pexels-photo-338713.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260")
  @override
  final String imageLink;
  @JsonKey(defaultValue: "Cocktails")
  @override
  final String kategorie;
  @JsonKey(defaultValue: false)
  @override
  final bool mehrfachAuswahlVorhanden;
  @JsonKey(defaultValue: false)
  @override
  final bool kannPfandBecher;
  @JsonKey(defaultValue: false)
  @override
  final bool alkoholhaltig;
  @JsonKey(defaultValue: const [])
  @override
  final List<AuswahlElement> auswahlElemente;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> allergene;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> zusatzstoffe;
  @JsonKey(defaultValue: const [])
  @override
  final List<Zutat> zutatenListe;
  @JsonKey(
      defaultValue:
          "Dieses Produkt ist wirklich unheimlich toll. Wirklich! Es ist sogar so großartig, dass hier wer verplant hat die richtige Beschreibung in die Datenbank einzutippen.")
  @override
  final String beschreibung;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Produkt(name: $name, subtitle: $subtitle, price: $price, mengenAuswahl: $mengenAuswahl, auswahlAnzahl: $auswahlAnzahl, documentID: $documentID, imageLink: $imageLink, kategorie: $kategorie, mehrfachAuswahlVorhanden: $mehrfachAuswahlVorhanden, kannPfandBecher: $kannPfandBecher, alkoholhaltig: $alkoholhaltig, auswahlElemente: $auswahlElemente, allergene: $allergene, zusatzstoffe: $zusatzstoffe, zutatenListe: $zutatenListe, beschreibung: $beschreibung)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Produkt'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('mengenAuswahl', mengenAuswahl))
      ..add(DiagnosticsProperty('auswahlAnzahl', auswahlAnzahl))
      ..add(DiagnosticsProperty('documentID', documentID))
      ..add(DiagnosticsProperty('imageLink', imageLink))
      ..add(DiagnosticsProperty('kategorie', kategorie))
      ..add(DiagnosticsProperty(
          'mehrfachAuswahlVorhanden', mehrfachAuswahlVorhanden))
      ..add(DiagnosticsProperty('kannPfandBecher', kannPfandBecher))
      ..add(DiagnosticsProperty('alkoholhaltig', alkoholhaltig))
      ..add(DiagnosticsProperty('auswahlElemente', auswahlElemente))
      ..add(DiagnosticsProperty('allergene', allergene))
      ..add(DiagnosticsProperty('zusatzstoffe', zusatzstoffe))
      ..add(DiagnosticsProperty('zutatenListe', zutatenListe))
      ..add(DiagnosticsProperty('beschreibung', beschreibung));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Produkt &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)) &&
            (identical(other.price, price) ||
                const DeepCollectionEquality().equals(other.price, price)) &&
            (identical(other.mengenAuswahl, mengenAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.mengenAuswahl, mengenAuswahl)) &&
            (identical(other.auswahlAnzahl, auswahlAnzahl) ||
                const DeepCollectionEquality()
                    .equals(other.auswahlAnzahl, auswahlAnzahl)) &&
            (identical(other.documentID, documentID) ||
                const DeepCollectionEquality()
                    .equals(other.documentID, documentID)) &&
            (identical(other.imageLink, imageLink) ||
                const DeepCollectionEquality()
                    .equals(other.imageLink, imageLink)) &&
            (identical(other.kategorie, kategorie) ||
                const DeepCollectionEquality()
                    .equals(other.kategorie, kategorie)) &&
            (identical(
                    other.mehrfachAuswahlVorhanden, mehrfachAuswahlVorhanden) ||
                const DeepCollectionEquality().equals(
                    other.mehrfachAuswahlVorhanden,
                    mehrfachAuswahlVorhanden)) &&
            (identical(other.kannPfandBecher, kannPfandBecher) ||
                const DeepCollectionEquality()
                    .equals(other.kannPfandBecher, kannPfandBecher)) &&
            (identical(other.alkoholhaltig, alkoholhaltig) ||
                const DeepCollectionEquality()
                    .equals(other.alkoholhaltig, alkoholhaltig)) &&
            (identical(other.auswahlElemente, auswahlElemente) ||
                const DeepCollectionEquality()
                    .equals(other.auswahlElemente, auswahlElemente)) &&
            (identical(other.allergene, allergene) ||
                const DeepCollectionEquality()
                    .equals(other.allergene, allergene)) &&
            (identical(other.zusatzstoffe, zusatzstoffe) ||
                const DeepCollectionEquality()
                    .equals(other.zusatzstoffe, zusatzstoffe)) &&
            (identical(other.zutatenListe, zutatenListe) ||
                const DeepCollectionEquality()
                    .equals(other.zutatenListe, zutatenListe)) &&
            (identical(other.beschreibung, beschreibung) ||
                const DeepCollectionEquality()
                    .equals(other.beschreibung, beschreibung)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(subtitle) ^
      const DeepCollectionEquality().hash(price) ^
      const DeepCollectionEquality().hash(mengenAuswahl) ^
      const DeepCollectionEquality().hash(auswahlAnzahl) ^
      const DeepCollectionEquality().hash(documentID) ^
      const DeepCollectionEquality().hash(imageLink) ^
      const DeepCollectionEquality().hash(kategorie) ^
      const DeepCollectionEquality().hash(mehrfachAuswahlVorhanden) ^
      const DeepCollectionEquality().hash(kannPfandBecher) ^
      const DeepCollectionEquality().hash(alkoholhaltig) ^
      const DeepCollectionEquality().hash(auswahlElemente) ^
      const DeepCollectionEquality().hash(allergene) ^
      const DeepCollectionEquality().hash(zusatzstoffe) ^
      const DeepCollectionEquality().hash(zutatenListe) ^
      const DeepCollectionEquality().hash(beschreibung);

  @JsonKey(ignore: true)
  @override
  _$ProduktCopyWith<_Produkt> get copyWith =>
      __$ProduktCopyWithImpl<_Produkt>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ProduktToJson(this);
  }
}

abstract class _Produkt extends Produkt {
  factory _Produkt(
      {required String name,
      required String subtitle,
      required double price,
      required List<MengenAuswahl> mengenAuswahl,
      int? auswahlAnzahl,
      String documentID,
      String imageLink,
      String kategorie,
      bool mehrfachAuswahlVorhanden,
      bool kannPfandBecher,
      bool alkoholhaltig,
      List<AuswahlElement> auswahlElemente,
      List<String> allergene,
      List<String> zusatzstoffe,
      List<Zutat> zutatenListe,
      String beschreibung}) = _$_Produkt;
  _Produkt._() : super._();

  factory _Produkt.fromJson(Map<String, dynamic> json) = _$_Produkt.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get subtitle => throw _privateConstructorUsedError;
  @override
  double get price => throw _privateConstructorUsedError;
  @override
  List<MengenAuswahl> get mengenAuswahl => throw _privateConstructorUsedError;
  @override
  int? get auswahlAnzahl => throw _privateConstructorUsedError;
  @override
  String get documentID => throw _privateConstructorUsedError;
  @override
  String get imageLink => throw _privateConstructorUsedError;
  @override
  String get kategorie => throw _privateConstructorUsedError;
  @override
  bool get mehrfachAuswahlVorhanden => throw _privateConstructorUsedError;
  @override
  bool get kannPfandBecher => throw _privateConstructorUsedError;
  @override
  bool get alkoholhaltig => throw _privateConstructorUsedError;
  @override
  List<AuswahlElement> get auswahlElemente =>
      throw _privateConstructorUsedError;
  @override
  List<String> get allergene => throw _privateConstructorUsedError;
  @override
  List<String> get zusatzstoffe => throw _privateConstructorUsedError;
  @override
  List<Zutat> get zutatenListe => throw _privateConstructorUsedError;
  @override
  String get beschreibung => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ProduktCopyWith<_Produkt> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$WarenkorbElementTearOff {
  const _$WarenkorbElementTearOff();

  _WarenkorbElement call(
      {required String name,
      required String subtitle,
      required double endPreis,
      required int anzahl,
      required Produkt produkt,
      String? anmerkung,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden = false,
      bool pfandAusgewaehlt = false}) {
    return _WarenkorbElement(
      name: name,
      subtitle: subtitle,
      endPreis: endPreis,
      anzahl: anzahl,
      produkt: produkt,
      anmerkung: anmerkung,
      mehrfachAuswahl: mehrfachAuswahl,
      endAuswahl: endAuswahl,
      mengenWahl: mengenWahl,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden,
      pfandAusgewaehlt: pfandAusgewaehlt,
    );
  }
}

/// @nodoc
const $WarenkorbElement = _$WarenkorbElementTearOff();

/// @nodoc
mixin _$WarenkorbElement {
  String get name => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  double get endPreis => throw _privateConstructorUsedError;
  int get anzahl => throw _privateConstructorUsedError;
  Produkt get produkt => throw _privateConstructorUsedError;
  String? get anmerkung => throw _privateConstructorUsedError;
  List<AuswahlElement>? get mehrfachAuswahl =>
      throw _privateConstructorUsedError;
  AuswahlElement? get endAuswahl => throw _privateConstructorUsedError;
  MengenAuswahl? get mengenWahl => throw _privateConstructorUsedError;
  bool get mehrfachAuswahlVorhanden => throw _privateConstructorUsedError;
  bool get pfandAusgewaehlt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WarenkorbElementCopyWith<WarenkorbElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarenkorbElementCopyWith<$Res> {
  factory $WarenkorbElementCopyWith(
          WarenkorbElement value, $Res Function(WarenkorbElement) then) =
      _$WarenkorbElementCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String subtitle,
      double endPreis,
      int anzahl,
      Produkt produkt,
      String? anmerkung,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden,
      bool pfandAusgewaehlt});

  $ProduktCopyWith<$Res> get produkt;
  $AuswahlElementCopyWith<$Res>? get endAuswahl;
  $MengenAuswahlCopyWith<$Res>? get mengenWahl;
}

/// @nodoc
class _$WarenkorbElementCopyWithImpl<$Res>
    implements $WarenkorbElementCopyWith<$Res> {
  _$WarenkorbElementCopyWithImpl(this._value, this._then);

  final WarenkorbElement _value;
  // ignore: unused_field
  final $Res Function(WarenkorbElement) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? subtitle = freezed,
    Object? endPreis = freezed,
    Object? anzahl = freezed,
    Object? produkt = freezed,
    Object? anmerkung = freezed,
    Object? mehrfachAuswahl = freezed,
    Object? endAuswahl = freezed,
    Object? mengenWahl = freezed,
    Object? mehrfachAuswahlVorhanden = freezed,
    Object? pfandAusgewaehlt = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      endPreis: endPreis == freezed
          ? _value.endPreis
          : endPreis // ignore: cast_nullable_to_non_nullable
              as double,
      anzahl: anzahl == freezed
          ? _value.anzahl
          : anzahl // ignore: cast_nullable_to_non_nullable
              as int,
      produkt: produkt == freezed
          ? _value.produkt
          : produkt // ignore: cast_nullable_to_non_nullable
              as Produkt,
      anmerkung: anmerkung == freezed
          ? _value.anmerkung
          : anmerkung // ignore: cast_nullable_to_non_nullable
              as String?,
      mehrfachAuswahl: mehrfachAuswahl == freezed
          ? _value.mehrfachAuswahl
          : mehrfachAuswahl // ignore: cast_nullable_to_non_nullable
              as List<AuswahlElement>?,
      endAuswahl: endAuswahl == freezed
          ? _value.endAuswahl
          : endAuswahl // ignore: cast_nullable_to_non_nullable
              as AuswahlElement?,
      mengenWahl: mengenWahl == freezed
          ? _value.mengenWahl
          : mengenWahl // ignore: cast_nullable_to_non_nullable
              as MengenAuswahl?,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden == freezed
          ? _value.mehrfachAuswahlVorhanden
          : mehrfachAuswahlVorhanden // ignore: cast_nullable_to_non_nullable
              as bool,
      pfandAusgewaehlt: pfandAusgewaehlt == freezed
          ? _value.pfandAusgewaehlt
          : pfandAusgewaehlt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $ProduktCopyWith<$Res> get produkt {
    return $ProduktCopyWith<$Res>(_value.produkt, (value) {
      return _then(_value.copyWith(produkt: value));
    });
  }

  @override
  $AuswahlElementCopyWith<$Res>? get endAuswahl {
    if (_value.endAuswahl == null) {
      return null;
    }

    return $AuswahlElementCopyWith<$Res>(_value.endAuswahl!, (value) {
      return _then(_value.copyWith(endAuswahl: value));
    });
  }

  @override
  $MengenAuswahlCopyWith<$Res>? get mengenWahl {
    if (_value.mengenWahl == null) {
      return null;
    }

    return $MengenAuswahlCopyWith<$Res>(_value.mengenWahl!, (value) {
      return _then(_value.copyWith(mengenWahl: value));
    });
  }
}

/// @nodoc
abstract class _$WarenkorbElementCopyWith<$Res>
    implements $WarenkorbElementCopyWith<$Res> {
  factory _$WarenkorbElementCopyWith(
          _WarenkorbElement value, $Res Function(_WarenkorbElement) then) =
      __$WarenkorbElementCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String subtitle,
      double endPreis,
      int anzahl,
      Produkt produkt,
      String? anmerkung,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden,
      bool pfandAusgewaehlt});

  @override
  $ProduktCopyWith<$Res> get produkt;
  @override
  $AuswahlElementCopyWith<$Res>? get endAuswahl;
  @override
  $MengenAuswahlCopyWith<$Res>? get mengenWahl;
}

/// @nodoc
class __$WarenkorbElementCopyWithImpl<$Res>
    extends _$WarenkorbElementCopyWithImpl<$Res>
    implements _$WarenkorbElementCopyWith<$Res> {
  __$WarenkorbElementCopyWithImpl(
      _WarenkorbElement _value, $Res Function(_WarenkorbElement) _then)
      : super(_value, (v) => _then(v as _WarenkorbElement));

  @override
  _WarenkorbElement get _value => super._value as _WarenkorbElement;

  @override
  $Res call({
    Object? name = freezed,
    Object? subtitle = freezed,
    Object? endPreis = freezed,
    Object? anzahl = freezed,
    Object? produkt = freezed,
    Object? anmerkung = freezed,
    Object? mehrfachAuswahl = freezed,
    Object? endAuswahl = freezed,
    Object? mengenWahl = freezed,
    Object? mehrfachAuswahlVorhanden = freezed,
    Object? pfandAusgewaehlt = freezed,
  }) {
    return _then(_WarenkorbElement(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      endPreis: endPreis == freezed
          ? _value.endPreis
          : endPreis // ignore: cast_nullable_to_non_nullable
              as double,
      anzahl: anzahl == freezed
          ? _value.anzahl
          : anzahl // ignore: cast_nullable_to_non_nullable
              as int,
      produkt: produkt == freezed
          ? _value.produkt
          : produkt // ignore: cast_nullable_to_non_nullable
              as Produkt,
      anmerkung: anmerkung == freezed
          ? _value.anmerkung
          : anmerkung // ignore: cast_nullable_to_non_nullable
              as String?,
      mehrfachAuswahl: mehrfachAuswahl == freezed
          ? _value.mehrfachAuswahl
          : mehrfachAuswahl // ignore: cast_nullable_to_non_nullable
              as List<AuswahlElement>?,
      endAuswahl: endAuswahl == freezed
          ? _value.endAuswahl
          : endAuswahl // ignore: cast_nullable_to_non_nullable
              as AuswahlElement?,
      mengenWahl: mengenWahl == freezed
          ? _value.mengenWahl
          : mengenWahl // ignore: cast_nullable_to_non_nullable
              as MengenAuswahl?,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden == freezed
          ? _value.mehrfachAuswahlVorhanden
          : mehrfachAuswahlVorhanden // ignore: cast_nullable_to_non_nullable
              as bool,
      pfandAusgewaehlt: pfandAusgewaehlt == freezed
          ? _value.pfandAusgewaehlt
          : pfandAusgewaehlt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WarenkorbElement
    with DiagnosticableTreeMixin
    implements _WarenkorbElement {
  _$_WarenkorbElement(
      {required this.name,
      required this.subtitle,
      required this.endPreis,
      required this.anzahl,
      required this.produkt,
      this.anmerkung,
      this.mehrfachAuswahl,
      this.endAuswahl,
      this.mengenWahl,
      this.mehrfachAuswahlVorhanden = false,
      this.pfandAusgewaehlt = false});

  @override
  final String name;
  @override
  final String subtitle;
  @override
  final double endPreis;
  @override
  final int anzahl;
  @override
  final Produkt produkt;
  @override
  final String? anmerkung;
  @override
  final List<AuswahlElement>? mehrfachAuswahl;
  @override
  final AuswahlElement? endAuswahl;
  @override
  final MengenAuswahl? mengenWahl;
  @JsonKey(defaultValue: false)
  @override
  final bool mehrfachAuswahlVorhanden;
  @JsonKey(defaultValue: false)
  @override
  final bool pfandAusgewaehlt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WarenkorbElement(name: $name, subtitle: $subtitle, endPreis: $endPreis, anzahl: $anzahl, produkt: $produkt, anmerkung: $anmerkung, mehrfachAuswahl: $mehrfachAuswahl, endAuswahl: $endAuswahl, mengenWahl: $mengenWahl, mehrfachAuswahlVorhanden: $mehrfachAuswahlVorhanden, pfandAusgewaehlt: $pfandAusgewaehlt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WarenkorbElement'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty('endPreis', endPreis))
      ..add(DiagnosticsProperty('anzahl', anzahl))
      ..add(DiagnosticsProperty('produkt', produkt))
      ..add(DiagnosticsProperty('anmerkung', anmerkung))
      ..add(DiagnosticsProperty('mehrfachAuswahl', mehrfachAuswahl))
      ..add(DiagnosticsProperty('endAuswahl', endAuswahl))
      ..add(DiagnosticsProperty('mengenWahl', mengenWahl))
      ..add(DiagnosticsProperty(
          'mehrfachAuswahlVorhanden', mehrfachAuswahlVorhanden))
      ..add(DiagnosticsProperty('pfandAusgewaehlt', pfandAusgewaehlt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WarenkorbElement &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)) &&
            (identical(other.endPreis, endPreis) ||
                const DeepCollectionEquality()
                    .equals(other.endPreis, endPreis)) &&
            (identical(other.anzahl, anzahl) ||
                const DeepCollectionEquality().equals(other.anzahl, anzahl)) &&
            (identical(other.produkt, produkt) ||
                const DeepCollectionEquality()
                    .equals(other.produkt, produkt)) &&
            (identical(other.anmerkung, anmerkung) ||
                const DeepCollectionEquality()
                    .equals(other.anmerkung, anmerkung)) &&
            (identical(other.mehrfachAuswahl, mehrfachAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.mehrfachAuswahl, mehrfachAuswahl)) &&
            (identical(other.endAuswahl, endAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.endAuswahl, endAuswahl)) &&
            (identical(other.mengenWahl, mengenWahl) ||
                const DeepCollectionEquality()
                    .equals(other.mengenWahl, mengenWahl)) &&
            (identical(
                    other.mehrfachAuswahlVorhanden, mehrfachAuswahlVorhanden) ||
                const DeepCollectionEquality().equals(
                    other.mehrfachAuswahlVorhanden,
                    mehrfachAuswahlVorhanden)) &&
            (identical(other.pfandAusgewaehlt, pfandAusgewaehlt) ||
                const DeepCollectionEquality()
                    .equals(other.pfandAusgewaehlt, pfandAusgewaehlt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(subtitle) ^
      const DeepCollectionEquality().hash(endPreis) ^
      const DeepCollectionEquality().hash(anzahl) ^
      const DeepCollectionEquality().hash(produkt) ^
      const DeepCollectionEquality().hash(anmerkung) ^
      const DeepCollectionEquality().hash(mehrfachAuswahl) ^
      const DeepCollectionEquality().hash(endAuswahl) ^
      const DeepCollectionEquality().hash(mengenWahl) ^
      const DeepCollectionEquality().hash(mehrfachAuswahlVorhanden) ^
      const DeepCollectionEquality().hash(pfandAusgewaehlt);

  @JsonKey(ignore: true)
  @override
  _$WarenkorbElementCopyWith<_WarenkorbElement> get copyWith =>
      __$WarenkorbElementCopyWithImpl<_WarenkorbElement>(this, _$identity);
}

abstract class _WarenkorbElement implements WarenkorbElement {
  factory _WarenkorbElement(
      {required String name,
      required String subtitle,
      required double endPreis,
      required int anzahl,
      required Produkt produkt,
      String? anmerkung,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden,
      bool pfandAusgewaehlt}) = _$_WarenkorbElement;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get subtitle => throw _privateConstructorUsedError;
  @override
  double get endPreis => throw _privateConstructorUsedError;
  @override
  int get anzahl => throw _privateConstructorUsedError;
  @override
  Produkt get produkt => throw _privateConstructorUsedError;
  @override
  String? get anmerkung => throw _privateConstructorUsedError;
  @override
  List<AuswahlElement>? get mehrfachAuswahl =>
      throw _privateConstructorUsedError;
  @override
  AuswahlElement? get endAuswahl => throw _privateConstructorUsedError;
  @override
  MengenAuswahl? get mengenWahl => throw _privateConstructorUsedError;
  @override
  bool get mehrfachAuswahlVorhanden => throw _privateConstructorUsedError;
  @override
  bool get pfandAusgewaehlt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WarenkorbElementCopyWith<_WarenkorbElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$WarenkorbElementLightTearOff {
  const _$WarenkorbElementLightTearOff();

  _WarenkorbElementLight call(
      {required String name,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden = false,
      bool pfandAusgewaehlt = false}) {
    return _WarenkorbElementLight(
      name: name,
      mehrfachAuswahl: mehrfachAuswahl,
      endAuswahl: endAuswahl,
      mengenWahl: mengenWahl,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden,
      pfandAusgewaehlt: pfandAusgewaehlt,
    );
  }
}

/// @nodoc
const $WarenkorbElementLight = _$WarenkorbElementLightTearOff();

/// @nodoc
mixin _$WarenkorbElementLight {
  String get name => throw _privateConstructorUsedError;
  List<AuswahlElement>? get mehrfachAuswahl =>
      throw _privateConstructorUsedError;
  AuswahlElement? get endAuswahl => throw _privateConstructorUsedError;
  MengenAuswahl? get mengenWahl => throw _privateConstructorUsedError;
  bool get mehrfachAuswahlVorhanden => throw _privateConstructorUsedError;
  bool get pfandAusgewaehlt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WarenkorbElementLightCopyWith<WarenkorbElementLight> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WarenkorbElementLightCopyWith<$Res> {
  factory $WarenkorbElementLightCopyWith(WarenkorbElementLight value,
          $Res Function(WarenkorbElementLight) then) =
      _$WarenkorbElementLightCopyWithImpl<$Res>;
  $Res call(
      {String name,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden,
      bool pfandAusgewaehlt});

  $AuswahlElementCopyWith<$Res>? get endAuswahl;
  $MengenAuswahlCopyWith<$Res>? get mengenWahl;
}

/// @nodoc
class _$WarenkorbElementLightCopyWithImpl<$Res>
    implements $WarenkorbElementLightCopyWith<$Res> {
  _$WarenkorbElementLightCopyWithImpl(this._value, this._then);

  final WarenkorbElementLight _value;
  // ignore: unused_field
  final $Res Function(WarenkorbElementLight) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? mehrfachAuswahl = freezed,
    Object? endAuswahl = freezed,
    Object? mengenWahl = freezed,
    Object? mehrfachAuswahlVorhanden = freezed,
    Object? pfandAusgewaehlt = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mehrfachAuswahl: mehrfachAuswahl == freezed
          ? _value.mehrfachAuswahl
          : mehrfachAuswahl // ignore: cast_nullable_to_non_nullable
              as List<AuswahlElement>?,
      endAuswahl: endAuswahl == freezed
          ? _value.endAuswahl
          : endAuswahl // ignore: cast_nullable_to_non_nullable
              as AuswahlElement?,
      mengenWahl: mengenWahl == freezed
          ? _value.mengenWahl
          : mengenWahl // ignore: cast_nullable_to_non_nullable
              as MengenAuswahl?,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden == freezed
          ? _value.mehrfachAuswahlVorhanden
          : mehrfachAuswahlVorhanden // ignore: cast_nullable_to_non_nullable
              as bool,
      pfandAusgewaehlt: pfandAusgewaehlt == freezed
          ? _value.pfandAusgewaehlt
          : pfandAusgewaehlt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $AuswahlElementCopyWith<$Res>? get endAuswahl {
    if (_value.endAuswahl == null) {
      return null;
    }

    return $AuswahlElementCopyWith<$Res>(_value.endAuswahl!, (value) {
      return _then(_value.copyWith(endAuswahl: value));
    });
  }

  @override
  $MengenAuswahlCopyWith<$Res>? get mengenWahl {
    if (_value.mengenWahl == null) {
      return null;
    }

    return $MengenAuswahlCopyWith<$Res>(_value.mengenWahl!, (value) {
      return _then(_value.copyWith(mengenWahl: value));
    });
  }
}

/// @nodoc
abstract class _$WarenkorbElementLightCopyWith<$Res>
    implements $WarenkorbElementLightCopyWith<$Res> {
  factory _$WarenkorbElementLightCopyWith(_WarenkorbElementLight value,
          $Res Function(_WarenkorbElementLight) then) =
      __$WarenkorbElementLightCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden,
      bool pfandAusgewaehlt});

  @override
  $AuswahlElementCopyWith<$Res>? get endAuswahl;
  @override
  $MengenAuswahlCopyWith<$Res>? get mengenWahl;
}

/// @nodoc
class __$WarenkorbElementLightCopyWithImpl<$Res>
    extends _$WarenkorbElementLightCopyWithImpl<$Res>
    implements _$WarenkorbElementLightCopyWith<$Res> {
  __$WarenkorbElementLightCopyWithImpl(_WarenkorbElementLight _value,
      $Res Function(_WarenkorbElementLight) _then)
      : super(_value, (v) => _then(v as _WarenkorbElementLight));

  @override
  _WarenkorbElementLight get _value => super._value as _WarenkorbElementLight;

  @override
  $Res call({
    Object? name = freezed,
    Object? mehrfachAuswahl = freezed,
    Object? endAuswahl = freezed,
    Object? mengenWahl = freezed,
    Object? mehrfachAuswahlVorhanden = freezed,
    Object? pfandAusgewaehlt = freezed,
  }) {
    return _then(_WarenkorbElementLight(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mehrfachAuswahl: mehrfachAuswahl == freezed
          ? _value.mehrfachAuswahl
          : mehrfachAuswahl // ignore: cast_nullable_to_non_nullable
              as List<AuswahlElement>?,
      endAuswahl: endAuswahl == freezed
          ? _value.endAuswahl
          : endAuswahl // ignore: cast_nullable_to_non_nullable
              as AuswahlElement?,
      mengenWahl: mengenWahl == freezed
          ? _value.mengenWahl
          : mengenWahl // ignore: cast_nullable_to_non_nullable
              as MengenAuswahl?,
      mehrfachAuswahlVorhanden: mehrfachAuswahlVorhanden == freezed
          ? _value.mehrfachAuswahlVorhanden
          : mehrfachAuswahlVorhanden // ignore: cast_nullable_to_non_nullable
              as bool,
      pfandAusgewaehlt: pfandAusgewaehlt == freezed
          ? _value.pfandAusgewaehlt
          : pfandAusgewaehlt // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_WarenkorbElementLight
    with DiagnosticableTreeMixin
    implements _WarenkorbElementLight {
  _$_WarenkorbElementLight(
      {required this.name,
      this.mehrfachAuswahl,
      this.endAuswahl,
      this.mengenWahl,
      this.mehrfachAuswahlVorhanden = false,
      this.pfandAusgewaehlt = false});

  @override
  final String name;
  @override
  final List<AuswahlElement>? mehrfachAuswahl;
  @override
  final AuswahlElement? endAuswahl;
  @override
  final MengenAuswahl? mengenWahl;
  @JsonKey(defaultValue: false)
  @override
  final bool mehrfachAuswahlVorhanden;
  @JsonKey(defaultValue: false)
  @override
  final bool pfandAusgewaehlt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'WarenkorbElementLight(name: $name, mehrfachAuswahl: $mehrfachAuswahl, endAuswahl: $endAuswahl, mengenWahl: $mengenWahl, mehrfachAuswahlVorhanden: $mehrfachAuswahlVorhanden, pfandAusgewaehlt: $pfandAusgewaehlt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'WarenkorbElementLight'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('mehrfachAuswahl', mehrfachAuswahl))
      ..add(DiagnosticsProperty('endAuswahl', endAuswahl))
      ..add(DiagnosticsProperty('mengenWahl', mengenWahl))
      ..add(DiagnosticsProperty(
          'mehrfachAuswahlVorhanden', mehrfachAuswahlVorhanden))
      ..add(DiagnosticsProperty('pfandAusgewaehlt', pfandAusgewaehlt));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _WarenkorbElementLight &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mehrfachAuswahl, mehrfachAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.mehrfachAuswahl, mehrfachAuswahl)) &&
            (identical(other.endAuswahl, endAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.endAuswahl, endAuswahl)) &&
            (identical(other.mengenWahl, mengenWahl) ||
                const DeepCollectionEquality()
                    .equals(other.mengenWahl, mengenWahl)) &&
            (identical(
                    other.mehrfachAuswahlVorhanden, mehrfachAuswahlVorhanden) ||
                const DeepCollectionEquality().equals(
                    other.mehrfachAuswahlVorhanden,
                    mehrfachAuswahlVorhanden)) &&
            (identical(other.pfandAusgewaehlt, pfandAusgewaehlt) ||
                const DeepCollectionEquality()
                    .equals(other.pfandAusgewaehlt, pfandAusgewaehlt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mehrfachAuswahl) ^
      const DeepCollectionEquality().hash(endAuswahl) ^
      const DeepCollectionEquality().hash(mengenWahl) ^
      const DeepCollectionEquality().hash(mehrfachAuswahlVorhanden) ^
      const DeepCollectionEquality().hash(pfandAusgewaehlt);

  @JsonKey(ignore: true)
  @override
  _$WarenkorbElementLightCopyWith<_WarenkorbElementLight> get copyWith =>
      __$WarenkorbElementLightCopyWithImpl<_WarenkorbElementLight>(
          this, _$identity);
}

abstract class _WarenkorbElementLight implements WarenkorbElementLight {
  factory _WarenkorbElementLight(
      {required String name,
      List<AuswahlElement>? mehrfachAuswahl,
      AuswahlElement? endAuswahl,
      MengenAuswahl? mengenWahl,
      bool mehrfachAuswahlVorhanden,
      bool pfandAusgewaehlt}) = _$_WarenkorbElementLight;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  List<AuswahlElement>? get mehrfachAuswahl =>
      throw _privateConstructorUsedError;
  @override
  AuswahlElement? get endAuswahl => throw _privateConstructorUsedError;
  @override
  MengenAuswahl? get mengenWahl => throw _privateConstructorUsedError;
  @override
  bool get mehrfachAuswahlVorhanden => throw _privateConstructorUsedError;
  @override
  bool get pfandAusgewaehlt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$WarenkorbElementLightCopyWith<_WarenkorbElementLight> get copyWith =>
      throw _privateConstructorUsedError;
}

AuswahlElement _$AuswahlElementFromJson(Map<String, dynamic> json) {
  return _AuswahlElement.fromJson(json);
}

/// @nodoc
class _$AuswahlElementTearOff {
  const _$AuswahlElementTearOff();

  _AuswahlElement call(
      {required String title,
      double aufpreis = 0,
      bool standardAuswahl = false,
      bool alkoholhaltig = false}) {
    return _AuswahlElement(
      title: title,
      aufpreis: aufpreis,
      standardAuswahl: standardAuswahl,
      alkoholhaltig: alkoholhaltig,
    );
  }

  AuswahlElement fromJson(Map<String, Object> json) {
    return AuswahlElement.fromJson(json);
  }
}

/// @nodoc
const $AuswahlElement = _$AuswahlElementTearOff();

/// @nodoc
mixin _$AuswahlElement {
  String get title => throw _privateConstructorUsedError;
  double get aufpreis => throw _privateConstructorUsedError;
  bool get standardAuswahl => throw _privateConstructorUsedError;
  bool get alkoholhaltig => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuswahlElementCopyWith<AuswahlElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuswahlElementCopyWith<$Res> {
  factory $AuswahlElementCopyWith(
          AuswahlElement value, $Res Function(AuswahlElement) then) =
      _$AuswahlElementCopyWithImpl<$Res>;
  $Res call(
      {String title,
      double aufpreis,
      bool standardAuswahl,
      bool alkoholhaltig});
}

/// @nodoc
class _$AuswahlElementCopyWithImpl<$Res>
    implements $AuswahlElementCopyWith<$Res> {
  _$AuswahlElementCopyWithImpl(this._value, this._then);

  final AuswahlElement _value;
  // ignore: unused_field
  final $Res Function(AuswahlElement) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? aufpreis = freezed,
    Object? standardAuswahl = freezed,
    Object? alkoholhaltig = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      aufpreis: aufpreis == freezed
          ? _value.aufpreis
          : aufpreis // ignore: cast_nullable_to_non_nullable
              as double,
      standardAuswahl: standardAuswahl == freezed
          ? _value.standardAuswahl
          : standardAuswahl // ignore: cast_nullable_to_non_nullable
              as bool,
      alkoholhaltig: alkoholhaltig == freezed
          ? _value.alkoholhaltig
          : alkoholhaltig // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$AuswahlElementCopyWith<$Res>
    implements $AuswahlElementCopyWith<$Res> {
  factory _$AuswahlElementCopyWith(
          _AuswahlElement value, $Res Function(_AuswahlElement) then) =
      __$AuswahlElementCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      double aufpreis,
      bool standardAuswahl,
      bool alkoholhaltig});
}

/// @nodoc
class __$AuswahlElementCopyWithImpl<$Res>
    extends _$AuswahlElementCopyWithImpl<$Res>
    implements _$AuswahlElementCopyWith<$Res> {
  __$AuswahlElementCopyWithImpl(
      _AuswahlElement _value, $Res Function(_AuswahlElement) _then)
      : super(_value, (v) => _then(v as _AuswahlElement));

  @override
  _AuswahlElement get _value => super._value as _AuswahlElement;

  @override
  $Res call({
    Object? title = freezed,
    Object? aufpreis = freezed,
    Object? standardAuswahl = freezed,
    Object? alkoholhaltig = freezed,
  }) {
    return _then(_AuswahlElement(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      aufpreis: aufpreis == freezed
          ? _value.aufpreis
          : aufpreis // ignore: cast_nullable_to_non_nullable
              as double,
      standardAuswahl: standardAuswahl == freezed
          ? _value.standardAuswahl
          : standardAuswahl // ignore: cast_nullable_to_non_nullable
              as bool,
      alkoholhaltig: alkoholhaltig == freezed
          ? _value.alkoholhaltig
          : alkoholhaltig // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AuswahlElement
    with DiagnosticableTreeMixin
    implements _AuswahlElement {
  _$_AuswahlElement(
      {required this.title,
      this.aufpreis = 0,
      this.standardAuswahl = false,
      this.alkoholhaltig = false});

  factory _$_AuswahlElement.fromJson(Map<String, dynamic> json) =>
      _$_$_AuswahlElementFromJson(json);

  @override
  final String title;
  @JsonKey(defaultValue: 0)
  @override
  final double aufpreis;
  @JsonKey(defaultValue: false)
  @override
  final bool standardAuswahl;
  @JsonKey(defaultValue: false)
  @override
  final bool alkoholhaltig;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AuswahlElement(title: $title, aufpreis: $aufpreis, standardAuswahl: $standardAuswahl, alkoholhaltig: $alkoholhaltig)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AuswahlElement'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('aufpreis', aufpreis))
      ..add(DiagnosticsProperty('standardAuswahl', standardAuswahl))
      ..add(DiagnosticsProperty('alkoholhaltig', alkoholhaltig));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuswahlElement &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.aufpreis, aufpreis) ||
                const DeepCollectionEquality()
                    .equals(other.aufpreis, aufpreis)) &&
            (identical(other.standardAuswahl, standardAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.standardAuswahl, standardAuswahl)) &&
            (identical(other.alkoholhaltig, alkoholhaltig) ||
                const DeepCollectionEquality()
                    .equals(other.alkoholhaltig, alkoholhaltig)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(aufpreis) ^
      const DeepCollectionEquality().hash(standardAuswahl) ^
      const DeepCollectionEquality().hash(alkoholhaltig);

  @JsonKey(ignore: true)
  @override
  _$AuswahlElementCopyWith<_AuswahlElement> get copyWith =>
      __$AuswahlElementCopyWithImpl<_AuswahlElement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AuswahlElementToJson(this);
  }
}

abstract class _AuswahlElement implements AuswahlElement {
  factory _AuswahlElement(
      {required String title,
      double aufpreis,
      bool standardAuswahl,
      bool alkoholhaltig}) = _$_AuswahlElement;

  factory _AuswahlElement.fromJson(Map<String, dynamic> json) =
      _$_AuswahlElement.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  double get aufpreis => throw _privateConstructorUsedError;
  @override
  bool get standardAuswahl => throw _privateConstructorUsedError;
  @override
  bool get alkoholhaltig => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AuswahlElementCopyWith<_AuswahlElement> get copyWith =>
      throw _privateConstructorUsedError;
}

MengenAuswahl _$MengenAuswahlFromJson(Map<String, dynamic> json) {
  return _MengenAuswahl.fromJson(json);
}

/// @nodoc
class _$MengenAuswahlTearOff {
  const _$MengenAuswahlTearOff();

  _MengenAuswahl call(
      {required String title,
      double aufpreis = 0,
      bool standardAuswahl = false}) {
    return _MengenAuswahl(
      title: title,
      aufpreis: aufpreis,
      standardAuswahl: standardAuswahl,
    );
  }

  MengenAuswahl fromJson(Map<String, Object> json) {
    return MengenAuswahl.fromJson(json);
  }
}

/// @nodoc
const $MengenAuswahl = _$MengenAuswahlTearOff();

/// @nodoc
mixin _$MengenAuswahl {
  String get title => throw _privateConstructorUsedError;
  double get aufpreis => throw _privateConstructorUsedError;
  bool get standardAuswahl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MengenAuswahlCopyWith<MengenAuswahl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MengenAuswahlCopyWith<$Res> {
  factory $MengenAuswahlCopyWith(
          MengenAuswahl value, $Res Function(MengenAuswahl) then) =
      _$MengenAuswahlCopyWithImpl<$Res>;
  $Res call({String title, double aufpreis, bool standardAuswahl});
}

/// @nodoc
class _$MengenAuswahlCopyWithImpl<$Res>
    implements $MengenAuswahlCopyWith<$Res> {
  _$MengenAuswahlCopyWithImpl(this._value, this._then);

  final MengenAuswahl _value;
  // ignore: unused_field
  final $Res Function(MengenAuswahl) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? aufpreis = freezed,
    Object? standardAuswahl = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      aufpreis: aufpreis == freezed
          ? _value.aufpreis
          : aufpreis // ignore: cast_nullable_to_non_nullable
              as double,
      standardAuswahl: standardAuswahl == freezed
          ? _value.standardAuswahl
          : standardAuswahl // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$MengenAuswahlCopyWith<$Res>
    implements $MengenAuswahlCopyWith<$Res> {
  factory _$MengenAuswahlCopyWith(
          _MengenAuswahl value, $Res Function(_MengenAuswahl) then) =
      __$MengenAuswahlCopyWithImpl<$Res>;
  @override
  $Res call({String title, double aufpreis, bool standardAuswahl});
}

/// @nodoc
class __$MengenAuswahlCopyWithImpl<$Res>
    extends _$MengenAuswahlCopyWithImpl<$Res>
    implements _$MengenAuswahlCopyWith<$Res> {
  __$MengenAuswahlCopyWithImpl(
      _MengenAuswahl _value, $Res Function(_MengenAuswahl) _then)
      : super(_value, (v) => _then(v as _MengenAuswahl));

  @override
  _MengenAuswahl get _value => super._value as _MengenAuswahl;

  @override
  $Res call({
    Object? title = freezed,
    Object? aufpreis = freezed,
    Object? standardAuswahl = freezed,
  }) {
    return _then(_MengenAuswahl(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      aufpreis: aufpreis == freezed
          ? _value.aufpreis
          : aufpreis // ignore: cast_nullable_to_non_nullable
              as double,
      standardAuswahl: standardAuswahl == freezed
          ? _value.standardAuswahl
          : standardAuswahl // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MengenAuswahl with DiagnosticableTreeMixin implements _MengenAuswahl {
  _$_MengenAuswahl(
      {required this.title, this.aufpreis = 0, this.standardAuswahl = false});

  factory _$_MengenAuswahl.fromJson(Map<String, dynamic> json) =>
      _$_$_MengenAuswahlFromJson(json);

  @override
  final String title;
  @JsonKey(defaultValue: 0)
  @override
  final double aufpreis;
  @JsonKey(defaultValue: false)
  @override
  final bool standardAuswahl;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MengenAuswahl(title: $title, aufpreis: $aufpreis, standardAuswahl: $standardAuswahl)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MengenAuswahl'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('aufpreis', aufpreis))
      ..add(DiagnosticsProperty('standardAuswahl', standardAuswahl));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MengenAuswahl &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.aufpreis, aufpreis) ||
                const DeepCollectionEquality()
                    .equals(other.aufpreis, aufpreis)) &&
            (identical(other.standardAuswahl, standardAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.standardAuswahl, standardAuswahl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(aufpreis) ^
      const DeepCollectionEquality().hash(standardAuswahl);

  @JsonKey(ignore: true)
  @override
  _$MengenAuswahlCopyWith<_MengenAuswahl> get copyWith =>
      __$MengenAuswahlCopyWithImpl<_MengenAuswahl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MengenAuswahlToJson(this);
  }
}

abstract class _MengenAuswahl implements MengenAuswahl {
  factory _MengenAuswahl(
      {required String title,
      double aufpreis,
      bool standardAuswahl}) = _$_MengenAuswahl;

  factory _MengenAuswahl.fromJson(Map<String, dynamic> json) =
      _$_MengenAuswahl.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  double get aufpreis => throw _privateConstructorUsedError;
  @override
  bool get standardAuswahl => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MengenAuswahlCopyWith<_MengenAuswahl> get copyWith =>
      throw _privateConstructorUsedError;
}

Zutat _$ZutatFromJson(Map<String, dynamic> json) {
  return _Zutat.fromJson(json);
}

/// @nodoc
class _$ZutatTearOff {
  const _$ZutatTearOff();

  _Zutat call({required String title, String? subtitle}) {
    return _Zutat(
      title: title,
      subtitle: subtitle,
    );
  }

  Zutat fromJson(Map<String, Object> json) {
    return Zutat.fromJson(json);
  }
}

/// @nodoc
const $Zutat = _$ZutatTearOff();

/// @nodoc
mixin _$Zutat {
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ZutatCopyWith<Zutat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ZutatCopyWith<$Res> {
  factory $ZutatCopyWith(Zutat value, $Res Function(Zutat) then) =
      _$ZutatCopyWithImpl<$Res>;
  $Res call({String title, String? subtitle});
}

/// @nodoc
class _$ZutatCopyWithImpl<$Res> implements $ZutatCopyWith<$Res> {
  _$ZutatCopyWithImpl(this._value, this._then);

  final Zutat _value;
  // ignore: unused_field
  final $Res Function(Zutat) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? subtitle = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ZutatCopyWith<$Res> implements $ZutatCopyWith<$Res> {
  factory _$ZutatCopyWith(_Zutat value, $Res Function(_Zutat) then) =
      __$ZutatCopyWithImpl<$Res>;
  @override
  $Res call({String title, String? subtitle});
}

/// @nodoc
class __$ZutatCopyWithImpl<$Res> extends _$ZutatCopyWithImpl<$Res>
    implements _$ZutatCopyWith<$Res> {
  __$ZutatCopyWithImpl(_Zutat _value, $Res Function(_Zutat) _then)
      : super(_value, (v) => _then(v as _Zutat));

  @override
  _Zutat get _value => super._value as _Zutat;

  @override
  $Res call({
    Object? title = freezed,
    Object? subtitle = freezed,
  }) {
    return _then(_Zutat(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: subtitle == freezed
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Zutat with DiagnosticableTreeMixin implements _Zutat {
  _$_Zutat({required this.title, this.subtitle});

  factory _$_Zutat.fromJson(Map<String, dynamic> json) =>
      _$_$_ZutatFromJson(json);

  @override
  final String title;
  @override
  final String? subtitle;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Zutat(title: $title, subtitle: $subtitle)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Zutat'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('subtitle', subtitle));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Zutat &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.subtitle, subtitle) ||
                const DeepCollectionEquality()
                    .equals(other.subtitle, subtitle)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(subtitle);

  @JsonKey(ignore: true)
  @override
  _$ZutatCopyWith<_Zutat> get copyWith =>
      __$ZutatCopyWithImpl<_Zutat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ZutatToJson(this);
  }
}

abstract class _Zutat implements Zutat {
  factory _Zutat({required String title, String? subtitle}) = _$_Zutat;

  factory _Zutat.fromJson(Map<String, dynamic> json) = _$_Zutat.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String? get subtitle => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ZutatCopyWith<_Zutat> get copyWith => throw _privateConstructorUsedError;
}

Bestellung _$BestellungFromJson(Map<String, dynamic> json) {
  return _Bestellung.fromJson(json);
}

/// @nodoc
class _$BestellungTearOff {
  const _$BestellungTearOff();

  _Bestellung call(
      {required String deviceID,
      required List<Map<String, dynamic>> bestellInhalt,
      DateTime? bestellZeitpunkt,
      String? bezahlMethode,
      String? name,
      String? mail,
      String? phone,
      String? lieferHinweis,
      double? gesamtPreis,
      String bestellFortschritt = "Vorbereitung",
      bool ab18 = false,
      String? driverID,
      DateTime? zustellZeitpunkt,
      DateTime? ankunftsZeit}) {
    return _Bestellung(
      deviceID: deviceID,
      bestellInhalt: bestellInhalt,
      bestellZeitpunkt: bestellZeitpunkt,
      bezahlMethode: bezahlMethode,
      name: name,
      mail: mail,
      phone: phone,
      lieferHinweis: lieferHinweis,
      gesamtPreis: gesamtPreis,
      bestellFortschritt: bestellFortschritt,
      ab18: ab18,
      driverID: driverID,
      zustellZeitpunkt: zustellZeitpunkt,
      ankunftsZeit: ankunftsZeit,
    );
  }

  Bestellung fromJson(Map<String, Object> json) {
    return Bestellung.fromJson(json);
  }
}

/// @nodoc
const $Bestellung = _$BestellungTearOff();

/// @nodoc
mixin _$Bestellung {
  String get deviceID => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get bestellInhalt =>
      throw _privateConstructorUsedError;
  DateTime? get bestellZeitpunkt => throw _privateConstructorUsedError;
  String? get bezahlMethode => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get mail => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get lieferHinweis => throw _privateConstructorUsedError;
  double? get gesamtPreis => throw _privateConstructorUsedError;
  String get bestellFortschritt => throw _privateConstructorUsedError;
  bool get ab18 => throw _privateConstructorUsedError;
  String? get driverID => throw _privateConstructorUsedError;
  DateTime? get zustellZeitpunkt => throw _privateConstructorUsedError;
  DateTime? get ankunftsZeit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BestellungCopyWith<Bestellung> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BestellungCopyWith<$Res> {
  factory $BestellungCopyWith(
          Bestellung value, $Res Function(Bestellung) then) =
      _$BestellungCopyWithImpl<$Res>;
  $Res call(
      {String deviceID,
      List<Map<String, dynamic>> bestellInhalt,
      DateTime? bestellZeitpunkt,
      String? bezahlMethode,
      String? name,
      String? mail,
      String? phone,
      String? lieferHinweis,
      double? gesamtPreis,
      String bestellFortschritt,
      bool ab18,
      String? driverID,
      DateTime? zustellZeitpunkt,
      DateTime? ankunftsZeit});
}

/// @nodoc
class _$BestellungCopyWithImpl<$Res> implements $BestellungCopyWith<$Res> {
  _$BestellungCopyWithImpl(this._value, this._then);

  final Bestellung _value;
  // ignore: unused_field
  final $Res Function(Bestellung) _then;

  @override
  $Res call({
    Object? deviceID = freezed,
    Object? bestellInhalt = freezed,
    Object? bestellZeitpunkt = freezed,
    Object? bezahlMethode = freezed,
    Object? name = freezed,
    Object? mail = freezed,
    Object? phone = freezed,
    Object? lieferHinweis = freezed,
    Object? gesamtPreis = freezed,
    Object? bestellFortschritt = freezed,
    Object? ab18 = freezed,
    Object? driverID = freezed,
    Object? zustellZeitpunkt = freezed,
    Object? ankunftsZeit = freezed,
  }) {
    return _then(_value.copyWith(
      deviceID: deviceID == freezed
          ? _value.deviceID
          : deviceID // ignore: cast_nullable_to_non_nullable
              as String,
      bestellInhalt: bestellInhalt == freezed
          ? _value.bestellInhalt
          : bestellInhalt // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      bestellZeitpunkt: bestellZeitpunkt == freezed
          ? _value.bestellZeitpunkt
          : bestellZeitpunkt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bezahlMethode: bezahlMethode == freezed
          ? _value.bezahlMethode
          : bezahlMethode // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      mail: mail == freezed
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      lieferHinweis: lieferHinweis == freezed
          ? _value.lieferHinweis
          : lieferHinweis // ignore: cast_nullable_to_non_nullable
              as String?,
      gesamtPreis: gesamtPreis == freezed
          ? _value.gesamtPreis
          : gesamtPreis // ignore: cast_nullable_to_non_nullable
              as double?,
      bestellFortschritt: bestellFortschritt == freezed
          ? _value.bestellFortschritt
          : bestellFortschritt // ignore: cast_nullable_to_non_nullable
              as String,
      ab18: ab18 == freezed
          ? _value.ab18
          : ab18 // ignore: cast_nullable_to_non_nullable
              as bool,
      driverID: driverID == freezed
          ? _value.driverID
          : driverID // ignore: cast_nullable_to_non_nullable
              as String?,
      zustellZeitpunkt: zustellZeitpunkt == freezed
          ? _value.zustellZeitpunkt
          : zustellZeitpunkt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ankunftsZeit: ankunftsZeit == freezed
          ? _value.ankunftsZeit
          : ankunftsZeit // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$BestellungCopyWith<$Res> implements $BestellungCopyWith<$Res> {
  factory _$BestellungCopyWith(
          _Bestellung value, $Res Function(_Bestellung) then) =
      __$BestellungCopyWithImpl<$Res>;
  @override
  $Res call(
      {String deviceID,
      List<Map<String, dynamic>> bestellInhalt,
      DateTime? bestellZeitpunkt,
      String? bezahlMethode,
      String? name,
      String? mail,
      String? phone,
      String? lieferHinweis,
      double? gesamtPreis,
      String bestellFortschritt,
      bool ab18,
      String? driverID,
      DateTime? zustellZeitpunkt,
      DateTime? ankunftsZeit});
}

/// @nodoc
class __$BestellungCopyWithImpl<$Res> extends _$BestellungCopyWithImpl<$Res>
    implements _$BestellungCopyWith<$Res> {
  __$BestellungCopyWithImpl(
      _Bestellung _value, $Res Function(_Bestellung) _then)
      : super(_value, (v) => _then(v as _Bestellung));

  @override
  _Bestellung get _value => super._value as _Bestellung;

  @override
  $Res call({
    Object? deviceID = freezed,
    Object? bestellInhalt = freezed,
    Object? bestellZeitpunkt = freezed,
    Object? bezahlMethode = freezed,
    Object? name = freezed,
    Object? mail = freezed,
    Object? phone = freezed,
    Object? lieferHinweis = freezed,
    Object? gesamtPreis = freezed,
    Object? bestellFortschritt = freezed,
    Object? ab18 = freezed,
    Object? driverID = freezed,
    Object? zustellZeitpunkt = freezed,
    Object? ankunftsZeit = freezed,
  }) {
    return _then(_Bestellung(
      deviceID: deviceID == freezed
          ? _value.deviceID
          : deviceID // ignore: cast_nullable_to_non_nullable
              as String,
      bestellInhalt: bestellInhalt == freezed
          ? _value.bestellInhalt
          : bestellInhalt // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      bestellZeitpunkt: bestellZeitpunkt == freezed
          ? _value.bestellZeitpunkt
          : bestellZeitpunkt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      bezahlMethode: bezahlMethode == freezed
          ? _value.bezahlMethode
          : bezahlMethode // ignore: cast_nullable_to_non_nullable
              as String?,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      mail: mail == freezed
          ? _value.mail
          : mail // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      lieferHinweis: lieferHinweis == freezed
          ? _value.lieferHinweis
          : lieferHinweis // ignore: cast_nullable_to_non_nullable
              as String?,
      gesamtPreis: gesamtPreis == freezed
          ? _value.gesamtPreis
          : gesamtPreis // ignore: cast_nullable_to_non_nullable
              as double?,
      bestellFortschritt: bestellFortschritt == freezed
          ? _value.bestellFortschritt
          : bestellFortschritt // ignore: cast_nullable_to_non_nullable
              as String,
      ab18: ab18 == freezed
          ? _value.ab18
          : ab18 // ignore: cast_nullable_to_non_nullable
              as bool,
      driverID: driverID == freezed
          ? _value.driverID
          : driverID // ignore: cast_nullable_to_non_nullable
              as String?,
      zustellZeitpunkt: zustellZeitpunkt == freezed
          ? _value.zustellZeitpunkt
          : zustellZeitpunkt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      ankunftsZeit: ankunftsZeit == freezed
          ? _value.ankunftsZeit
          : ankunftsZeit // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bestellung extends _Bestellung with DiagnosticableTreeMixin {
  _$_Bestellung(
      {required this.deviceID,
      required this.bestellInhalt,
      this.bestellZeitpunkt,
      this.bezahlMethode,
      this.name,
      this.mail,
      this.phone,
      this.lieferHinweis,
      this.gesamtPreis,
      this.bestellFortschritt = "Vorbereitung",
      this.ab18 = false,
      this.driverID,
      this.zustellZeitpunkt,
      this.ankunftsZeit})
      : super._();

  factory _$_Bestellung.fromJson(Map<String, dynamic> json) =>
      _$_$_BestellungFromJson(json);

  @override
  final String deviceID;
  @override
  final List<Map<String, dynamic>> bestellInhalt;
  @override
  final DateTime? bestellZeitpunkt;
  @override
  final String? bezahlMethode;
  @override
  final String? name;
  @override
  final String? mail;
  @override
  final String? phone;
  @override
  final String? lieferHinweis;
  @override
  final double? gesamtPreis;
  @JsonKey(defaultValue: "Vorbereitung")
  @override
  final String bestellFortschritt;
  @JsonKey(defaultValue: false)
  @override
  final bool ab18;
  @override
  final String? driverID;
  @override
  final DateTime? zustellZeitpunkt;
  @override
  final DateTime? ankunftsZeit;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Bestellung(deviceID: $deviceID, bestellInhalt: $bestellInhalt, bestellZeitpunkt: $bestellZeitpunkt, bezahlMethode: $bezahlMethode, name: $name, mail: $mail, phone: $phone, lieferHinweis: $lieferHinweis, gesamtPreis: $gesamtPreis, bestellFortschritt: $bestellFortschritt, ab18: $ab18, driverID: $driverID, zustellZeitpunkt: $zustellZeitpunkt, ankunftsZeit: $ankunftsZeit)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Bestellung'))
      ..add(DiagnosticsProperty('deviceID', deviceID))
      ..add(DiagnosticsProperty('bestellInhalt', bestellInhalt))
      ..add(DiagnosticsProperty('bestellZeitpunkt', bestellZeitpunkt))
      ..add(DiagnosticsProperty('bezahlMethode', bezahlMethode))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('mail', mail))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('lieferHinweis', lieferHinweis))
      ..add(DiagnosticsProperty('gesamtPreis', gesamtPreis))
      ..add(DiagnosticsProperty('bestellFortschritt', bestellFortschritt))
      ..add(DiagnosticsProperty('ab18', ab18))
      ..add(DiagnosticsProperty('driverID', driverID))
      ..add(DiagnosticsProperty('zustellZeitpunkt', zustellZeitpunkt))
      ..add(DiagnosticsProperty('ankunftsZeit', ankunftsZeit));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Bestellung &&
            (identical(other.deviceID, deviceID) ||
                const DeepCollectionEquality()
                    .equals(other.deviceID, deviceID)) &&
            (identical(other.bestellInhalt, bestellInhalt) ||
                const DeepCollectionEquality()
                    .equals(other.bestellInhalt, bestellInhalt)) &&
            (identical(other.bestellZeitpunkt, bestellZeitpunkt) ||
                const DeepCollectionEquality()
                    .equals(other.bestellZeitpunkt, bestellZeitpunkt)) &&
            (identical(other.bezahlMethode, bezahlMethode) ||
                const DeepCollectionEquality()
                    .equals(other.bezahlMethode, bezahlMethode)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mail, mail) ||
                const DeepCollectionEquality().equals(other.mail, mail)) &&
            (identical(other.phone, phone) ||
                const DeepCollectionEquality().equals(other.phone, phone)) &&
            (identical(other.lieferHinweis, lieferHinweis) ||
                const DeepCollectionEquality()
                    .equals(other.lieferHinweis, lieferHinweis)) &&
            (identical(other.gesamtPreis, gesamtPreis) ||
                const DeepCollectionEquality()
                    .equals(other.gesamtPreis, gesamtPreis)) &&
            (identical(other.bestellFortschritt, bestellFortschritt) ||
                const DeepCollectionEquality()
                    .equals(other.bestellFortschritt, bestellFortschritt)) &&
            (identical(other.ab18, ab18) ||
                const DeepCollectionEquality().equals(other.ab18, ab18)) &&
            (identical(other.driverID, driverID) ||
                const DeepCollectionEquality()
                    .equals(other.driverID, driverID)) &&
            (identical(other.zustellZeitpunkt, zustellZeitpunkt) ||
                const DeepCollectionEquality()
                    .equals(other.zustellZeitpunkt, zustellZeitpunkt)) &&
            (identical(other.ankunftsZeit, ankunftsZeit) ||
                const DeepCollectionEquality()
                    .equals(other.ankunftsZeit, ankunftsZeit)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(deviceID) ^
      const DeepCollectionEquality().hash(bestellInhalt) ^
      const DeepCollectionEquality().hash(bestellZeitpunkt) ^
      const DeepCollectionEquality().hash(bezahlMethode) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mail) ^
      const DeepCollectionEquality().hash(phone) ^
      const DeepCollectionEquality().hash(lieferHinweis) ^
      const DeepCollectionEquality().hash(gesamtPreis) ^
      const DeepCollectionEquality().hash(bestellFortschritt) ^
      const DeepCollectionEquality().hash(ab18) ^
      const DeepCollectionEquality().hash(driverID) ^
      const DeepCollectionEquality().hash(zustellZeitpunkt) ^
      const DeepCollectionEquality().hash(ankunftsZeit);

  @JsonKey(ignore: true)
  @override
  _$BestellungCopyWith<_Bestellung> get copyWith =>
      __$BestellungCopyWithImpl<_Bestellung>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BestellungToJson(this);
  }
}

abstract class _Bestellung extends Bestellung {
  factory _Bestellung(
      {required String deviceID,
      required List<Map<String, dynamic>> bestellInhalt,
      DateTime? bestellZeitpunkt,
      String? bezahlMethode,
      String? name,
      String? mail,
      String? phone,
      String? lieferHinweis,
      double? gesamtPreis,
      String bestellFortschritt,
      bool ab18,
      String? driverID,
      DateTime? zustellZeitpunkt,
      DateTime? ankunftsZeit}) = _$_Bestellung;
  _Bestellung._() : super._();

  factory _Bestellung.fromJson(Map<String, dynamic> json) =
      _$_Bestellung.fromJson;

  @override
  String get deviceID => throw _privateConstructorUsedError;
  @override
  List<Map<String, dynamic>> get bestellInhalt =>
      throw _privateConstructorUsedError;
  @override
  DateTime? get bestellZeitpunkt => throw _privateConstructorUsedError;
  @override
  String? get bezahlMethode => throw _privateConstructorUsedError;
  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  String? get mail => throw _privateConstructorUsedError;
  @override
  String? get phone => throw _privateConstructorUsedError;
  @override
  String? get lieferHinweis => throw _privateConstructorUsedError;
  @override
  double? get gesamtPreis => throw _privateConstructorUsedError;
  @override
  String get bestellFortschritt => throw _privateConstructorUsedError;
  @override
  bool get ab18 => throw _privateConstructorUsedError;
  @override
  String? get driverID => throw _privateConstructorUsedError;
  @override
  DateTime? get zustellZeitpunkt => throw _privateConstructorUsedError;
  @override
  DateTime? get ankunftsZeit => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BestellungCopyWith<_Bestellung> get copyWith =>
      throw _privateConstructorUsedError;
}

BestellElement _$BestellElementFromJson(Map<String, dynamic> json) {
  return _BestellElement.fromJson(json);
}

/// @nodoc
class _$BestellElementTearOff {
  const _$BestellElementTearOff();

  _BestellElement call(
      {required String title,
      required int anzahl,
      bool pfand = false,
      required String mengenAuswahl,
      String? auswahlTitle,
      String? anmerkung}) {
    return _BestellElement(
      title: title,
      anzahl: anzahl,
      pfand: pfand,
      mengenAuswahl: mengenAuswahl,
      auswahlTitle: auswahlTitle,
      anmerkung: anmerkung,
    );
  }

  BestellElement fromJson(Map<String, Object> json) {
    return BestellElement.fromJson(json);
  }
}

/// @nodoc
const $BestellElement = _$BestellElementTearOff();

/// @nodoc
mixin _$BestellElement {
  String get title => throw _privateConstructorUsedError;
  int get anzahl => throw _privateConstructorUsedError;
  bool get pfand => throw _privateConstructorUsedError;
  String get mengenAuswahl => throw _privateConstructorUsedError;
  String? get auswahlTitle => throw _privateConstructorUsedError;
  String? get anmerkung => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BestellElementCopyWith<BestellElement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BestellElementCopyWith<$Res> {
  factory $BestellElementCopyWith(
          BestellElement value, $Res Function(BestellElement) then) =
      _$BestellElementCopyWithImpl<$Res>;
  $Res call(
      {String title,
      int anzahl,
      bool pfand,
      String mengenAuswahl,
      String? auswahlTitle,
      String? anmerkung});
}

/// @nodoc
class _$BestellElementCopyWithImpl<$Res>
    implements $BestellElementCopyWith<$Res> {
  _$BestellElementCopyWithImpl(this._value, this._then);

  final BestellElement _value;
  // ignore: unused_field
  final $Res Function(BestellElement) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? anzahl = freezed,
    Object? pfand = freezed,
    Object? mengenAuswahl = freezed,
    Object? auswahlTitle = freezed,
    Object? anmerkung = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      anzahl: anzahl == freezed
          ? _value.anzahl
          : anzahl // ignore: cast_nullable_to_non_nullable
              as int,
      pfand: pfand == freezed
          ? _value.pfand
          : pfand // ignore: cast_nullable_to_non_nullable
              as bool,
      mengenAuswahl: mengenAuswahl == freezed
          ? _value.mengenAuswahl
          : mengenAuswahl // ignore: cast_nullable_to_non_nullable
              as String,
      auswahlTitle: auswahlTitle == freezed
          ? _value.auswahlTitle
          : auswahlTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      anmerkung: anmerkung == freezed
          ? _value.anmerkung
          : anmerkung // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$BestellElementCopyWith<$Res>
    implements $BestellElementCopyWith<$Res> {
  factory _$BestellElementCopyWith(
          _BestellElement value, $Res Function(_BestellElement) then) =
      __$BestellElementCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title,
      int anzahl,
      bool pfand,
      String mengenAuswahl,
      String? auswahlTitle,
      String? anmerkung});
}

/// @nodoc
class __$BestellElementCopyWithImpl<$Res>
    extends _$BestellElementCopyWithImpl<$Res>
    implements _$BestellElementCopyWith<$Res> {
  __$BestellElementCopyWithImpl(
      _BestellElement _value, $Res Function(_BestellElement) _then)
      : super(_value, (v) => _then(v as _BestellElement));

  @override
  _BestellElement get _value => super._value as _BestellElement;

  @override
  $Res call({
    Object? title = freezed,
    Object? anzahl = freezed,
    Object? pfand = freezed,
    Object? mengenAuswahl = freezed,
    Object? auswahlTitle = freezed,
    Object? anmerkung = freezed,
  }) {
    return _then(_BestellElement(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      anzahl: anzahl == freezed
          ? _value.anzahl
          : anzahl // ignore: cast_nullable_to_non_nullable
              as int,
      pfand: pfand == freezed
          ? _value.pfand
          : pfand // ignore: cast_nullable_to_non_nullable
              as bool,
      mengenAuswahl: mengenAuswahl == freezed
          ? _value.mengenAuswahl
          : mengenAuswahl // ignore: cast_nullable_to_non_nullable
              as String,
      auswahlTitle: auswahlTitle == freezed
          ? _value.auswahlTitle
          : auswahlTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      anmerkung: anmerkung == freezed
          ? _value.anmerkung
          : anmerkung // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BestellElement extends _BestellElement with DiagnosticableTreeMixin {
  _$_BestellElement(
      {required this.title,
      required this.anzahl,
      this.pfand = false,
      required this.mengenAuswahl,
      this.auswahlTitle,
      this.anmerkung})
      : super._();

  factory _$_BestellElement.fromJson(Map<String, dynamic> json) =>
      _$_$_BestellElementFromJson(json);

  @override
  final String title;
  @override
  final int anzahl;
  @JsonKey(defaultValue: false)
  @override
  final bool pfand;
  @override
  final String mengenAuswahl;
  @override
  final String? auswahlTitle;
  @override
  final String? anmerkung;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BestellElement(title: $title, anzahl: $anzahl, pfand: $pfand, mengenAuswahl: $mengenAuswahl, auswahlTitle: $auswahlTitle, anmerkung: $anmerkung)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BestellElement'))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('anzahl', anzahl))
      ..add(DiagnosticsProperty('pfand', pfand))
      ..add(DiagnosticsProperty('mengenAuswahl', mengenAuswahl))
      ..add(DiagnosticsProperty('auswahlTitle', auswahlTitle))
      ..add(DiagnosticsProperty('anmerkung', anmerkung));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BestellElement &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.anzahl, anzahl) ||
                const DeepCollectionEquality().equals(other.anzahl, anzahl)) &&
            (identical(other.pfand, pfand) ||
                const DeepCollectionEquality().equals(other.pfand, pfand)) &&
            (identical(other.mengenAuswahl, mengenAuswahl) ||
                const DeepCollectionEquality()
                    .equals(other.mengenAuswahl, mengenAuswahl)) &&
            (identical(other.auswahlTitle, auswahlTitle) ||
                const DeepCollectionEquality()
                    .equals(other.auswahlTitle, auswahlTitle)) &&
            (identical(other.anmerkung, anmerkung) ||
                const DeepCollectionEquality()
                    .equals(other.anmerkung, anmerkung)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(anzahl) ^
      const DeepCollectionEquality().hash(pfand) ^
      const DeepCollectionEquality().hash(mengenAuswahl) ^
      const DeepCollectionEquality().hash(auswahlTitle) ^
      const DeepCollectionEquality().hash(anmerkung);

  @JsonKey(ignore: true)
  @override
  _$BestellElementCopyWith<_BestellElement> get copyWith =>
      __$BestellElementCopyWithImpl<_BestellElement>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BestellElementToJson(this);
  }
}

abstract class _BestellElement extends BestellElement {
  factory _BestellElement(
      {required String title,
      required int anzahl,
      bool pfand,
      required String mengenAuswahl,
      String? auswahlTitle,
      String? anmerkung}) = _$_BestellElement;
  _BestellElement._() : super._();

  factory _BestellElement.fromJson(Map<String, dynamic> json) =
      _$_BestellElement.fromJson;

  @override
  String get title => throw _privateConstructorUsedError;
  @override
  int get anzahl => throw _privateConstructorUsedError;
  @override
  bool get pfand => throw _privateConstructorUsedError;
  @override
  String get mengenAuswahl => throw _privateConstructorUsedError;
  @override
  String? get auswahlTitle => throw _privateConstructorUsedError;
  @override
  String? get anmerkung => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$BestellElementCopyWith<_BestellElement> get copyWith =>
      throw _privateConstructorUsedError;
}
