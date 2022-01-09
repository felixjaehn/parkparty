import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as Lottie;
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'lieferfortschritt_viewmodel.dart';

class LieferFortschrittView extends StatelessWidget {
  const LieferFortschrittView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LieferFortschrittViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: CupertinoColors.lightBackgroundGray,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 8, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: model.close,
                        icon: Icon(
                          CupertinoIcons.chevron_left,
                          color: Colors.grey[700],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        height: 40,
                        child: Text(
                          "Hilfe",
                          style: ctaText.copyWith(
                              color: CupertinoColors.activeBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Lieferung",
                      style: GoogleFonts.merriweather(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: screenWidth(context) * 0.3,
                      color: Color(0xffDAA24A),
                    ),
                  ],
                )),
              ),
              SizedBox(height: 12),
              Expanded(
                  child: MainLieferVerfolgungWidget(
                      updateStream: model.updateStream,
                      initialCam: model.initialCam,
                      model: model,
                      mapCreate: (context, controller) =>
                          model.onMapCreated(context, controller),
                      setStyle: (context) => model.setMapStyle(context))),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: () => model.showDetails(),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: largeRadius,
                    ),
                    child: Center(
                      child: Text(
                        "Details",
                        style: ctaText.copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LieferFortschrittViewModel(),
    );
  }
}

class MainLieferVerfolgungWidget extends StatelessWidget {
  const MainLieferVerfolgungWidget(
      {Key? key,
      required this.updateStream,
      required this.initialCam,
      required this.mapCreate,
      required this.setStyle,
      required this.model})
      : super(key: key);

  final LieferFortschrittViewModel model;

  final Stream<DocumentSnapshot<Map<String, dynamic>>> updateStream;
  final CameraPosition initialCam;
  final Function(BuildContext context, GoogleMapController controller)
      mapCreate;
  final Function(BuildContext context) setStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: largeRadius,
        ),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: updateStream,
            builder: (context, snapshot) {
              Widget status = LieferStatus1();
              int statusIndex = 1;
              if (!snapshot.hasData) {
                status = LieferStatus1();
              } else {
                switch (snapshot.data!["bestellFortschritt"]) {
                  case ("Vorbereitung"):
                    print("Vorbereitung");
                    status = LieferStatus1();
                    statusIndex = 1;
                    break;
                  case ("Angenommen"):
                    print("Angenommen");
                    statusIndex = 4;
                    status = LieferStatus4(
                      delete: model.delete,
                      map: MapWidget(
                        initialPosition: initialCam,
                        mapCreate: (GoogleMapController controller) {
                          return mapCreate(context, controller);
                        },
                        setMapStyle: () {
                          setStyle(context);
                        },
                      ),
                    );
                    break;
                }
              }
              return LieferVerfolgungView(
                status: status,
                stufe: statusIndex,
                aktuell: model.getStatusText(statusIndex)["aktuell"] ?? "",
                naechste: model.getStatusText(statusIndex)["naechste"] ?? "",
              );
            }),
      ),
    );
  }
}

class LieferVerfolgungView extends StatelessWidget {
  const LieferVerfolgungView({
    Key? key,
    required this.status,
    required this.aktuell,
    required this.naechste,
    required this.stufe,
  }) : super(key: key);

  final Widget status;
  final String aktuell;
  final String naechste;
  final int stufe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 25, 16, 6),
            child: Row(
              textBaseline: TextBaseline.alphabetic,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Geschätzte Ankunftszeit:",
                    style: sectionSubHeadline.copyWith(fontSize: 16)),
                Text("17:01 Uhr", style: sectionHeadline),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 11, 10),
            child: ProgressRow(
              lieferStufe: stufe,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aktuell,
                style: sectionSubHeadline.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                "Nächste: $naechste",
                style: sectionSubHeadline.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
        Expanded(
          child: status,
        ),
      ],
    );
  }
}

class LieferStatus1 extends StatelessWidget {
  const LieferStatus1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Container(
          decoration: BoxDecoration(
            color: CupertinoColors.extraLightBackgroundGray,
            borderRadius: smallRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Lottie.Lottie.asset(
                    "assets/loading.json",
                    height: 150,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Sobald der Lieferfahrer deine Bestellung aufnimmt, kannst du hier seine Fahrt verfolgen.",
                  style: bodyText,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}

class LieferStatus4 extends StatelessWidget {
  const LieferStatus4({
    Key? key,
    required this.map,
    required this.delete,
  }) : super(key: key);

  final Widget map;
  final Function() delete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.extraLightBackgroundGray,
          borderRadius: smallRadius,
        ),
        child: Stack(
          children: [
            ClipRRect(borderRadius: smallRadius, child: map),
            Container(
              decoration: BoxDecoration(
                borderRadius: smallRadius,
                color: Colors.black.withOpacity(0.69),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Wir würden uns über eine kurze Rückmeldung von dir freuen:",
                    textAlign: TextAlign.center,
                    style: sectionHeadline.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 22),
                  SizedBox(
                    width: screenWidth(context) - 50,
                    child: CupertinoButton(
                        color: CupertinoColors.activeBlue,
                        child: Text("Es hat alles geklappt", style: ctaText),
                        onPressed: delete),
                  ),
                  SizedBox(height: 6),
                  SizedBox(
                    width: screenWidth(context) - 50,
                    child: CupertinoButton(
                        color: CupertinoColors.white,
                        child: Text("Es gab Probleme",
                            style: ctaText.copyWith(color: Colors.black)),
                        onPressed: delete),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MapWidget extends StatelessWidget with WidgetsBindingObserver {
  const MapWidget({
    Key? key,
    required this.initialPosition,
    required this.mapCreate,
    required this.setMapStyle,
  }) : super(key: key);

  final CameraPosition initialPosition;
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

class ProgressRow extends StatelessWidget {
  const ProgressRow({
    Key? key,
    required this.lieferStufe,
  }) : super(key: key);

  final int lieferStufe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              height: 6,
              decoration: BoxDecoration(
                  color: CupertinoColors.activeGreen,
                  borderRadius: smallRadius),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              height: 6,
              decoration: BoxDecoration(
                  color: lieferStufe >= 2
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.inactiveGray,
                  borderRadius: smallRadius),
            ),
          ),
        ),
        Expanded(
          flex: lieferStufe == 3 ? 5 : 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: 6,
                decoration: BoxDecoration(
                    color: lieferStufe == 4
                        ? CupertinoColors.activeGreen
                        : CupertinoColors.inactiveGray,
                    borderRadius: smallRadius),
                child: lieferStufe == 3
                    ? FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        //TODO: Anhand der Positionsdaten updaten
                        widthFactor: 0.5,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          height: 6,
                          // width: 20,
                          decoration: BoxDecoration(
                              color: CupertinoColors.activeGreen,
                              borderRadius: smallRadius),
                        ),
                      )
                    : null),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              height: 6,
              decoration: BoxDecoration(
                  color: lieferStufe == 4
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.inactiveGray,
                  borderRadius: smallRadius),
            ),
          ),
        ),
      ],
    );
  }
}
