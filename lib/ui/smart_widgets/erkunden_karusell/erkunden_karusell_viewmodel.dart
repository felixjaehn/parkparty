import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/services/error_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class KarusellViewModel extends BaseViewModel {
  ///Dependency Injection
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final ErrorService _errorService = locator<ErrorService>();
  final NavigationService _navigationService = locator<NavigationService>();

  int get verbindungsVersuche => _errorService.verbindungsVersuche;
  DatabaseService get databaseService => _databaseService;

  ///Navigiert zu der Kategorie nach dem Klicken auf "Alle anzeigen"
  void goToKategorie(int index) {
    locator<NavigationService>().navigateTo(
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

  Future showProduktBestaetigung(Produkt produkt) async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      customData: produkt,
      isScrollControlled: true,
      variant: produkt.mehrfachAuswahlVorhanden
          ? BottomSheetType.mehrfachAuswahl
          : BottomSheetType.produktBestaetigung,
    );

    print('confirmationResponse confirmed: ${sheetResponse?.confirmed}');
  }

  Future<List<Produkt>> getServiceProdukte(String kategorie) async {
    if (verbindungsVersuche == 0) {
      return [];
    }
    try {
      List<Produkt> _result =
          await _databaseService.getProdukte(kategorie).timeout(
                Duration(seconds: 8),
              );
      if (_result.isEmpty || _result == []) {
        _errorService.beendeVersuche();
        return [];
      }
      return _result;
    } catch (e) {
      _errorService.beendeVersuche();
      _errorService.showLoadingErrorDialog();
      return [];
    }
  }
}
