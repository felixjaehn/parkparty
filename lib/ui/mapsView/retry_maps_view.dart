import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/ui/mapsView/retry_maps_viewmodel.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class RetryMapsView extends StatelessWidget {
  const RetryMapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RetryMapsViewModel>.reactive(
      onModelReady: (model) => model.setWidth(
        screenWidth(context),
      ),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: model.close,
                        icon: Icon(
                          CupertinoIcons.xmark,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: screenHeight(context) * 0.1,
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Lieferstandort",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 28),
                            ),
                          ),
                          Text("Hierhin wird deine Bestellung geliefert",
                              style: sectionSubHeadline),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Container(
                      height: screenHeight(context) * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: smallRadius,
                      ),
                      child: Builder(builder: (context) {
                        child = model.showMap
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: smallRadius,
                                    child: LargeMapWidget(
                                      initialPosition: model.iniitalPosition,
                                      circles: model.circles,
                                      mapCreate:
                                          (GoogleMapController controller) =>
                                              model.onMapCreated(
                                                  context, controller),
                                      setMapStyle: () {
                                        model.setMapStlye(context);
                                      },
                                    ),
                                  ),
                                  model.getMapScreen(),
                                ],
                              )
                            : Shimmer.fromColors(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xffc1c8d6),
                                      borderRadius: largeRadius),
                                ),
                                baseColor: Color(0xffc1c8d6),
                                highlightColor: Color(0xffE5EEFF),
                                period: Duration(milliseconds: 1000),
                              );
                        return AnimatedSwitcher(
                            duration: Duration(milliseconds: 600),
                            child: child);
                      }),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(right: 8, left: 6),
                      child: model.getHinweisText(),
                    ),
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Container(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    color: model.getButtonColor(),
                    child: Text("Bestätigen", style: ctaText),
                    onPressed: () {
                      model.close();
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => RetryMapsViewModel(),
    );
  }
}

class LargeMapWidget extends StatelessWidget with WidgetsBindingObserver {
  const LargeMapWidget({
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
