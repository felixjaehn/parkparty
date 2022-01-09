import 'package:flutter/material.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:parkparty/services/localstorage_service.dart';
import 'package:parkparty/services/location_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavigationViewModel extends ReactiveViewModel {
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final LocationService _locationService = locator<LocationService>();
  final SharedPreferencesService _sharedPrefs =
      locator<SharedPreferencesService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_warenkorbService];
  int _currentTabIndex = 0;
  bool _reverse = false;
  bool get bestellungAktiv => _sharedPrefs.checkForBestellDocument();
  int get currentTabIndex => _currentTabIndex;
  int get warenkorbElemente => _warenkorbService.warenkorbElemente;
  //TODO: Sobald Löschung der Pref implementiert abändern
  bool get shouldShowBottomSheet =>
      !_locationService.showedLieferPostionAbfrage &&
      !_sharedPrefs.checkForBestellDocument();

  /// Indicates whether we're going forward or backward in terms of the index we're changing.
  /// This is very helpful for the page transition directions.
  bool get reverse => _reverse;
  final _navigationService = locator<NavigationService>();

  void goToDialog() {
    _navigationService.navigateTo(Routes.kategorienView);
  }

  void showLieferPositionAbfrage() async {
    if (shouldShowBottomSheet) {
      WidgetsBinding.instance!.addPostFrameCallback((duration) async {
        await Future.delayed(Duration(seconds: 1));

        await _bottomSheetService.showCustomSheet(
          isScrollControlled: true,
          variant: BottomSheetType.lieferPosition,
        );

        _locationService.setTrue();
      });
    }
    _sharedPrefs.getBestellDocument();
  }

  void setTabIndex(int value) {
    if (value < _currentTabIndex) {
      _reverse = true;
    } else {
      _reverse = false;
    }
    _currentTabIndex = value;
    notifyListeners();
  }
}
