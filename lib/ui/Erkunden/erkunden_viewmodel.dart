import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:stacked/stacked.dart';

class ErkundenViewModel extends BaseViewModel {
  bool _keineLieferung = false;

  bool get keineLieferung => _keineLieferung;
  Map<String, dynamic> get musikEmpfehlung =>
      locator<DatabaseService>().musikEmpfehlung;
  bool get musikEmpfehlungExists =>
      locator<DatabaseService>().musikEmpfehlungExists;

  Future<Map<String, dynamic>> getMusikEmpfehlung() async {
    return locator<DatabaseService>().getMusikEmpfehlung();
  }
}
