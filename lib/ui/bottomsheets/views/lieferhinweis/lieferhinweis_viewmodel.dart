import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LieferhinweisViewModel extends BaseViewModel {
  late TextEditingController _textController;
  TextEditingController get textController => _textController;

  void setUp(String text) {
    if (text == "Hier kannst du gerne weitere Hinweise loswerden")
      _textController = TextEditingController();
    else {
      _textController = TextEditingController(text: text);
    }
  }
}
