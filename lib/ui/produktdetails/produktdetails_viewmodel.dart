import 'package:flutter/material.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/ui/bottomsheets/base.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:stacked_services/stacked_services.dart';

class ProduktDetailsViewModel extends BaseAuswahlViewModel {
  //Dependency Injection
  final NavigationService _navigationService = locator<NavigationService>();

  final PageController _pageController = PageController(initialPage: 1);
  final PanelController _panelController = PanelController();

  bool hinzugefuegt = false;

  PageController get pageController => _pageController;
  PanelController get panelController => _panelController;

  void hideBanner() {
    hinzugefuegt = false;
    notifyListeners();
  }

  void showAuswahl() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
    if (_panelController.isAttached) {
      _panelController.animatePanelToPosition(
          produkt.auswahlElemente.length > 2 ? 0.42 : 0,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    }
  }

  void showHinweise() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
    if (_panelController.isAttached) {
      _panelController.animatePanelToPosition(0,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void showMainScreen() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(1,
          duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
    if (_panelController.isAttached) {
      _panelController.animatePanelToPosition(
          produkt.zutatenListe.isEmpty ? 0 : 0.64,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut);
    }
  }

  @override
  void addToCart() {
    updateWarenkorbElement();
    if (!warenkorbService.pruefeObVorhanden(
        warenkorbElementLight, warenkorbElement)) {
      warenkorbService.addtoWarenkorb(warenkorbElement, warenkorbElementLight);
    }
    hinzugefuegt = true;
    setProduktAnzahl(1);
    notifyListeners();
    Future.delayed(Duration(seconds: 8)).then((value) {
      hinzugefuegt = false;
      notifyListeners();
    });
  }

  void goBack() {
    _navigationService.back();
  }

  void openCheckout() {
    hinzugefuegt = false;
    _navigationService.replaceWith(Routes.warenkorbDialogView);
  }

  String getPrettyString(String kategorie) {
    switch (kategorie) {
      case "Cocktails":
        return "Cocktail";
      case "AlkFreeCocktails":
        return "Alkoholfreier Cocktail";
      case "Softdrinks":
        return "Erfrischender Softdrink";
      case "Picknick":
        return "Picknick";
      case "Alkoholhaltig":
        return "Alkoholhaltiges Getränk";
      case "Snacks":
        return "Snack";
      case "Sport&Freizeit":
        return "Sport&Freizeit";
      default:
        return "Lieferangebot";
    }
  }
}
