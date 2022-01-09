import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'anmerkung_viewmodel.dart';

class AnmerkungView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  final int index;
  const AnmerkungView(
      {required this.index, Key? key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AnmerkungViewModel>.reactive(
      onModelReady: (model) => model.setUp(index),
      builder: (context, model, child) {
        FocusNode _focusNode = FocusNode();
        return Padding(
          padding: EdgeInsets.only(
            left: screenWidth(context) * 0.04,
            right: screenWidth(context) * 0.04,
            bottom: 20,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, bottom: 8),
                          child: Text(
                            "Deine Anmerkung",
                            style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: CupertinoColors.extraLightBackgroundGray,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                maxLength: 120,
                                controller: model.textController,
                                focusNode: _focusNode,
                                maxLines: 4,
                                onEditingComplete: () {
                                  _focusNode.unfocus();
                                },
                                cursorColor: Colors.grey,
                                cursorHeight: 18,
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),
                                ),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterStyle: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    hintStyle: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          color: Colors.grey[800],
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    hintText:
                                        "Schreibe z.B. Ich finde diese App wirklich großartig..."),
                                keyboardType: TextInputType.text,
                              ),
                            )),
                        model.warenkorbElement.anmerkung == null ||
                                model.warenkorbElement.anmerkung == ""
                            ? SizedBox(height: 18)
                            : CupertinoButton(
                                onPressed: () => model.clearInput(),
                                child: Center(
                                  child: Text(
                                    "Anmerkung löschen",
                                    style: TextStyle(
                                        color: CupertinoColors.destructiveRed,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "Abbrechen",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          onPressed: () => completer!(
                            SheetResponse(confirmed: true),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: 50,
                        child: CupertinoButton(
                          padding: EdgeInsets.zero,
                          color: CupertinoColors.activeGreen,
                          child: Center(
                            child: Text(
                              "Speichern",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          onPressed: () {
                            model.saveInput();
                            return completer!(
                              SheetResponse(confirmed: true),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AnmerkungViewModel(),
    );
  }
}
