import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/bottomsheet_type.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/services/localstorage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LieferFortschrittViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final SharedPreferencesService _sharedPrefs =
      locator<SharedPreferencesService>();

  late GoogleMapController _mapController;
  Set<Marker> markers = Set.from([]);

  Stream<DocumentSnapshot<Map<String, dynamic>>> get updateStream =>
      _databaseService.updateStream(
        _sharedPrefs.getBestellDocument(),
      );

  static final CameraPosition _kInitialCamera = CameraPosition(
    target: LatLng(52.25322332256148, 10.523260570190143),
    zoom: 16.2,
    tilt: 12,
  );

  CameraPosition get initialCam => _kInitialCamera;

  void showDetails() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.lieferDetails,
      //isScrollControlled: true,
    );
  }

  void delete() {
    _sharedPrefs.deleteBestellDocument();
  }

  void onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    print("Aufgerufen");
    //Connect the MapController to the GoogleMap as soon as the Map gets created
    _mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _mapController.setMapStyle(value);
  }

  void setMapStyle(BuildContext context) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _mapController.setMapStyle(value);
  }

  void close() {
    _navigationService.clearTillFirstAndShow(Routes.bottomNavigationView);
  }

  Map<String, String> getStatusText(int i) {
    switch (i) {
      case 1:
        return {
          "aktuell": "Deine Bestellung wird vom Restaurant verarbeitet.",
          "naechste": "Vorbereitung der Bestellung"
        };
      case 2:
        return {
          "aktuell": "Deine Bestellung wird vorbereitet.",
          "naechste": "Abholung durch Lieferfahrer"
        };
      case 3:
        return {
          "aktuell": "Der Lieferfahrer ist auf dem Weg zu dir",
          "naechste": "Zustellung der Lieferung"
        };
      case 4:
        return {
          "aktuell":
              "Deine Bestellung wurde vom Lieferfahrer an dich übergeben.",
          "naechste": "Du genießt den Tag im Park"
        };
      default:
        return {
          "aktuell": "Deine Bestellung wird vom Restaurant verarbeitet.",
          "naechste": "Vorbereitung der Bestellung"
        };
    }
  }
}
