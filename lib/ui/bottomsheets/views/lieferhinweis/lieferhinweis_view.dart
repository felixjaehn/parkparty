import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'lieferhinweis_viewmodel.dart';

class LieferhinweisView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;
  final String hinweisText;
  const LieferhinweisView(
      {Key? key, this.request, this.completer, required this.hinweisText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool focus = true;
    return ViewModelBuilder<LieferhinweisViewModel>.nonReactive(
      onModelReady: (model) => model.setUp(hinweisText),
      builder: (context, model, child) {
        FocusNode _focusNode = FocusNode();
        Future.delayed(Duration.zero, () {
          if (focus) {
            FocusScope.of(context).requestFocus(_focusNode);
            focus = false;
          }
        });
        // WidgetsBinding.instance!.addPostFrameCallback((_) {
        //   FocusScope.of(context).requestFocus(_focusNode);
        // });
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.extraLightBackgroundGray,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onSubmitted: (text) => completer!(
                            SheetResponse(confirmed: true),
                          ),
                          maxLength: 120,
                          controller: model.textController,
                          focusNode: _focusNode,
                          maxLines: 6,
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
                              hintText: "Schreibe etwas..."),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ],
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
                            return completer!(
                              SheetResponse(
                                  confirmed: true,
                                  responseData: model.textController.text),
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
      viewModelBuilder: () => LieferhinweisViewModel(),
    );
  }
}
