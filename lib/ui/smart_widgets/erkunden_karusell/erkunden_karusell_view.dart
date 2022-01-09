import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import 'erkunden_karusell_viewmodel.dart';

class KarusellView extends StatelessWidget {
  final int index;
  final String kategorie;
  const KarusellView({Key? key, this.kategorie = "Softdrinks", this.index = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<KarusellViewModel>.reactive(
      builder: (context, model, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            height: screenHeight(context) * 0.38,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: 15, left: screenWidth(context) * 0.05),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        kategorie,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      GestureDetector(
                        onTap: () => model.goToKategorie(index),
                        child: Text(
                          "Alle anzeigen",
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 17,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: model.databaseService
                          .getListForKategorie(kategorie)
                          .isNotEmpty
                      ? Builder(builder: (BuildContext context) {
                          List<Produkt> produkte = model.databaseService
                              .getListForKategorie(kategorie);
                          return ListView.separated(
                            cacheExtent: screenHeight(context) * 3,
                            physics: BouncingScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10);
                            },
                            itemCount: produkte.length,
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.03, right: 15),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => model.showDetails(produkte[index]),
                                child: Stack(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: produkte[index].imageLink,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: screenWidth(context) * 0.58,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      height: screenHeight(context) * 0.06,
                                      width: screenHeight(context) * 0.06,
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                          ),
                                        ),
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () =>
                                                model.showProduktBestaetigung(
                                                    produkte[index]),
                                            icon: Icon(CupertinoIcons.add,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      width: screenWidth(context) * 0.55,
                                      bottom: 15,
                                      right: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(2),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                produkte[index].subtitle,
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                              ),
                                              Text(
                                                produkte[index].name,
                                                style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        })
                      : FutureBuilder<List<Produkt>>(
                          future: model.getServiceProdukte(kategorie),
                          builder: (context, data) {
                            Widget child;
                            if (data.connectionState !=
                                    ConnectionState.waiting &&
                                data.hasData &&
                                data.data!.isNotEmpty) {
                              List<Produkt> produkte = data.data!;
                              child = ListView.separated(
                                cacheExtent: screenHeight(context) * 3,
                                physics: BouncingScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: 10);
                                },
                                itemCount: produkte.length,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(
                                    left: screenWidth(context) * 0.03,
                                    right: 15),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () =>
                                        model.showDetails(produkte[index]),
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: produkte[index].imageLink,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: screenWidth(context) * 0.58,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          height: screenHeight(context) * 0.06,
                                          width: screenHeight(context) * 0.06,
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(4),
                                              ),
                                            ),
                                            child: Center(
                                              child: IconButton(
                                                onPressed: () => model
                                                    .showProduktBestaetigung(
                                                        produkte[index]),
                                                icon: Icon(CupertinoIcons.add,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          width: screenWidth(context) * 0.55,
                                          bottom: 15,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.horizontal(
                                                left: Radius.circular(2),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 12),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    produkte[index].subtitle,
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300),
                                                    ),
                                                  ),
                                                  Text(
                                                    produkte[index].name,
                                                    style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else if (data.hasData && data.data!.isEmpty) {
                              child = Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: screenHeight(context) * 0.2,
                                      child: Image(
                                        image: AssetImage(
                                            "assets/loadingError.png"),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 6),
                                      child: Text(
                                        "Leider konnten hier keine Produkte geladen werden!",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              child = Shimmer.fromColors(
                                baseColor: Color(0xffc1c8d6),
                                highlightColor: Color(0xffE5EEFF),
                                period: Duration(milliseconds: 1000),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    SizedBox(
                                        width: screenWidth(context) * 0.03),
                                    Container(
                                      width: screenWidth(context) * 0.58,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: screenWidth(context) * 0.58,
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return AnimatedSwitcher(
                                duration: Duration(milliseconds: 600),
                                child: child);
                          }),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => KarusellViewModel(),
    );
  }
}
