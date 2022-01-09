import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import 'pageviewmodel.dart';

class ErkundenPageView extends StatelessWidget {
  const ErkundenPageView({Key? key}) : super(key: key);

  Widget _buildTabBarItem(ErkundenPageViewModel model, BuildContext context,
      String bildString, String kategorie,
      {int index = 0,
      String subtitle = "Zum Entdecken",
      String title = "Produkttitel",
      required VoidCallback showDetails}) {
    return Container(
        child: Stack(
      children: [
        GestureDetector(
          onTap: () {
            showDetails();
          },
          child: CachedNetworkImage(
            imageUrl: bildString,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          width: screenWidth(context),
          height: screenHeightPercentage(context, percentage: 0.09),
          child: GestureDetector(
            onTap: () {
              model.goToKategorien(index);
            },
            child: Container(
                color: Colors.black45,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    children: [
                      Text(
                        "Mehr",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        kategorie,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(CupertinoIcons.chevron_right, color: Colors.white),
                    ],
                  ),
                )),
          ),
        ),
        Positioned(
          top: 25,
          left: 15,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.black45),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: GoogleFonts.merriweather(
                      textStyle: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ErkundenPageViewModel>.nonReactive(
      builder: (context, model, child) => Container(
        height: screenHeightPercentage(context, percentage: 0.5),
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: model.onPageScroll,
              child: model.databaseService
                      .getListForKategorie("PageView")
                      .isNotEmpty
                  ? Builder(builder: (BuildContext context) {
                      List<Produkt> produkte =
                          model.databaseService.getListForKategorie("PageView");
                      return PageView(
                        allowImplicitScrolling: false,
                        key: PageStorageKey('erkunden-page-view'),
                        controller: model.pageController,
                        children: [
                          _buildTabBarItem(model, context,
                              produkte[3].imageLink, produkte[3].kategorie,
                              index: 5,
                              showDetails: () => model.showDetails(produkte[3]),
                              subtitle: "Aktuell beliebt",
                              title: produkte[3].name),
                          _buildTabBarItem(model, context,
                              produkte[0].imageLink, produkte[0].kategorie,
                              index: 0,
                              showDetails: () => model.showDetails(produkte[0]),
                              subtitle: "Ganz klassisch",
                              title: produkte[0].name),
                          _buildTabBarItem(model, context,
                              produkte[1].imageLink, produkte[1].kategorie,
                              index: 2,
                              showDetails: () => model.showDetails(produkte[1]),
                              subtitle: "Zum Abkühlen",
                              title: produkte[1].name),
                          _buildTabBarItem(model, context,
                              produkte[2].imageLink, produkte[2].kategorie,
                              index: 6,
                              showDetails: () => model.showDetails(produkte[2]),
                              subtitle: "Spiel & Spaß",
                              title: produkte[2].name),
                        ],
                      );
                    })
                  : FutureBuilder<List<Produkt>>(
                      future: model.getProdukte(),
                      builder: (context, data) {
                        Widget child;
                        if (data.connectionState != ConnectionState.waiting &&
                            data.hasData &&
                            data.data!.isNotEmpty &&
                            data.data!.length == 4) {
                          List<Produkt> produkte = data.data!;
                          child = PageView(
                            allowImplicitScrolling: false,
                            key: PageStorageKey('erkunden-page-view'),
                            controller: model.pageController,
                            children: [
                              _buildTabBarItem(model, context,
                                  produkte[3].imageLink, produkte[3].kategorie,
                                  index: 5,
                                  showDetails: () =>
                                      model.showDetails(produkte[3]),
                                  subtitle: "Aktuell beliebt",
                                  title: produkte[3].name),
                              _buildTabBarItem(model, context,
                                  produkte[0].imageLink, produkte[0].kategorie,
                                  index: 0,
                                  showDetails: () =>
                                      model.showDetails(produkte[0]),
                                  subtitle: "Ganz klassisch",
                                  title: produkte[0].name),
                              _buildTabBarItem(model, context,
                                  produkte[1].imageLink, produkte[1].kategorie,
                                  index: 2,
                                  showDetails: () =>
                                      model.showDetails(produkte[1]),
                                  subtitle: "Zum Abkühlen",
                                  title: produkte[1].name),
                              _buildTabBarItem(model, context,
                                  produkte[2].imageLink, produkte[2].kategorie,
                                  index: 6,
                                  showDetails: () =>
                                      model.showDetails(produkte[2]),
                                  subtitle: "Spiel & Spaß",
                                  title: produkte[2].name),
                            ],
                          );
                        } else if (data.hasData && data.data!.isEmpty) {
                          child = Container(
                            child: Center(
                              child: Text("Es gab Probleme beim Laden"),
                            ),
                          );
                        } else {
                          child = Shimmer.fromColors(
                              baseColor: Color(0xffc1c8d6),
                              highlightColor: Color(0xffE5EEFF),
                              period: Duration(milliseconds: 1000),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                ),
                              ));
                        }

                        return AnimatedSwitcher(
                            duration: Duration(milliseconds: 600),
                            child: child);
                      }),
            ),
            Positioned(
              bottom: 10,
              right: 15,
              child: PageIndicator(),
            )
          ],
        ),
      ),
      viewModelBuilder: () => ErkundenPageViewModel(),
    );
  }
}

class PageIndicator extends ViewModelWidget<ErkundenPageViewModel> {
  const PageIndicator({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context, ErkundenPageViewModel model) {
    return DotsIndicator(
      dotsCount: 4,
      position: model.currentPage,
      decorator: DotsDecorator(
        activeColor: CupertinoColors.activeBlue,
        color: Colors.white,
        spacing: EdgeInsets.symmetric(horizontal: 2),
        activeSize: Size(20.0, 3.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
        size: Size(15.0, 3.5),
      ),
    );
  }
}
