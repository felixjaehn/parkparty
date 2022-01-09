import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/enums/location_type.dart';
import 'package:stacked/stacked.dart';

class LocationService with ReactiveServiceMixin {
  ReactiveValue<LocationStatus> _locationStatus =
      ReactiveValue<LocationStatus>(LocationStatus.keinStandort);

  ReactiveValue<List<Marker>> _marker = ReactiveValue<List<Marker>>([]);

  LocationStatus get locationStatus => _locationStatus.value;
  List<Marker> get mapMarker => _marker.value;
  bool needsToUpdate = false;

  List<LatLng> _lieferGebietBuergerPark = [
    LatLng(52.245838604968256, 10.5238401846321),
    LatLng(52.2459962605669, 10.528904195252217),
    LatLng(52.24995060524832, 10.530384774628438),
    LatLng(52.25285373692792, 10.529977078858174),
    LatLng(52.25548084164954, 10.528131719055928),
    LatLng(52.25746420263126, 10.526694055023945),
    LatLng(52.25892211341407, 10.524140592041768),
    LatLng(52.2588958451753, 10.520020718994893),
    LatLng(52.256452830961074, 10.51808952850417),
    LatLng(52.251146035419836, 10.518904920044697),
    LatLng(52.24817710554139, 10.518904920044697),
    LatLng(52.24598312262176, 10.519484277191914),
  ];

  List<LatLng> _lieferGebietPAPark = [
    LatLng(52.270829144961596, 10.544892726463324),
    LatLng(52.25877362549304, 10.552059588951117),
    LatLng(52.261058910358635, 10.566350398582465),
    LatLng(52.26625946451878, 10.570255694908148),
    LatLng(52.27201088221016, 10.55849689058686),
    LatLng(52.27417113800695, 10.554299354553223),
  ];

  List<LatLng> _lieferGebietInselwallPark = [
    LatLng(52.27277531395837, 10.513133731808235),
    LatLng(52.27383883220612, 10.516116348232796),
    LatLng(52.27353684813728, 10.522467819180061),
    LatLng(52.272473322643904, 10.524720874752571),
    LatLng(52.26976843913445, 10.52124473186927),
    LatLng(52.26952551676208, 10.515923229183723),
  ];

  List<LatLng> _test = [
    LatLng(52.262129922181224, 10.508653600690465),
    LatLng(52.26100676063802, 10.50916314125061),
    LatLng(52.26138789212393, 10.50601430701981),
  ];

  bool showedLieferPostionAbfrage = false;
  Map<String, dynamic> lastLocation = {
    "location": null,
    "timestamp": null,
    "liefergebiet": false,
  };
  LocationType locationType = LocationType.waiting;

  bool checkPosition(LatLng position) {
    bool liefergebietBP =
        _checkIfLiefergebiet(position, _lieferGebietBuergerPark);
    bool liefergebietPA = _checkIfLiefergebiet(position, _lieferGebietPAPark);
    bool liefergebietIW =
        _checkIfLiefergebiet(position, _lieferGebietInselwallPark);
    bool checkTest = _checkIfLiefergebiet(position, _test);
    return liefergebietIW || liefergebietPA || liefergebietBP || checkTest;
  }

  void notify() {
    notifyListeners();
  }

  Future<void> updateMarker() async {
    final MarkerId markerId = MarkerId("currentLocation");
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/marker_alt.png', 80);

    // creating a new MARKER
    _marker.value = [];
    _marker.value.add(
      Marker(
        icon: BitmapDescriptor.fromBytes(markerIcon),
        markerId: markerId,
        position: lastLocation["location"],
      ),
    );
    needsToUpdate = true;
    notifyListeners();
  }

  void updatet() {
    needsToUpdate = false;
  }

  void updateLocationStatus() {
    DateTime dateTime = DateTime.now();
    if (lastLocation["timestamp"] == null) {
      _locationStatus.value = LocationStatus.keinStandort;
    }
    if (dateTime.difference(lastLocation["timestamp"]).inMinutes >= 10) {
      _locationStatus.value = LocationStatus.timeout;
    }
    if (!lastLocation["liefergebiet"]) {
      _locationStatus.value = LocationStatus.keinLiefergebiet;
    }
    if (lastLocation["liefergebiet"]) {
      _locationStatus.value = LocationStatus.liefergebiet;
    }

    notifyListeners();
  }

  void setLocation(LatLng location, DateTime? timestamp, bool liefergebiet) {
    DateTime _changeTime = timestamp ?? DateTime.now();
    lastLocation = {
      "location": location,
      "timestamp": _changeTime,
      "liefergebiet": liefergebiet
    };

    if (liefergebiet) {
      locationType = LocationType.liefergebiet;
      updateMarker();
    } else {
      locationType = LocationType.keinLiefergebiet;
    }
    updateLocationStatus();
  }

  void setTrue() {
    showedLieferPostionAbfrage = true;
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

  bool _checkIfLiefergebiet(LatLng position, List<LatLng> vertices) {
    int intersectCount = 0;
    for (int j = 0; j < vertices.length - 1; j++) {
      if (rayCastIntersect(position, vertices[j], vertices[j + 1])) {
        intersectCount++;
      }
    }

    return ((intersectCount % 2) == 1); // odd = inside, even = outside;
  }

  bool rayCastIntersect(LatLng position, LatLng vertA, LatLng vertB) {
    double aY = vertA.latitude;
    double bY = vertB.latitude;
    double aX = vertA.longitude;
    double bX = vertB.longitude;
    double pY = position.latitude;
    double pX = position.longitude;

    if ((aY > pY && bY > pY) || (aY < pY && bY < pY) || (aX < pX && bX < pX)) {
      return false; // a and b can't both be above or below pt.y, and a or
      // b must be east of pt.x
    }

    double m = (aY - bY) / (aX - bX); // Rise over run
    double bee = (-aX) * m + aY; // y = mx + b
    double x = (pY - bee) / m; // algebra is neat!

    return x > pX;
  }
}
