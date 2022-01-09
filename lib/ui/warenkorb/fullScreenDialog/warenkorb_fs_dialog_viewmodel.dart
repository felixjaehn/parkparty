import 'package:flutter/cupertino.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/localstorage_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

class WarenkorbDialogViewModel extends ReactiveViewModel {
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final SharedPreferencesService _sharedPrefs =
      locator<SharedPreferencesService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_warenkorbService];

  double get warenkorbPreis => _warenkorbService.warenkorbPreis;
  double get pfandPreis => _warenkorbService.getPfandPreis();
  int get warenkorbElemente => _warenkorbService.warenkorbElemente;
  bool get checkoutAllowed => !_sharedPrefs.checkForBestellDocument();
  List<WarenkorbElement> get warenkorbListe => _warenkorbService.warenkorb;

  List<int> helperList = [];

  void close() {
    _warenkorbService.allesUpdaten();
    _navigationService.back();
  }

  void openCheckout() async {
    if (_warenkorbService.alterBestaetigt) {
      _navigationService.navigateTo(Routes.checkoutView);
      return;
    }
    if (!_warenkorbService.alkoholhaltig) {
      _navigationService.navigateTo(Routes.checkoutView);
    } else {
      var response = await _dialogService.showConfirmationDialog(
        title: "Jugenschutzabfrage",
        description:
            "Da dein Warenkorb alkoholhaltige Produkte beinhaltet, bitten wir dich kurz zu bestätigen, dass du über 18 Jahre alt bist.",
        cancelTitle: "Abbrechen",
        confirmationTitle: "Bestätigen",
        dialogPlatform: DialogPlatform.Cupertino,
      );
      if (response!.confirmed) {
        _warenkorbService.setAb18();
        _navigationService.navigateTo(Routes.checkoutView);
      }
    }
  }

  bool checkIfExpanded(index) {
    if (helperList.contains(index)) {
      return true;
    }
    return false;
  }

  void expand(int index) {
    if (!checkIfExpanded(index)) {
      helperList.clear();
      helperList.add(index);
    } else {
      helperList.clear();
    }

    notifyListeners();
  }

  void bearbeitung(int index) async {
    await _bottomSheetService.showCustomSheet(
      isScrollControlled: true,
      customData: index,
      variant: warenkorbListe[index].mehrfachAuswahlVorhanden
          ? BottomSheetType.mehrfachBearbeitung
          : BottomSheetType.produktBearbeitung,
    );
  }

  void showAnmerkungBottomSheet(int index) async {
    await _bottomSheetService.showCustomSheet(
      isScrollControlled: true,
      customData: index,
      variant: BottomSheetType.anmerkung,
    );
  }

  void goToKategorien() {
    _navigationService.navigateTo(
      Routes.kategorienView,
      arguments: KategorienViewArguments(index: 0),
    );
  }

  Color evaluateColor(index) {
    switch (warenkorbListe[index].anzahl) {
      case 0:
        return Colors.grey;
      case 1:
        return CupertinoColors.destructiveRed;
      default:
        return Colors.black;
    }
  }

  Row getSubtitle(index) {
    return _warenkorbService.getSubtitle(index);
  }

  ///Diese Funktion verändert die gewählte Menge unter Beachtung der gegebenen Grenzen
  void add(int index) {
    if (_warenkorbService.warenkorb[index].anzahl <= 68)
      _warenkorbService.bearbeiteElement(
          index, _warenkorbService.warenkorb[index].anzahl + 1);
    notifyListeners();
  }

  void subtract(int index) {
    if (_warenkorbService.warenkorb[index].anzahl > 1)
      _warenkorbService.bearbeiteElement(
          index, _warenkorbService.warenkorb[index].anzahl - 1);
    else {
      _warenkorbService.removeAtIndex(index);
      helperList.clear();
    }

    notifyListeners();
  }
}
