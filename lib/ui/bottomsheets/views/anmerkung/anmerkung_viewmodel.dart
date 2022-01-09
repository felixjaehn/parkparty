import 'package:flutter/cupertino.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';

class AnmerkungViewModel extends BaseViewModel {
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  late WarenkorbElement _warenkorbElement;
  late int elementIndex;

  late TextEditingController _textController;
  TextEditingController get textController => _textController;

  WarenkorbElement get warenkorbElement => _warenkorbElement;

  void setUp(int index) {
    _warenkorbElement = _warenkorbService.warenkorb[index];
    elementIndex = index;
    if (_warenkorbElement.anmerkung == null)
      _textController = TextEditingController();
    else {
      _textController =
          TextEditingController(text: _warenkorbElement.anmerkung);
    }
  }

  void clearInput() {
    textController.clear();
    notifyListeners();
  }

  ///Speichert den Input des TextFields im WarenkorbElement
  void saveInput() {
    if (_textController.text == "")
      _warenkorbService.removeAnmerkung(elementIndex);
    _warenkorbService.addAnmerkung(elementIndex, _textController.text);
  }
}
