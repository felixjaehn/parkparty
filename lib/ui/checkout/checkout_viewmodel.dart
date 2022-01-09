import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/location_service.dart';
import 'package:parkparty/services/payment_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class CheckoutViewModel extends ReactiveViewModel {
  //Dependency injection
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final PaymentService _paymentService = locator<PaymentService>();
  final LocationService _locationService = locator<LocationService>();

  //Sonstige
  String lieferHinweis = "Hier kannst du gerne weitere Hinweise loswerden";
  ScrollController _scrollController = ScrollController();
  List<double> _widgethoehen = [220, 400, 400, 400, 400];
  List<bool> _erfolgreich = [true, false, true, true, true];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showDatenSubtitle = false;
  String ausgewaehlteZahlung = "PayPal"; //"Credit","Barzahlung","GooglePay"
  String name = "";
  String mail = "";
  String phone = "";

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_warenkorbService, _locationService];

  double get warenkorbPreis => _warenkorbService.warenkorbPreis;
  List<WarenkorbElement> get warenkorbListe => _warenkorbService.warenkorb;
  ScrollController get scrollController => _scrollController;
  bool get allesFertig => !_erfolgreich.contains(false);
  bool get ab18 => _warenkorbService.alkoholhaltig;
  GlobalKey<FormState> get datenFormKey => _formKey;

  void setZahlmethode(String neueZahlung) {
    if (neueZahlung == ausgewaehlteZahlung)
      return;
    else {
      ausgewaehlteZahlung = neueZahlung;
      notifyListeners();
    }
  }

  void editLocationView() {
    _navigationService.navigateTo(Routes.retryMapsView);
  }

  String getBezahlmethode(bool subtitleHeaderText) {
    if (subtitleHeaderText) {
      switch (ausgewaehlteZahlung) {
        case "Credit":
          return "Wir leiten dich gleich auf eine gesichterte Seite zur Zahlungsabwicklung weiter";
        case "PayPal":
          return "Wir werden dich gleich auf eine gesicherte Seite von PayPal weiterleiten";
        case "Barzahlung":
          return "Du bezahlst deine Bestellung in Bar bei Erhalt der Lieferung. Der Lieferant wird eventuelles Wechselgeld bereithalten.";
        case "GooglePay":
          return "Wir werden dich gleich auf eine gesicherte Seite weiterleiten um die Zahlung mit GooglePay abzuwickeln.";
        default:
          return "Du hast noch keine Bezahlmethode ausgewaehlt";
      }
    } else {
      switch (ausgewaehlteZahlung) {
        case "Credit":
          return "mit Karte bezahlen";
        case "PayPal":
          return "mit PayPal bezahlen";
        case "Barzahlung":
          return "bei Erhalt bezahlen";
        case "GooglePay":
          return "mit GooglePay bezahlen";
        default:
          return "Bezahlen";
      }
    }
  }

  void executePayment() async {
    final String? hinweis =
        lieferHinweis == "Hier kannst du gerne weitere Hinweise loswerden"
            ? null
            : lieferHinweis;
    setBusy(true);
    await _paymentService.executePayment(
      ausgewaehlteZahlung,
      name,
      mail,
      phone,
      hinweis,
      true,
    );
    setBusy(false);
  }

  String getIcon(index) {
    if (headerGeschlossen(index) && _erfolgreich[index])
      return "assets/success.svg";
    if (headerGeschlossen(index) && !_erfolgreich[index])
      return "assets/failed.svg";
    return "assets/idle.svg";
  }

  void saveName(String val) => name = val;
  void saveMail(String val) => mail = val;
  void savePhone(String val) => phone = val;

  ///Diese Funktion gibt anhand des Index zurück ob der Header gerade geschlossen ist
  bool headerGeschlossen(index) {
    if (scrollController.offset >= widgetPosition(index + 1) - 15)
      return true;
    else
      return false;
  }

  String getText() {
    if (_erfolgreich[1]) return "Deine Eingaben wurden erfolgreich gespeichert";
    return "Deine Eingaben sind unvollständig. Bitte überprüfe diese noch einmal bevor du fortfährst.";
  }

  void validateForm() {
    if (_formKey.currentState!.validate()) {
      _erfolgreich[1] = true;
      showDatenSubtitle = false;
      _formKey.currentState!.save();
      return;
    }
    showDatenSubtitle = true;
    _erfolgreich[1] = false;
  }

  ///Sobald das Widget gerendert wird,
  ///wird die Höhe dieses Widgets in logischen Pixeln hier gespeichert
  void setzeHoehe(int index, double hoehe) {
    _widgethoehen[index] = hoehe;
  }

  ///Diese Funktion berechnet die relative WidgetPosition anhand der [_widgethoehen] und dem
  ///übergebenen [index]
  double widgetPosition(int index) {
    double sum = 0;
    for (var i = 0; i < index; i++) {
      sum += _widgethoehen[i];
    }
    return sum;
  }

  ///Diese Funktion öffnet das Textfeld für weitere Hinweise. Dies ist nötig, da das normale
  ///Textfeld unter normalen Umständen nicht in den sichtbaren Bereich gescrollt wird
  void openTextSheet() async {
    var response = await locator<BottomSheetService>().showCustomSheet(
        isScrollControlled: true,
        variant: BottomSheetType.lieferHinweis,
        customData: lieferHinweis);
    if (response != null) lieferHinweis = response.responseData;
  }

  ///Diese Funktion animiert den ScrollController zur übergebenen [position]
  void animatePosition(int index) {
    _scrollController.animateTo(widgetPosition(index),
        duration: Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  void goBack() {
    _navigationService.back();
  }

  void openWarenkorb() {
    _navigationService.navigateTo(
      Routes.warenkorbDialogView,
      arguments: WarenkorbDialogViewArguments(alreadyInCheckout: true),
    );
  }
}
