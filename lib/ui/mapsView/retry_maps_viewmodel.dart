import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/enums/location_type.dart';
import 'package:parkparty/helper/loadingwave.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/services/location_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RetryMapsViewModel extends BaseViewModel {
  final LocationService _locationService = locator<LocationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool hasFailed = false;
  bool showMap = false;
  bool positionImLiefergebiet = false;
  Set<Circle> circles = Set.from([]);
  late StreamSubscription<Position> positionStream;
  late GoogleMapController _mapController;
  double screenWidth = 360;
  LocationType _locationType = LocationType.waiting;
  SimpleLocation simpleLocation = SimpleLocation.waiting;

  static final CameraPosition _kInitialCamera = CameraPosition(
    target: LatLng(52.25322332256148, 10.523260570190143),
    zoom: 17.6,
    tilt: 12,
  );
  CameraPosition get iniitalPosition => _kInitialCamera;

  void openSettings() async {
    Geolocator.openAppSettings();
  }

  void setWidth(double width) async {
    screenWidth = width;
    await Future.delayed(
      Duration(milliseconds: 400),
    );
    showMap = true;
    notifyListeners();
  }

  void onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    _mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _mapController.setMapStyle(value);
    _startStream();
  }

  void setMapStlye(BuildContext context) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _mapController.setMapStyle(value);
  }

  void _startStream() async {
    bool serviceEnabled;
    LocationPermission permission;
    simpleLocation = SimpleLocation.waiting;
    notifyListeners();

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      hasFailed = true;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _locationType = LocationType.keineBerechtigung;
        simpleLocation = SimpleLocation.failed;
        notifyListeners();
        hasFailed = true;
        return Future.error("Denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (_locationType == LocationType.keineBerechtigung ||
          _locationType == LocationType.erneutKeineBerechtigung) {
        _locationType = LocationType.erneutKeineBerechtigung;
      } else {
        _locationType = LocationType.keineBerechtigung;
      }
      simpleLocation = SimpleLocation.failed;
      hasFailed = true;
      notifyListeners();
      return Future.error("Denied Forever");
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (_locationType == LocationType.keineStandortdienste ||
          _locationType == LocationType.erneutKeineStandortdienste) {
        _locationType = LocationType.erneutKeineStandortdienste;
      } else {
        _locationType = LocationType.keineStandortdienste;
      }
      simpleLocation = SimpleLocation.failed;
      notifyListeners();
      return Future.error('Location services are disabled.');
    }

    positionStream = Geolocator.getPositionStream(
      intervalDuration: Duration(seconds: 2),
    ).listen(
      (event) {
        if (hasFailed) {
          circles = Set.from(
            [
              Circle(
                circleId: CircleId("large"),
                center: LatLng(event.latitude, event.longitude),
                strokeColor: CupertinoColors.activeBlue,
                strokeWidth: 1,
                fillColor: CupertinoColors.activeBlue.withOpacity(0.1),
                radius: event.accuracy,
              ),
              Circle(
                  circleId: CircleId("small"),
                  center: LatLng(event.latitude, event.longitude),
                  strokeColor: Colors.white,
                  strokeWidth: 1,
                  fillColor: CupertinoColors.activeBlue.withOpacity(0.9),
                  radius: 2.5),
            ],
          );
        }
        notifyListeners();

        ///Überprüfung des erfassten Stanorts
        LatLng _location = LatLng(event.latitude, event.longitude);
        if (event.accuracy < 39) {
          positionImLiefergebiet = _locationService.checkPosition(_location);
          if (positionImLiefergebiet) {
            _locationType = LocationType.liefergebiet;
          } else {
            _locationType = LocationType.keinLiefergebiet;
          }
          simpleLocation = SimpleLocation.done;
          notifyListeners();

          _locationService.setLocation(
              _location, event.timestamp, positionImLiefergebiet);

          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _location,
                zoom: 17.6,
                tilt: 12,
              ),
            ),
          );
        } else {
          _locationType = LocationType.waiting;
          simpleLocation = SimpleLocation.waiting;
          notifyListeners();
        }
      },
    );
  }

  @override
  void dispose() {
    try {
      positionStream.cancel();
      _mapController.dispose();
    } catch (e) {}
    super.dispose();
  }

  void close() {
    // try {
    //   positionStream.cancel();
    // } catch (e) {}
    _locationService.notify();
    _navigationService.back();
  }

  Color getButtonColor() {
    switch (simpleLocation) {
      case SimpleLocation.done:
        {
          if (_locationType == LocationType.keinLiefergebiet)
            return Color(0xfff5635b);
          else
            return CupertinoColors.activeGreen;
        }
      default:
        return CupertinoColors.inactiveGray;
    }
  }

  Widget getHinweisText() {
    String _introText = "Standort wird ermittelt...";
    String _aufrufText =
        "Um deinen Standort abzurufen, musst du uns erst die Berechtigung hierfür erteilen";
    String _failText =
        "Dein aktueller Aufenthaltsort liegt leider nicht im Liefergebiet.";
    String _einschaltText =
        "Um deinen Standort abrufen zu können musst du deine Ortungsdienste einschalten.";
    String _successText = "Dein Standort liegt im Liefergebiet.";
    switch (_locationType) {
      case LocationType.waiting:
        return Text(_introText, style: altBodyText);
      case LocationType.keineBerechtigung:
        return Text(_aufrufText, style: altBodyText);
      case LocationType.keineStandortdienste:
        return Text(_einschaltText, style: altBodyText);
      case LocationType.erneutKeineBerechtigung:
        return Text("Die Berechtigung wurde noch nicht erteilt!",
            style: altBodyText);
      case LocationType.erneutKeineStandortdienste:
        return Text(
            "So wie es scheint sind deine Standortdienste noch nicht eingeschaltet",
            style: altBodyText);
      case LocationType.keinLiefergebiet:
        return Text(_failText, style: altBodyText);
      case LocationType.liefergebiet:
        return Text(_successText, style: altBodyText);
      default:
        return Text(_introText, style: altBodyText);
    }
  }

  Widget getMapScreen() {
    String _retryText;
    if (_locationType == LocationType.keineStandortdienste ||
        _locationType == LocationType.erneutKeineStandortdienste) {
      _retryText = "Standortdienste einschalten";
    } else {
      _retryText = "Berechtigung erteilen";
    }
    switch (simpleLocation) {
      case SimpleLocation.failed:
        return Container(
          decoration: BoxDecoration(
            borderRadius: smallRadius,
            color: Colors.black54,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  borderRadius: smallRadius,
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: smallRadius,
                    splashColor: Colors.white70,
                    onTap: () {
                      if (_locationType == LocationType.keineStandortdienste ||
                          _locationType ==
                              LocationType.erneutKeineStandortdienste) {
                        Geolocator.openLocationSettings();
                      } else {
                        hasFailed = true;
                        Geolocator.openAppSettings();
                      }
                    },
                    child: Container(
                      width: screenWidth - 36,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: smallRadius,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(CupertinoIcons.compass,
                                color: Colors.white, size: 36),
                            SizedBox(height: 12),
                            Text(_retryText,
                                textAlign: TextAlign.center, style: ctaText),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Material(
                  borderRadius: smallRadius,
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: smallRadius,
                    splashColor: Colors.white70,
                    onTap: () => _startStream(),
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: smallRadius,
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: Center(
                        child: Text("Erneut versuchen", style: ctaText),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      case SimpleLocation.waiting:
        return Container(
          decoration: BoxDecoration(
            borderRadius: smallRadius,
            color: Colors.black54,
          ),
          child: Center(
            child: SpinKitWave(
              size: 40,
              color: Colors.white,
              type: SpinKitWaveType.start,
            ),
          ),
        );
      case SimpleLocation.done:
        return Container(
          decoration: BoxDecoration(borderRadius: smallRadius),
        );
    }
  }
}
