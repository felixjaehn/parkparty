import 'package:flutter/cupertino.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:parkparty/models/produkte.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class KategorienListeViewModel extends BaseViewModel {
  ///Dependency Injection
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final NavigationService _navigationService = locator<NavigationService>();

  ///Dies ist der Controller für die Positioned_ScrollableList
  final ScrollController scrollController = ScrollController();

  void showDetails(Produkt produkt) {
    _navigationService.navigateTo(
      Routes.produktDetailsView,
      arguments: ProduktDetailsViewArguments(produkt: produkt),
    );
  }

  Future showProduktBestaetigung(int index, Produkt produkt, int laenge) async {
    var sheetResponse = await _bottomSheetService.showCustomSheet(
      customData: produkt,
      isScrollControlled: true,
      variant: produkt.mehrfachAuswahlVorhanden
          ? BottomSheetType.mehrfachAuswahl
          : BottomSheetType.produktBestaetigung,
    );

    print('confirmationResponse confirmed: ${sheetResponse?.confirmed}');
  }
}
