import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Container(
                  height: screenHeight(context) * 0.12,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Einstellungen",
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
                      IconButton(
                        icon: Icon(CupertinoIcons.xmark),
                        onPressed: () {
                          model.goBack();
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Bestellungen", style: settingsHeader),
                    SizedBox(height: 3),
                    Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: smallRadius,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Bestellverlauf", style: settingsText),
                              Icon(CupertinoIcons.chevron_right, size: 18),
                            ],
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Datenschutz", style: settingsHeader),
                    SizedBox(height: 3),
                    Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: smallRadius,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Datenschutzhinweise", style: settingsText),
                              Icon(CupertinoIcons.chevron_right, size: 18),
                            ],
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Informationen", style: settingsHeader),
                    SizedBox(height: 3),
                    Container(
                      height: 148,
                      decoration: BoxDecoration(
                        borderRadius: smallRadius,
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Einstellung(title: "FAQ"),
                          Divider(
                              height: 2,
                              color: CupertinoColors.opaqueSeparator),
                          Einstellung(title: "Pfandbecher"),
                          Divider(
                              height: 2,
                              color: CupertinoColors.opaqueSeparator),
                          Einstellung(title: "Jugendschutz"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rechtliches", style: settingsHeader),
                    SizedBox(height: 3),
                    Container(
                      height: 148,
                      decoration: BoxDecoration(
                        borderRadius: smallRadius,
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Einstellung(title: "AGB"),
                          Divider(
                              height: 2,
                              color: CupertinoColors.opaqueSeparator),
                          Einstellung(title: "Lizenzen"),
                          Divider(
                              height: 2,
                              color: CupertinoColors.opaqueSeparator),
                          Einstellung(title: "Copyright"),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    "2021 \u00a9 Parkparty",
                    style: TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SettingsViewModel(),
    );
  }
}

class Einstellung extends StatelessWidget {
  const Einstellung({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: settingsText),
            Icon(CupertinoIcons.chevron_right, size: 18),
          ],
        ),
      ),
    );
  }
}
