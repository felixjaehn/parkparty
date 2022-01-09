import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'lieferPosition_viewmodel.dart';

class LieferPositionView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  const LieferPositionView({
    Key? key,
    this.request,
    this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LieferPositionViewModel>.reactive(
      onModelReady: (model) => model.setWidth(screenWidth(context)),
      builder: (context, model, child) {
        return Container(
          height: screenHeight(context) * 0.86,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: bottomSheetRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 45),
                Text("Liefergebiet", style: sectionSubHeadline),
                SizedBox(height: 4),
                Text("Erlaube uns deine Position\nzu ermitteln",
                    style: sectionHeadline),
                SizedBox(height: 16),
                Container(
                  height: screenHeight(context) * 0.34,
                  decoration: BoxDecoration(
                    borderRadius: smallRadius,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: smallRadius,
                        ),
                        child: model.showMap
                            ? ClipRRect(
                                borderRadius: smallRadius,
                                child: MapWidget(
                                  initialPosition: model.iniitalPosition,
                                  circles: model.circles,
                                  mapCreate: (GoogleMapController controller) =>
                                      model.onMapCreated(context, controller),
                                  setMapStyle: () {
                                    model.setMapStlye(context);
                                  },
                                ),
                              )
                            : null,
                      ),
                      model.getMapScreen(),
                    ],
                  ),
                ),
                SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: model.getHinweisText(),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: 38, vertical: 11),
                          color: Colors.black,
                          onPressed: () {
                            model.openLiefergebietKarte();
                          },
                          child: Icon(CupertinoIcons.info,
                              color: Colors.white, size: 26),
                        ),
                        CupertinoButton(
                          color: model.getButtonColor(),
                          child: Text("Fortfahren", style: ctaText),
                          onPressed: () {
                            model.close();
                            return completer!(
                              SheetResponse(confirmed: true),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LieferPositionViewModel(),
    );
  }
}

class MapWidget extends StatelessWidget with WidgetsBindingObserver {
  const MapWidget({
    Key? key,
    required this.initialPosition,
    required this.circles,
    required this.mapCreate,
    required this.setMapStyle,
  }) : super(key: key);

  final CameraPosition initialPosition;
  final Set<Circle> circles;
  final void Function(GoogleMapController controller) mapCreate;
  final void Function() setMapStyle;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setMapStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition: initialPosition,
        circles: circles,
        compassEnabled: false,
        zoomControlsEnabled: false,
        mapToolbarEnabled: false,
        tiltGesturesEnabled: false,
        zoomGesturesEnabled: false,
        rotateGesturesEnabled: false,
        scrollGesturesEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) =>
            mapCreate(controller));
  }
}
