import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SharedPreferencesService with ReactiveServiceMixin {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;
  static const String OnboardingKey = 'onboardingKey';
  static const String PfandHinweisKey = 'pfandHinweisKey';
  String? bestellDoc;

  static Future<SharedPreferencesService> getInstance() async {
    if (_instance == null) {
      // Initialise the asynchronous shared preferences
      _preferences = await SharedPreferences.getInstance();
      _instance = SharedPreferencesService();
    }

    return Future.value(_instance);
  }

  bool get isFirstOpen => _getFromDisk(OnboardingKey) ?? true;
  set isFirstOpen(bool value) => _saveToDisk(OnboardingKey, value);

  ///Gibt zurück ob der Pfandprodukttyp zum ersten Mal aufgerufen wird und der Pfanddialog entsprechend
  ///angezeigt werden soll
  bool get isFirstPfandHinweis => _getFromDisk(PfandHinweisKey) ?? true;
  set isFirstPfandHinweis(bool value) => _saveToDisk(PfandHinweisKey, value);

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk(String key, bool value) {
    print(
        '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $value');
    _preferences!.setBool(OnboardingKey, value);
  }

  void setBestellDocument(String docID) {
    _preferences!.setString("aktiveBestellung", docID);
  }

  bool checkForBestellDocument() {
    if (_preferences!.containsKey("aktiveBestellung")) {
      return _preferences!.getString("aktiveBestellung") != null;
    } else {
      return false;
    }
  }

  String getBestellDocument() {
    if (checkForBestellDocument()) {
      bestellDoc = _preferences!.getString("aktiveBestellung")!;
      print(bestellDoc);
      return bestellDoc ?? "Failed";
    } else {
      return "Failed";
    }
  }

  void deleteBestellDocument() {
    _preferences!.remove("aktiveBestellung");
  }
}
