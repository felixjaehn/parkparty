import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'lieferDetails_viewmodel.dart';

class LieferDetailsView extends StatelessWidget {
  final SheetRequest? request;
  final Function(SheetResponse)? completer;

  const LieferDetailsView({Key? key, this.request, this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LieferDetailsViewModel>.reactive(
      builder: (context, model, child) {
        return Container(
          height: screenHeight(context) * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: bottomSheetRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "Deine Bestellung",
                          style: sectionHeadline,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => LieferDetailsViewModel(),
    );
  }
}
