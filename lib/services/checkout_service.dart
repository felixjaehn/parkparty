import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/dialog_type.dart';
import 'package:parkparty/exceptions/firestore_exceptions.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/services/localstorage_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'location_service.dart';

class CheckoutService {
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final LocationService _locationService = locator<LocationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedPreferencesService _sharedPrefService = locator<SharedPreferencesService>();

  late String? deviceID;
  bool blocked = false;

  List<Map<String, dynamic>> failProdukte = [];
  String activeDeliveryDocument = "";
  Bestellung bestellung = Bestellung(deviceID: "", bestellInhalt: []);
  String _name = "";
  String _mail = "";
  String _phone = "";
  String? _lieferHinweis;
  // {
  //   "produkt": null,
  //   "warenkorbElment": null,
  //   "anzahl": null,
  // };
  Future<String> addDeviceID() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceID = iosDeviceInfo.identifierForVendor;
      bestellung = bestellung.copyWith(deviceID: iosDeviceInfo.identifierForVendor);
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceID = androidDeviceInfo.androidId;
      bestellung = bestellung.copyWith(deviceID: androidDeviceInfo.androidId);
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  Future<bool> checkIfBlocked() async {
    if (blocked) {
      return blocked;
    } else {
      if (deviceID == null) {
        await addDeviceID();
      }
      final bool _blocked = await _databaseService.listContainsID(deviceID!);
      if (_blocked) blocked = true;
      print("CheckoutService gibt zurück: $_blocked");
      return _blocked;
    }
  }

  void saveData(String name, String mail, String phone, String? lieferHinweis) {
    _name = name;
    _mail = mail;
    _phone = phone;
    _lieferHinweis = lieferHinweis;
  }

  //Schließt Bestellung ab
  Future<void> completeBestellung(String bezahlMethode) async {
    LatLng latlng = _locationService.lastLocation["location"];
    bestellung = bestellung.copyWith(
      bestellZeitpunkt: DateTime.now(),
      // lieferLocation: _locationService.lastLocation["location"],
      bezahlMethode: bezahlMethode,
      gesamtPreis: _warenkorbService.warenkorbPreis,
      bestellInhalt: _warenkorbService.warenkorb.map((wE) {
        final AuswahlElement _auswahl = wE.endAuswahl ?? AuswahlElement(title: "keineAuswahl");
        final MengenAuswahl _menge = wE.mengenWahl ?? MengenAuswahl(title: "keineAuswahl");
        return BestellElement(
                mengenAuswahl: _menge.title,
                title: wE.name,
                anzahl: wE.anzahl,
                anmerkung: wE.anmerkung ?? null,
                auswahlTitle: _auswahl.title,
                pfand: wE.pfandAusgewaehlt)
            .toJson();
      }).toList(),
      name: _name,
      mail: _mail,
      phone: _phone,
      lieferHinweis: _lieferHinweis,
      ab18: _warenkorbService.alkoholhaltig,
    );
    try {
      final bestellungDocument = FirebaseFirestore.instance.collection('bestellungen').doc();
      final Map<String, dynamic> bestellDetails = bestellung.toJson();
      bestellDetails["lastLocation"] = GeoPoint(latlng.latitude, latlng.longitude);
      print(bestellDetails);
      await bestellungDocument.set(bestellDetails);
      activeDeliveryDocument = bestellungDocument.id;
      _sharedPrefService.setBestellDocument(activeDeliveryDocument);
      print(bestellungDocument.id);
    } catch (error) {
      _dialogService.showDialog(
        title: "Verbindungsproblem",
        description: "Die Verbindung zur Datenbank konnte nicht aufgebaut werden. Bitte versuche es erneut",
        buttonTitle: "OK",
      );
      throw FirestoreApiException(
        message: 'Failed to add document',
        devDetails: '$error',
      );
    }
    _navigationService.clearTillFirstAndShow(Routes.lieferFortschrittView);
    _warenkorbService.removeAlles();
    await _dialogService.showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.paymentDone,
    );
  }

  Future<List> checkVerfuegbarkeit() async {
    List<WarenkorbElement> _warenkorb = _warenkorbService.warenkorb;
    failProdukte = [];
    for (WarenkorbElement wE in _warenkorb) {
      int _anzahl = await _databaseService.verfuegbareAnzahl(wE.produkt);
      if (_anzahl < wE.anzahl) {
        failProdukte.add({
          "produkt": wE.produkt,
          "warenkorbElement": wE,
          "verfuegbar": _anzahl,
        });
      }
    }
    return failProdukte;
  }
}
