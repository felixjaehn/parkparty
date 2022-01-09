import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MapsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  late GoogleMapController _mapController;

  static final CameraPosition _kInitialCamera = CameraPosition(
    target: LatLng(52.264160, 10.533391),
    zoom: 12.7,
    tilt: 12,
  );
  CameraPosition get iniitalPosition => _kInitialCamera;

  void onMapCreated(
      BuildContext context, GoogleMapController controller) async {
    _mapController = controller;
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _mapController.setMapStyle(value);
  }

  void close() {
    _navigationService.back();
  }

  Set<Polygon> polygons = Set.from([
    Polygon(
      polygonId: PolygonId("Bürgerpark"),
      points: lieferGebietBuergerPark,
      fillColor: CupertinoColors.activeBlue.withOpacity(0.2),
      strokeColor: CupertinoColors.activeBlue.withOpacity(0.7),
      strokeWidth: 2,
    ),
    Polygon(
      polygonId: PolygonId("PrinzAlbrechtPark"),
      points: _lieferGebietPAPark,
      fillColor: CupertinoColors.activeBlue.withOpacity(0.2),
      strokeColor: CupertinoColors.activeBlue.withOpacity(0.7),
      strokeWidth: 2,
    ),
    Polygon(
      polygonId: PolygonId("Inselwallpark"),
      points: _lieferGebietInselwallPark,
      fillColor: CupertinoColors.activeBlue.withOpacity(0.2),
      strokeColor: CupertinoColors.activeBlue.withOpacity(0.7),
      strokeWidth: 2,
    ),
  ]);

  static const List<LatLng> lieferGebietBuergerPark = [
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

  static const List<LatLng> _lieferGebietPAPark = [
    LatLng(52.270829144961596, 10.544892726463324),
    LatLng(52.25877362549304, 10.552059588951117),
    LatLng(52.261058910358635, 10.566350398582465),
    LatLng(52.26625946451878, 10.570255694908148),
    LatLng(52.27201088221016, 10.55849689058686),
    LatLng(52.27417113800695, 10.554299354553223),
  ];

  static const List<LatLng> _lieferGebietInselwallPark = [
    LatLng(52.27277531395837, 10.513133731808235),
    LatLng(52.27383883220612, 10.516116348232796),
    LatLng(52.27353684813728, 10.522467819180061),
    LatLng(52.272473322643904, 10.524720874752571),
    LatLng(52.26976843913445, 10.52124473186927),
    LatLng(52.26952551676208, 10.515923229183723),
  ];

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }
}
