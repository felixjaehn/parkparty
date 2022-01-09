import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/enums/dialog_type.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.pfandHinweis: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
    DialogType.paymentDone: (context, sheetRequest, completer) =>
        _PaymentDoneDialog(request: sheetRequest, completer: completer),
  };
  dialogService.registerCustomDialogBuilders(builders);
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _BasicDialog({Key? key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200,
        color: Colors.white,
      ),
    );
  }
}

class _PaymentDoneDialog extends StatelessWidget {
  final DialogRequest? request;
  final Function(DialogResponse)? completer;
  const _PaymentDoneDialog({Key? key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 26, vertical: 24.0),
      child: GestureDetector(
        onTap: () => completer!(
          DialogResponse(confirmed: true),
        ),
        child: Container(
            height: screenHeight(context) * 0.32,
            width: screenWidth(context) * 0.86,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: largeRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CupertinoColors.activeGreen),
                    child: Center(
                      child: Transform.scale(
                        scale: 2.1,
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Zahlung erfolgreich!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Nun sind wir am Zuge, die Vorbereitung deiner Bestellung beginnt sofort.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
