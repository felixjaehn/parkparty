import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/helper/ui_helpers.dart';

import 'package:stacked/stacked.dart';

import 'kategorien_liste_viewmodel.dart';

class KategorienListeView extends StatelessWidget {
  final List<Produkt> produkte;
  KategorienListeView({Key? key, required this.produkte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KategorienListeViewModel>.reactive(
      builder: (context, model, child) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
          child: ProduktListe(
            onTap: (produkt) => model.showDetails(produkt),
            showBottomSheet: (index) => model.showProduktBestaetigung(
                index, produkte[index], produkte.length),
            scrollController: model.scrollController,
            produkte: produkte,
          ),
        );
      },
      viewModelBuilder: () => KategorienListeViewModel(),
    );
  }
}

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class ProduktListe extends StatelessWidget {
  const ProduktListe(
      {Key? key,
      required this.produkte,
      required this.showBottomSheet,
      required this.onTap,
      required this.scrollController})
      : super(key: key);

  final Future Function(int index) showBottomSheet;

  final ScrollController scrollController;
  final List<Produkt> produkte;
  final Function(Produkt produkt) onTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 15),
      controller: scrollController,
      physics: BouncingScrollPhysics(),
      itemCount: produkte.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            child: GestureDetector(
              onTap: () => onTap(produkte[index]),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: produkte[index].imageLink,
                    imageBuilder: (context, imageProvider) => Container(
                      height: screenHeight(context) * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: screenHeight(context) * 0.1,
                    width: screenWidth(context) * 0.85,
                    bottom: 15,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(8),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  produkte[index].subtitle,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: CupertinoColors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ),
                                Text(
                                  produkte[index].name,
                                  style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: CupertinoColors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: screenHeight(context) * 0.055,
                              width: screenHeight(context) * 0.055,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              ),
                              child: Center(
                                child: IconButton(
                                  onPressed: () => showBottomSheet(index),
                                  icon: Icon(CupertinoIcons.add,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: screenHeight(context) * 0.06,
                    top: 10,
                    left: 10,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          NumberFormat.currency(locale: 'eu', symbol: '€')
                              .format(produkte[index].price),
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
