import 'package:flutter/material.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/services/error_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ErkundenPageViewModel extends BaseViewModel {
  //dependency injection
  final DatabaseService _databaseService = locator<DatabaseService>();
  final ErrorService _errorService = locator<ErrorService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  double _currentPage = 0.0;
  double get currentPage => _currentPage;

  PageController pageController = PageController();
  DatabaseService get databaseService => _databaseService;

  void goToKategorien(index) {
    locator<NavigationService>().navigateTo(
      Routes.kategorienView,
      arguments: KategorienViewArguments(index: index),
    );
  }

  Future<List<Produkt>> getProdukte() async {
    if (_errorService.verbindungsVersuche == 0) return [];
    List<Produkt> _result = await _databaseService.getPageViewProdukte();
    if (_result.isEmpty || _result == []) {
      _errorService.beendeVersuche();
      await _dialogService.showDialog(
        title: "Verbindungsproblem",
        description:
            "Ohne Internetverbindung können wir leider keine Produkte laden. Bitte stelle eine Internetverbindung her.",
        buttonTitle: "OK",
        dialogPlatform: DialogPlatform.Cupertino,
        barrierDismissible: false,
      );
    }

    return _result;
  }

  void showDetails(Produkt produkt) {
    _navigationService.navigateTo(
      Routes.produktDetailsView,
      arguments: ProduktDetailsViewArguments(produkt: produkt),
    );
  }

  bool onPageScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics && metrics.page != null) {
      _currentPage = metrics.page!;
      notifyListeners();
    }
    return false;
  }
}
