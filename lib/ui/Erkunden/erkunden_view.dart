import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/ui/dumb_widgets/lieferablauf.dart';
import 'package:parkparty/ui/dumb_widgets/musikempfehlung.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/ui/smart_widgets/erkundenPageView/pageview.dart';
import 'package:parkparty/ui/smart_widgets/erkunden_karusell/erkunden_karusell_view.dart';
import 'package:parkparty/ui/smart_widgets/spielideen/spielideen_view.dart';
import 'package:parkparty/ui/smart_widgets/weather_forecast/weather_view.dart';
import 'package:stacked/stacked.dart';

import 'erkunden_viewmodel.dart';

class ErkundenView extends StatelessWidget {
  ErkundenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ViewModelBuilder<ErkundenViewModel>.reactive(
        disposeViewModel: false,
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification? overscroll) {
              overscroll!.disallowGlow();
              return true;
            },
            child: Column(
              children: [
                //Container für Nichtlieferungswarnung
                if (model.keineLieferung)
                  Container(
                    height: screenHeightPercentage(context, percentage: 0.14),
                    color: Color(0xffFF6868),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(CupertinoIcons.clock),
                          SizedBox(width: 25),
                          Flexible(
                            child: Text(
                                "Es ist schon spät, wir müssen eine Pause machen. Bestelle doch morgen gerne wieder.",
                                style: Theme.of(context).textTheme.caption),
                          ),
                        ],
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView(
                    key: PageStorageKey('storage-key'),
                    children: [
                      ErkundenPageView(),
                      SizedBox(height: 10),
                      KarusellView(
                        key: PageStorageKey('storage-key1'),
                        kategorie: "Cocktails",
                        index: 0,
                      ),
                      WetterView(),
                      KarusellView(
                          key: PageStorageKey('storage-key2'),
                          kategorie: "Softdrinks",
                          index: 2),
                      KarusellView(
                          key: PageStorageKey('storage-key3'),
                          kategorie: "Snacks",
                          index: 5),
                      Lieferablauf(),
                      KarusellView(
                          key: PageStorageKey('storage-key4'),
                          kategorie: "Sport&Freizeit",
                          index: 6),
                      SpielideenView(),
                      model.musikEmpfehlungExists
                          ? MusikEmpfehlung(
                              title: model.musikEmpfehlung["title"],
                              interpret: model.musikEmpfehlung["interpret"],
                            )
                          : FutureBuilder<Map<String, dynamic>>(
                              future: model.getMusikEmpfehlung(),
                              builder: (context, data) {
                                if (data.connectionState !=
                                        ConnectionState.waiting &&
                                    data.hasData &&
                                    data.data!.isNotEmpty) {
                                  Map<String, dynamic> _empfehlung = data.data!;
                                  return MusikEmpfehlung(
                                    title: _empfehlung["title"],
                                    interpret: _empfehlung["interpret"],
                                  );
                                }
                                return Container();
                              }),
                      SizedBox(height: 10)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        viewModelBuilder: () => locator<ErkundenViewModel>(),
      ),
    );
  }
}
