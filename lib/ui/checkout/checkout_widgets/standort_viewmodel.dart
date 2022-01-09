import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/enums/location_type.dart';
import 'package:parkparty/services/location_service.dart';
import 'package:stacked/stacked.dart';

class StandortViewModel extends ReactiveViewModel {
  final LocationService _locationService = locator<LocationService>();

  List<Marker> get marker => _locationService.mapMarker;
  bool shouldShowMap = false;
  bool get locationKnown {
    return _locationService.locationType == LocationType.liefergebiet ||
        _locationService.locationType == LocationType.keinLiefergebiet;
  }

  GoogleMapController? _mapController;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_locationService];

  CameraPosition get kameraPosition => initialPosition();
  CameraPosition initialPosition() {
    return CameraPosition(
      target: locationKnown
          ? _locationService.lastLocation["location"]
          : LatLng(52.25322332256148, 10.523260570190143),
      zoom: 14.7,
      tilt: 12,
    );
  }

  void updateMarkers() async {
    print("Updated Markers");
    if (locationKnown && _mapController != null) {
      await _locationService.updateMarker();
      _mapController!.moveCamera(
          CameraUpdate.newLatLng(_locationService.lastLocation["location"]));
    }
    if (!disposed) {
      super.notifyListeners();
    }
  }

  void rebuild() {
    if (_locationService.needsToUpdate) {
      return;
    }
    _locationService.updatet();
    updateMarkers();
  }

  void startTimer() async {
    await Future.delayed(
      Duration(milliseconds: 400),
    );
    shouldShowMap = true;
    notifyListeners();
  }

  void onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
    _mapController = controller;
    if (locationKnown) {
      print("Should show Marker [onMapCreated]");
      _locationService.updateMarker();
    }
  }

  @override
  void dispose() {
    if (_mapController != null) {
      _mapController = null;
      _mapController!.dispose();
    }
    super.dispose();
  }
}
