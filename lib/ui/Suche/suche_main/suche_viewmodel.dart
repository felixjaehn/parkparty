import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SucheViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  String _searchQuery = "";
  String get query => _searchQuery;
  bool _showErrorScreen = false;
  bool get showErrorScreen => _showErrorScreen;
  List<Produkt> _suchErgebnisse = [];
  List<Produkt> get suchErgebnisse => _suchErgebnisse;

  void search(String query) async {
    setBusy(true);
    _searchQuery = query;
    List<Produkt> result = await _databaseService.search(query);
    _suchErgebnisse = result;
    setBusy(false);
    _showErrorScreen = _suchErgebnisse.isEmpty && _searchQuery != "";
    notifyListeners();
  }

  void onKategorienContainerTapped(int index) {
    _navigationService.navigateTo(
      Routes.kategorienView,
      arguments: KategorienViewArguments(index: index),
    );
  }

  void showDetails(Produkt produkt) {
    _navigationService.navigateTo(
      Routes.produktDetailsView,
      arguments: ProduktDetailsViewArguments(produkt: produkt),
    );
  }

  String getRandomHintText() {
    var rn = new Random().nextInt(3);
    List<String> hintTexts = [
      "Suche z.B. nach Frisbee...",
      "Suche z.B. nach Apfelschorle...",
      "Suche z.B. nach Copacabana...",
      "Suche z.B. nach UNO..."
    ];
    return hintTexts[rn];
  }

  Color getColorForKategorie(String kategorie) {
    switch (kategorie) {
      case "Picknick":
        return Color(0xffBF8EBC);
      case "Cocktails":
        return Color(0xff80A6F2);
      case "AlkFreeCocktails":
        return Color(0xffFEAA02);
      case "Softdrinks":
        return Color(0xffE39280);
      case "Snacks":
        return Color(0xffF26835);
      case "Alkoholhaltig":
        return Color(0xffC17D40);
      case "Sport&Freizeit":
        return Color(0xff30BF62);
      default:
        return Color(0xff30BF62);
    }
  }
}
