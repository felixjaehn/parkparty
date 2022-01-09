import 'dart:core';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/app/app.router.dart';
import 'package:parkparty/enums/location_type.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/services/localstorage_service.dart';
import 'package:parkparty/services/location_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter/material.dart';

class WarenkorbViewModel extends ReactiveViewModel {
  final WarenkorbService _warenkorbService = locator<WarenkorbService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final LocationService _locationService = locator<LocationService>();
  final DatabaseService _databaseService = locator<DatabaseService>();
  final DialogService _dialogService = locator<DialogService>();
  final SharedPreferencesService _sharedPrefs =
      locator<SharedPreferencesService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices =>
      [_warenkorbService, _locationService];
  double get warenkorbPreis => _warenkorbService.warenkorbPreis;
  double get pfandPreis => _warenkorbService.getPfandPreis();
  bool get bestellungAktiv => _sharedPrefs.checkForBestellDocument();
  LocationStatus get locationStatus => _locationService.locationStatus;

  List<WarenkorbElement> get warenkorbListe => _warenkorbService.warenkorb;
  late GoogleMapController _mapController;
  late Bestellung aktiveBestellung;

  static final CameraPosition _kInitialCamera = CameraPosition(
    target: LatLng(52.25322332256148, 10.523260570190143),
    zoom: 16.2,
    tilt: 12,
  );

  CameraPosition get kameraPosition => initialPosition();
  List<Marker> marker = [];
  bool showLoading = true;

  void startTimer() async {
    if (bestellungAktiv) {
      aktiveBestellung = await _databaseService.getAktiveBestellung();
    }
    await Future.delayed(Duration(milliseconds: 400));
    showLoading = false;
    notifyListeners();
  }

  CameraPosition initialPosition() {
    if (_locationService.lastLocation["location"] != null) {
      return CameraPosition(
        target: _locationService.lastLocation["location"],
        zoom: 14.7,
        tilt: 12,
      );
    }
    return _kInitialCamera;
  }

  Future<Uint8List> getBytesFromAsset(String path, int height) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _addMarker() async {
    final MarkerId markerId = MarkerId("currentLocation");
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/marker_alt.png', 80);

    // creating a new MARKER
    marker.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: markerId,
        position: _locationService.lastLocation["location"],
      ),
    );
    notifyListeners();
  }

  void editLocationView() {
    _navigationService.navigateTo(Routes.retryMapsView);
  }

  void onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    _mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
    print(_locationService.locationType);
    if (_locationService.locationType == LocationType.liefergebiet ||
        _locationService.locationType == LocationType.keinLiefergebiet) {
      print("Should show Marker");
      _addMarker();
    }
  }

  void openKategorien() {
    _navigationService.navigateTo(
      Routes.kategorienView,
    );
  }

  void openCheckout() async {
    if (_warenkorbService.alterBestaetigt) {
      _navigationService.navigateTo(Routes.checkoutView);
      return;
    }
    if (!_warenkorbService.alkoholhaltig) {
      _navigationService.navigateTo(Routes.checkoutView);
    } else {
      var response = await _dialogService.showConfirmationDialog(
        title: "Jugenschutzabfrage",
        description:
            "Da dein Warenkorb alkoholhaltige Produkte beinhaltet, bitten wir dich kurz zu bestätigen, dass du über 18 Jahre alt bist.",
        cancelTitle: "Abbrechen",
        confirmationTitle: "Bestätigen",
        dialogPlatform: DialogPlatform.Cupertino,
      );
      if (response!.confirmed) {
        _warenkorbService.setAb18();
        _navigationService.navigateTo(Routes.checkoutView);
      }
    }
  }

  void openSettings() {
    //TODO: Rein temporär muss danach weg!!!!
    _sharedPrefs.deleteBestellDocument();
    notifyListeners();
    _navigationService.navigateTo(
      Routes.settingsView,
    );
  }

  void openWarenkorb() {
    _navigationService.navigateTo(
      Routes.warenkorbDialogView,
    );
  }

  Row subtitle(index) {
    return _warenkorbService.getSubtitle(index);
  }

  @override
  void dispose() {
    try {
      _mapController.dispose();
    } catch (e) {}
    super.dispose();
  }
}
