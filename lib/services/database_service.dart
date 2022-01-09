import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.logger.dart';
import 'package:parkparty/helper/firestore_caching.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/localstorage_service.dart';

class DatabaseService {
  final log = getLogger('DatenbankKontakt');
  final SharedPreferencesService _sharedPrefs =
      locator<SharedPreferencesService>();
  //Diverse Listen, welche die einzelnen Produktkategorien speichern
  List<Produkt> _cocktails = [];
  List<Produkt> _alcFreeCocktails = [];
  List<Produkt> _softdrinks = [];
  List<Produkt> _picknick = [];
  List<Produkt> _alkoholhaltig = [];
  List<Produkt> _snacks = [];
  List<Produkt> _sportFreizeit = [];
  List<Produkt> _pageView = [];

  Bestellung? aktiveBestellung;

  final CollectionReference produktCollection =
      FirebaseFirestore.instance.collection("produkte");
  //Dokument, welches die letzte Updatezeit speichert
  final DocumentReference<Map<String, dynamic>> cacheDocRef =
      FirebaseFirestore.instance.doc('utils/dokumentUpdates');

  //Dieses Feld beinhaltet letzte Updatezeit
  final String cacheField = 'updatedAt';

  late Widget wetterWidget;
  bool wetterWidgetExists = false;

  late Map<String, dynamic> musikEmpfehlung;
  bool musikEmpfehlungExists = false;

  void setWetter(Widget neuesWidget) {
    wetterWidget = neuesWidget;
    wetterWidgetExists = true;
  }

  List<Produkt> getListForKategorie(String kategorie) {
    switch (kategorie) {
      case "Cocktails":
        log.v("Angeforderte Liste wurde als CocktailListe abgerufen");
        return _cocktails;
      case "AlkFreeCocktails":
        log.v(
            "Angeforderte Liste wurde als AlkoholfreieCocktailListe abgerufen");
        return _alcFreeCocktails;
      case "Softdrinks":
        log.v("Angeforderte Liste wurde als SoftdrinkListe abgerufen");
        return _softdrinks;
      case "Picknick":
        log.v("Angeforderte Liste wurde als PicknickListe abgerufen");
        return _picknick;
      case "Alkoholhaltig":
        log.v("Angeforderte Liste wurde als AlkoholhaltigListe abgerufen");
        return _alkoholhaltig;
      case "Snacks":
        log.v("Angeforderte Liste wurde als SnacksListe abgerufen");
        return _snacks;
      case "Sport&Freizeit":
        log.v("Angeforderte Liste wurde als FreizeitListe abgerufen");
        return _sportFreizeit;
      case "PageView":
        log.v("Angeforderte Liste wurde als PageViewListe abgerufen");
        return _pageView;
      default:
        log.v("Sollte eigentlich nicht passiert sein");
        return _cocktails;
    }
  }

  void setListForKategorie(String kategorie, List<Produkt> neueProduktListe) {
    switch (kategorie) {
      case "Cocktails":
        _cocktails = neueProduktListe;
        break;
      case "AlkFreeCocktails":
        _alcFreeCocktails = neueProduktListe;
        break;
      case "Softdrinks":
        _softdrinks = neueProduktListe;
        break;
      case "Picknick":
        _picknick = neueProduktListe;
        break;
      case "Alkoholhaltig":
        _alkoholhaltig = neueProduktListe;
        break;
      case "Snacks":
        _snacks = neueProduktListe;
        break;
      case "Sport&Freizeit":
        _sportFreizeit = neueProduktListe;
        break;
      case "PageView":
        _pageView = neueProduktListe;
        break;
      default:
        _cocktails = neueProduktListe;
        log.v("Die Kategorie scheint nicht gepasst zu haben");
        break;
    }
  }

  Future<List<Produkt>> getProdukte(String kategorie) async {
    Trace trace = FirebasePerformance.instance.newTrace("Produktdatenabruf");
    if (getListForKategorie(kategorie).isNotEmpty) {
      return getListForKategorie(kategorie);
    } else {
      trace.start();
      List<Produkt> produktListe = [];
      final Query<Map<String, dynamic>> _query = FirebaseFirestore.instance
          .collection('produkte')
          .where("kategorie", isEqualTo: kategorie);
      final QuerySnapshot snapshot = await FirestoreCache.getDocuments(
          query: _query,
          cacheDocRef: cacheDocRef,
          localCacheKey:
              kategorie, //Soll dafür sorgen, dass SharedPrefs sich nicht doppeln
          firestoreCacheField: kategorie);
      for (DocumentSnapshot produktDoc in snapshot.docs) {
        final produktData = produktDoc.data() as Map<String, dynamic>;
        produktListe.add(
            Produkt.fromJson(produktData).copyWith(documentID: produktDoc.id));
      }
      setListForKategorie(kategorie, produktListe);
      trace.stop();
      return produktListe;
    }
  }

  Future<List<Produkt>> getPageViewProdukte() async {
    if (getListForKategorie("PageView").isNotEmpty) {
      return getListForKategorie("PageView");
    } else {
      List<String> pageViewKategorien = [
        "Cocktails",
        "Softdrinks",
        "Sport&Freizeit",
        "Snacks"
      ];
      List<Produkt> produktListe = [];
      for (String string in pageViewKategorien) {
        String storageKey = string + "pV";
        final Query<Map<String, dynamic>> _query = FirebaseFirestore.instance
            .collection('produkte')
            .where("kategorie", isEqualTo: string)
            .limit(1);
        final QuerySnapshot snapshot = await FirestoreCache.getDocuments(
            query: _query,
            cacheDocRef: cacheDocRef,
            localCacheKey:
                storageKey, //Soll dafür sorgen, dass SharedPrefs sich nicht doppeln
            firestoreCacheField: "PageView");
        for (DocumentSnapshot produktDoc in snapshot.docs) {
          final produktData = produktDoc.data() as Map<String, dynamic>;
          produktListe.add(Produkt.fromJson(produktData)
              .copyWith(documentID: produktDoc.id));
        }
      }
      setListForKategorie("PageView", produktListe);
      return produktListe;
    }
  }

  Future<List<Produkt>> search(String inputQuery) async {
    Trace trace = FirebasePerformance.instance.newTrace("Suchabruf");
    var lowerCased = inputQuery.toLowerCase();
    String condensed = lowerCased.replaceAll(RegExp(r"\s+"), "");
    String query = condensed;

    List<Produkt> tempErgebnis = [];
    trace.start();
    if (query.length >= 1) {
      final doc = await produktCollection
          .where(
            "search",
            isGreaterThanOrEqualTo: query,
            isLessThan: query.substring(0, max(query.length - 1, 0)) +
                String.fromCharCode(
                    query.codeUnitAt(max(query.length - 1, 0)) + 1),
          )
          .get();
      final docTags = await produktCollection
          .where(
            "searchTags",
            arrayContains: condensed,
          )
          .get();
      for (QueryDocumentSnapshot produktDoc in doc.docs) {
        final produktData = produktDoc.data() as Map<String, dynamic>;

        tempErgebnis.add(
          Produkt.fromJson(produktData).copyWith(documentID: produktDoc.id),
        );
      }
      for (QueryDocumentSnapshot produktDoc in docTags.docs) {
        final produktData = produktDoc.data() as Map<String, dynamic>;

        tempErgebnis.add(
          Produkt.fromJson(produktData).copyWith(documentID: produktDoc.id),
        );
      }
      List<Produkt> ergebnis = [];
      for (Produkt produkt in tempErgebnis) {
        if (!ergebnis.contains(produkt)) {
          ergebnis.add(produkt);
        }
      }
      trace.stop();
      return ergebnis;
    } else {
      trace.stop();
      return [];
    }
  }

  Future<Map<String, dynamic>> getMusikEmpfehlung() async {
    DocumentSnapshot value =
        await FirebaseFirestore.instance.doc('utils/songOfTheDay').get();
    Map<String, dynamic> result = value.data() as Map<String, dynamic>;
    musikEmpfehlung = result;
    musikEmpfehlungExists = true;
    return result;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> updateStream(
      String bestellDoc) {
    return FirebaseFirestore.instance
        .collection("bestellungen")
        .doc(bestellDoc)
        .snapshots();
  }

  Future<Bestellung> getAktiveBestellung() async {
    if (aktiveBestellung != null) {
      return aktiveBestellung!;
    }
    final String bestellDocID = _sharedPrefs.getBestellDocument();
    final _collectionRef =
        FirebaseFirestore.instance.collection("bestellungen");
    final docSnapshot = await _collectionRef.doc(bestellDocID).get();
    final data = docSnapshot.data()!;
    Bestellung _tempBestellung = Bestellung.fromJson(data);
    aktiveBestellung = _tempBestellung;
    return _tempBestellung;
  }

  Future<int> verfuegbareAnzahl(Produkt produkt) async {
    String _docPath = "produkte/" + produkt.documentID;
    DocumentSnapshot _documentSnapshot =
        await FirebaseFirestore.instance.doc(_docPath).get();
    Map<String, dynamic> _result =
        _documentSnapshot.data() as Map<String, dynamic>;
    return _result["anzahl"] ?? 100;
  }

  Future<bool> listContainsID(String deviceID) async {
    final doc = await produktCollection
        .where(
          "deviceID",
          isEqualTo: deviceID,
        )
        .get();

    print("Account auf Blacklist: ${doc.docs.isEmpty}");
    print(doc.docs);
    return doc.docs.isEmpty;
  }
}
