import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkparty/helper/loadingwave.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'maps_viewmodel.dart';

class MapsView extends StatelessWidget {
  const MapsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MapsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Container(
                      color: Colors.white,
                      height: 60,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: model.close,
                            child: Container(
                              height: 45,
                              width: 45,
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                CupertinoIcons.back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hierhin liefern wir", style: sectionSubHeadline),
                        Text("So sieht unser aktuelles Liefergebiet aus",
                            style: headlineText),
                      ],
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: screenHeight(context) * 0.62,
                      decoration: BoxDecoration(
                        borderRadius: smallRadius,
                      ),
                      child: FutureBuilder(
                          future: Future.delayed(Duration(milliseconds: 500)),
                          builder: (context, snapshot) {
                            Widget child;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              child = Container(
                                decoration: BoxDecoration(
                                  borderRadius: smallRadius,
                                  color:
                                      CupertinoColors.extraLightBackgroundGray,
                                ),
                                child: Center(
                                  child: SpinKitWave(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            } else {
                              child = ClipRRect(
                                borderRadius: smallRadius,
                                child: GoogleMap(
                                  initialCameraPosition: model.iniitalPosition,
                                  compassEnabled: false,
                                  zoomControlsEnabled: false,
                                  mapToolbarEnabled: false,
                                  tiltGesturesEnabled: false,
                                  zoomGesturesEnabled: true,
                                  rotateGesturesEnabled: false,
                                  polygons: model.polygons,
                                  onMapCreated:
                                      (GoogleMapController controller) => model
                                          .onMapCreated(context, controller),
                                ),
                              );
                            }
                            return AnimatedSwitcher(
                                duration: Duration(milliseconds: 600),
                                child: child);
                          }),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                          borderRadius: largeRadius, color: Colors.black),
                      child: Center(
                        child: Text("Datenschutzrichtlinien", style: ctaText),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
      viewModelBuilder: () => MapsViewModel(),
    );
  }
}
