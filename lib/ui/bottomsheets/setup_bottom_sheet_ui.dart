import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:parkparty/ui/bottomsheets/views/anmerkung/anmerkung_view.dart';
import 'package:parkparty/ui/bottomsheets/views/lieferhinweis/lieferhinweis_view.dart';
import 'package:parkparty/ui/bottomsheets/views/location/lieferPosition_view.dart';
import 'package:parkparty/ui/bottomsheets/views/produktauswahl/produktauswahl_bottomsheet_view.dart';
import 'package:parkparty/ui/bottomsheets/views/produktbearbeitung/produktbearbeitung_view.dart';
import 'package:stacked_services/stacked_services.dart';

import 'views/lieferDetails/lieferDetails_view.dart';
import 'views/produkt_mehrfachauswahl/mehrfachauswahl_bottomsheet_view.dart';
import 'views/produkt_mehrfachbearbeitung/mehrfachbearbeitung_bottomsheet_view.dart';
import 'views/verfuegbarkeit/verfuegbarkeit_view.dart';

void setupBottomSheetUi() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    BottomSheetType.produktBestaetigung: (context, sheetRequest, completer) =>
        ProduktAuswahlBottomSheetView(
          produkt: sheetRequest.customData,
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.mehrfachAuswahl: (context, sheetRequest, completer) =>
        MehrfachAuswahlBottomSheetView(
          produkt: sheetRequest.customData,
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.produktBearbeitung: (context, sheetRequest, completer) =>
        ProduktBearbeitungView(
          index: sheetRequest.customData,
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.mehrfachBearbeitung: (context, sheetRequest, completer) =>
        MehrfachBearbeitungBottomSheetView(
          index: sheetRequest.customData,
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.anmerkung: (context, sheetRequest, completer) =>
        AnmerkungView(
          index: sheetRequest.customData,
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.lieferHinweis: (context, sheetRequest, completer) =>
        LieferhinweisView(
          hinweisText: sheetRequest.customData,
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.lieferPosition: (context, sheetRequest, completer) =>
        LieferPositionView(
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.verfuegbarkeit: (context, sheetRequest, completer) =>
        VerfuegbarkeitView(
          input: sheetRequest.customData,
          request: sheetRequest,
          completer: completer,
        ),
    BottomSheetType.lieferDetails: (context, sheetRequest, completer) =>
        LieferDetailsView(
          request: sheetRequest,
          completer: completer,
        ),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}
