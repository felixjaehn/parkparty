import 'package:parkparty/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'dart:io';

///Dieser Service dient dem Anzeigen von Error-Dialögen bzw. der Evaluation des weiteren Vorgehens bei Ablauffehlern
class ErrorService {
  //Dependeny Injection
  final DialogService _dialogService = locator<DialogService>();

  final bool plattformisAndroid = Platform.isAndroid;
  bool showedLoadingError = false;
  int verbindungsVersuche = 2;

  void reduziereVersuche() {
    verbindungsVersuche -= 1;
  }

  void beendeVersuche() {
    verbindungsVersuche = 0;
  }

  ///Zeigt Standard Error Dialog im Plattform Stil. Sinnvoll für normal wichtige Meldungen, welche sich so zeigen sollten wie der Nutzer
  ///es erwartet
  void showStandardErrorDialog(
      String title, String subtitle, String actionText) async {
    await _dialogService.showDialog(
      title: title,
      description: subtitle,
      buttonTitle: actionText,
      dialogPlatform: DialogPlatform.Cupertino,
      barrierDismissible: true,
    );
  }

  void showLoadingErrorDialog() async {
    if (showedLoadingError) {
      return;
    }
    await _dialogService.showDialog(
      title: "Verbindungsproblem",
      description:
          "Wir konnten leider keine Daten laden, dies liegt möglicherweise an einer schwachen Internetverbindung.",
      buttonTitle: "OK",
      dialogPlatform: DialogPlatform.Cupertino,
      barrierDismissible: true,
    );
    showedLoadingError = true;
  }

  Future<void> showBlockedDialog(String deviceID) async {
    await _dialogService.showDialog(
      title: "Gesperrt",
      description:
          "Aufgrund von verdächtigen Aktivitäten auf diesem Gerät, bist du momentan vom Bestellabschluss mit Barzahlung ausgeschlossen. Sollte dies ein Irrtum sein, so nimm bitte Kontakt zu uns auf! (Code: ${deviceID.substring(deviceID.length - 5)})",
      buttonTitle: "OK",
      dialogPlatform: DialogPlatform.Cupertino,
      barrierDismissible: true,
    );
    showedLoadingError = true;
  }
}
