import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:intl/intl.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:stacked_services/stacked_services.dart';

import 'checkout_service.dart';
import 'error_service.dart';
import 'warenkorb_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PaymentService {
  final NavigationService _navigationService = locator<NavigationService>();
  final CheckoutService _checkoutService = locator<CheckoutService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final ErrorService _errorService = locator<ErrorService>();
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final DialogService _dialogService = locator<DialogService>();

  void executeGeneralPayment(double amount) async {
    var request = BraintreeDropInRequest(
      tokenizationKey: dotenv.env["PAYPAL_KEy"],
      collectDeviceData: true,
      cardEnabled: true,
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: amount.toString(),
        currencyCode: 'EUR',
        billingAddressRequired: false,
      ),
      paypalRequest: BraintreePayPalRequest(amount: amount.toString(), currencyCode: 'EUR', displayName: "Chilled"),
    );
    BraintreeDropInResult? result = await BraintreeDropIn.start(request);
    if (result != null) {
      print(result.paymentMethodNonce.description);
      print(result.paymentMethodNonce.nonce);
      _navigationService.navigateTo(Routes.lieferFortschrittView);
    }
  }

  Future<bool> executePayPalPayment(double amount) async {
    final _request = BraintreePayPalRequest(
      billingAgreementDescription: "Ich stimme zu, dass meine Zahlungsdaten zur Validation übermittelt werden",
      amount: NumberFormat.currency(locale: 'eu', symbol: '').format(amount),
    );

    BraintreePaymentMethodNonce? _result = await Braintree.requestPaypalNonce('sandbox_bnmkdd5s_rg4z7kwtv5cxqsg9', _request);
    if (_result != null) {
      print(_result.description);
      print(_result.nonce);
      return true;
    }
    return false;
  }

  Future<void> executePayment(String zahlMethode, String? name, String? mail, String? phone, String? lieferHinweis, bool needsToCheck) async {
    if (needsToCheck) {
      _checkoutService.saveData(name ?? "Fail", mail ?? "Fail", phone ?? "Fail", lieferHinweis);
      if (await checkVerfuegbarkeit(zahlMethode)) {
        return;
      }
    }
    final String _deviceID = await _checkoutService.addDeviceID();
    switch (zahlMethode) {
      case "Barzahlung":
        final bool blocked = await _checkoutService.checkIfBlocked();
        if (blocked) {
          await _errorService.showBlockedDialog(_deviceID);
          return;
        }
        break;
      default:
        final bool successful = await executePayPalPayment(_warenkorbService.warenkorbPreis);
        if (!successful) {
          return;
        }
    }
    await _checkoutService.completeBestellung(zahlMethode);
  }

  Future<bool> checkVerfuegbarkeit(String zahlMethode) async {
    List fails = await _checkoutService.checkVerfuegbarkeit();
    try {
      if (fails.isNotEmpty) {
        await _bottomSheetService.showCustomSheet(
          customData: {
            "list": fails,
            "method": zahlMethode,
          },
          isScrollControlled: true,
          variant: BottomSheetType.verfuegbarkeit,
        );
        return true;
      }
      return false;
    } catch (e) {
      _dialogService.showDialog(
        title: "Verbindungsproblem",
        description: "Die Verbindung zur Datenbank konnte nicht aufgebaut werden. Bitte versuche es erneut",
        buttonTitle: "OK",
      );
      return false;
    }
  }
}
