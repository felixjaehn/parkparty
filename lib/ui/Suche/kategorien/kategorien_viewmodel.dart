import 'package:flutter/cupertino.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class KategorienViewModel extends ReactiveViewModel {
  //Dependency Injection
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_warenkorbService];

  //Variablendeklaration
  bool isFirst = true;
  int initialIndex = 0;
  double _currentOffset = 0.0;
  final ScrollController _scrollController = ScrollController();

  final List<String> _kategorien = [
    "Cocktails",
    "AlkFreeCocktails",
    "Softdrinks",
    "Picknick",
    "Alkoholisches",
    "Snacks",
    "Sport&Freizeit"
  ];
  final List<double> _textBreiten = [120, 120, 120, 120, 120, 120, 120];
  late List<Produkt> produkte;

  List<double> get textBreiten => _textBreiten;
  List<String> get kategorien => _kategorien;
  ScrollController get scrollController => _scrollController;
  double get warenkorbPreis => _warenkorbService.warenkorbPreis;
  int get warenkorbElemente => _warenkorbService.warenkorbElemente;
  double get currentOffset => _currentOffset;

  ///Funktion die den an die View übergebenen Index verarbeitet
  void setUp(int index) {
    initialIndex = index;
  }

  ///Erst wenn alles fertig ist, animiert diese Funktion zur entsprechenden Position
  void secondSetUp(int index) {
    print(index);
    _scrollController.animateTo(aufsummieren(index),
        duration: Duration(milliseconds: 120 * index), curve: Curves.easeInOut);
    print("Scroll Controller tut was");
    _currentOffset = index.toDouble();
    notifyListeners();
  }

  //Funktion die die Breiten der Texte in der ScrollView verarbeitet
  void handleSizes(Size size, int index) {
    _textBreiten[index] = size.width;
    Future.delayed(Duration(microseconds: 10), () {
      if (isFirst) {
        secondSetUp(initialIndex);
        isFirst = false;
      }
    });
  }

  ///Dient dazu die Produkte abzurufen. Hierbei hilft der DatenbankService
  Future<List<Produkt>> getServiceProdukte(String kategorie) async {
    List<Produkt> _result = await _databaseService.getProdukte(kategorie);
    produkte = _result;
    return _result;
  }

  ///Diese Funktin hilft bei der Kopplung von PageView und ScrollView
  bool onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics && metrics.page != null) {
      _scrollController.jumpTo(aufsummieren(metrics.page!.round()));
      _currentOffset = metrics.page!;
      notifyListeners();
    }
    return false;
  }

  ///Interne Funktion um ScrollPosition zu verarbeiten
  double aufsummieren(index) {
    double sum = 0;
    for (var i = 0; i < index; i++) {
      sum += _textBreiten[i];
    }
    return sum;
  }

  ///Navigiert zum Warenkorb
  void openWarenkorb() {
    _navigationService.navigateTo(
      Routes.warenkorbDialogView,
    );
  }

  ///Navigiert zurück
  void close() {
    _navigationService.back();
  }
}
