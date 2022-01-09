import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:measured_size/measured_size.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/ui/checkout/checkout_widgets/standort_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StandortView extends StatelessWidget {
  final Function(Size size) measureHeight;
  final void Function() editLocation;
  const StandortView({
    Key? key,
    required this.measureHeight,
    required this.editLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StandortViewModel>.reactive(
      onModelReady: (model) => model.startTimer(),
      builder: (context, model, child) {
        model.rebuild();
        return MeasuredSize(
          onChange: (Size size) => measureHeight(size),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        "Hierhin wird deine Bestellung geliefert.",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: screenHeight(context) * 0.3,
                      child: model.shouldShowMap
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: GoogleMap(
                                compassEnabled: false,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                                markers: model.marker.toSet(),
                                initialCameraPosition: model.kameraPosition,
                                onMapCreated:
                                    (GoogleMapController controller) =>
                                        model.onMapCreated(context, controller),
                              ))
                          : Container(color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            color: Colors.black,
                            onPressed: () => {editLocation()},
                            child: Text(
                              "Anpassen",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => StandortViewModel(),
    );
  }
}
