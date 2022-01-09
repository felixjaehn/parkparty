import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:measured_size/measured_size.dart';
import 'package:badges/badges.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/ui/smart_widgets/kategorien_liste/kategorien_liste_view.dart';
import 'package:shimmer/shimmer.dart';

import 'package:stacked/stacked.dart';
import 'kategorien_viewmodel.dart';

class KategorienView extends StatelessWidget {
  final int? index;

  const KategorienView({this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int _index = index ?? 0;
    PageController _pageController = PageController(initialPage: _index);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ViewModelBuilder<KategorienViewModel>.nonReactive(
      onModelReady: (model) => model.setUp(_index),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: CupertinoColors.extraLightBackgroundGray,
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: model.close,
                          icon: Icon(CupertinoIcons.back),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                ScrollableTextList(
                  pageController: _pageController,
                  screenHeight: screenHeight,
                  initialVersatz: 50,
                  screenWidth: screenWidth,
                  index1: _index,
                  controller: model.scrollController,
                ),

                //Unten in die Column kommt ein AnimatedContainer, welcher über den Warenkorbservice reagiert
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: model.onScroll,
                    child: PageView(
                      controller: _pageController,
                      physics: BouncingScrollPhysics(),
                      children: [
                        Container(
                          color: CupertinoColors.extraLightBackgroundGray,
                          child: KategorienPage(
                            future: model.getServiceProdukte("Cocktails"),
                          ),
                        ),
                        Container(
                          color: CupertinoColors.extraLightBackgroundGray,
                          child: KategorienPage(
                            future:
                                model.getServiceProdukte("AlkFreeCocktails"),
                          ),
                        ),
                        Container(
                          color: CupertinoColors.extraLightBackgroundGray,
                          child: KategorienPage(
                            future: model.getServiceProdukte("Softdrinks"),
                          ),
                        ),
                        Container(
                          color: CupertinoColors.extraLightBackgroundGray,
                          child: KategorienPage(
                            future: model.getServiceProdukte("Picknick"),
                          ),
                        ),
                        Container(
                          color: CupertinoColors.extraLightBackgroundGray,
                          child: KategorienPage(
                            future: model.getServiceProdukte("Alkoholhaltig"),
                          ),
                        ),
                        Container(
                          color: CupertinoColors.extraLightBackgroundGray,
                          child: KategorienPage(
                            future: model.getServiceProdukte("Snacks"),
                          ),
                        ),
                        Container(
                          color: CupertinoColors.extraLightBackgroundGray,
                          child: KategorienPage(
                            future: model.getServiceProdukte("Sport&Freizeit"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Ist sichtbar sobald Elemente im Warenkorb sind
                WarenkorbBanner(),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => KategorienViewModel(),
    );
  }
}

///ScrollableTextList ist das einzige Widget, welches auf notifyListeners() reagiert, damit nicht allzu oft vom Server abgerufen wird
class ScrollableTextList extends ViewModelWidget<KategorienViewModel> {
  const ScrollableTextList({
    Key? key,
    required this.screenHeight,
    required this.initialVersatz,
    required this.index1,
    required this.screenWidth,
    required this.controller,
    required this.pageController,
  }) : super(
          key: key,
        );

  final double screenHeight;
  final double initialVersatz;
  final PageController pageController;
  final int index1;
  final double screenWidth;
  final ScrollController controller;

  @override
  Widget build(BuildContext context, KategorienViewModel model) {
    return Container(
      height: screenHeight * 0.075,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: FutureBuilder(
          future: Future.value(true),
          builder: (context, data) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                left: initialVersatz,
              ),
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: model.kategorien.length,
              itemBuilder: (context, i) {
                return MeasuredSize(
                  onChange: (Size size) {
                    model.handleSizes(size, i);
                  },
                  child: GestureDetector(
                    onTap: () {
                      pageController.animateTo(i * screenWidth,
                          duration: Duration(
                            milliseconds: 180 *
                                (min(
                                  1,
                                  (i - model.currentOffset.round()).abs(),
                                )),
                          ),
                          curve: Curves.easeIn);
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),
                      child: Container(
                        width: i == model.kategorien.length - 1
                            ? screenWidth - initialVersatz
                            : null,
                        alignment: Alignment.bottomLeft,
                        child: model.kategorien[i] != "AlkFreeCocktails"
                            ? Text(
                                model.kategorien[i],
                                style: GoogleFonts.merriweather(
                                  textStyle: TextStyle(
                                    color: Color.lerp(
                                      Colors.black,
                                      Colors.grey,
                                      min(
                                        1.0,
                                        (model.currentOffset - i).abs(),
                                      ),
                                    ),
                                    fontSize: 24,
                                    fontWeight: FontWeight.lerp(
                                      FontWeight.bold,
                                      FontWeight.w400,
                                      min(
                                        1.0,
                                        (model.currentOffset - i).abs(),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Alkoholfreie",
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        color: Color.lerp(
                                          Colors.black,
                                          Colors.grey,
                                          min(
                                            1.0,
                                            (model.currentOffset - i).abs(),
                                          ),
                                        ),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Cocktails",
                                    style: GoogleFonts.merriweather(
                                      textStyle: TextStyle(
                                        color: Color.lerp(
                                          Colors.black,
                                          Colors.grey,
                                          min(
                                            1.0,
                                            (model.currentOffset - i).abs(),
                                          ),
                                        ),
                                        fontSize: 24,
                                        fontWeight: FontWeight.lerp(
                                          FontWeight.bold,
                                          FontWeight.w400,
                                          min(
                                            1.0,
                                            (model.currentOffset - i).abs(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}

class WarenkorbBanner extends ViewModelWidget<KategorienViewModel> {
  const WarenkorbBanner({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context, KategorienViewModel model) {
    return InkWell(
      onTap: model.openWarenkorb,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 50),
        height: model.warenkorbElemente == 0 ? 0 : 60,
        color: CupertinoColors.activeBlue,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.08),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Badge(
                showBadge: model.warenkorbElemente != 0,
                position: BadgePosition.bottomStart(bottom: -7, start: 9),
                padding: EdgeInsets.symmetric(vertical: 0.9, horizontal: 5),
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(8),
                elevation: 0,
                badgeColor: CupertinoColors.activeOrange,
                badgeContent: Text(
                  model.warenkorbElemente.toString(),
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        fontSize: 13),
                  ),
                ),
                child: Icon(
                  CupertinoIcons.bag,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Text(
                "Warenkorb (${NumberFormat.currency(locale: 'eu', symbol: '€').format(model.warenkorbPreis)})",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KategorienPage extends StatelessWidget {
  const KategorienPage({
    Key? key,
    required this.future,
  }) : super(key: key);
  final Future<List<Produkt>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Produkt>>(
      future: future,
      builder: (context, data) {
        if (data.connectionState != ConnectionState.waiting && data.hasData) {
          return KategorienListeView(produkte: data.data!);
        }
        return Shimmer.fromColors(
          baseColor: Color(0xffc1c8d6),
          highlightColor: Color(0xffE5EEFF),
          period: Duration(milliseconds: 1000),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
            child: Column(
              children: [
                SizedBox(height: 8),
                LoadingContainer(),
                SizedBox(height: 8),
                LoadingContainer(),
                SizedBox(height: 8),
                LoadingContainer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
