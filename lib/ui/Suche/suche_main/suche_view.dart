import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/models/produkte.dart';
import 'package:parkparty/ui/suche/suche_main/suche_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SucheView extends StatelessWidget {
  const SucheView({Key? key}) : super(key: key);

  Widget buildFloatingSearchBar(BuildContext context, SucheViewModel model) {
    FloatingSearchBarController _controller = FloatingSearchBarController();
    final _leading = [
      FloatingSearchBarAction.icon(
        showIfClosed: true,
        showIfOpened: false,
        icon: Icon(CupertinoIcons.search),
        onTap: _controller.open,
      ),
      FloatingSearchBarAction.icon(
        showIfClosed: false,
        showIfOpened: true,
        icon: Icon(CupertinoIcons.chevron_back),
        onTap: _controller.close,
      ),
    ];

    final _actions = [
      FloatingSearchBarAction.icon(
        showIfClosed: false,
        showIfOpened: true,
        icon: Icon(CupertinoIcons.clear, size: 20),
        onTap: () {
          _controller.clear();
        },
      ),
    ];

    return FloatingSearchBar(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      insets: EdgeInsets.symmetric(horizontal: 4),
      onQueryChanged: (query) => model.search(query),
      hint: model.getRandomHintText(),
      progress: model.isBusy,
      actions: _actions,
      leadingActions: _leading,
      backdropColor: Colors.black45,
      accentColor: CupertinoColors.activeBlue,
      width: screenWidth(context) * 0.92,
      backgroundColor: CupertinoColors.lightBackgroundGray,
      elevation: 0,
      automaticallyImplyBackButton: false,
      transitionDuration: Duration(milliseconds: 200),
      margins: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top + 35,
      ),
      builder: (context, _) {
        if (model.showErrorScreen) {
          return Container(
              height: screenHeight(context) * 0.28,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: screenHeight(context) * 0.1,
                        child: Image(
                          image: AssetImage("assets/loadingError.png"),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        "Nichts gefunden!",
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Zu deiner Suchanfrage konnten wir leider nichts finden. Probier doch gerne einen anderen Suchbegriff.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ]),
              ));
        } else {
          return _buildSuchergebnisse(context, model);
        }
      },
    );
  }

  Widget _buildSuchergebnisse(BuildContext context, SucheViewModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ImplicitlyAnimatedList<Produkt>(
        physics: BouncingScrollPhysics(),
        insertDuration: Duration(milliseconds: 250),
        removeDuration: Duration(milliseconds: 250),
        areItemsTheSame: (a, b) => a == b,
        items: model.suchErgebnisse,
        shrinkWrap: true,
        itemBuilder: (context, animation, produkt, index) {
          return SizeFadeTransition(
            animation: animation,
            child: _buildItem(context, produkt, model),
          );
        },
        updateItemBuilder: (context, animation, produkt) {
          return SizeFadeTransition(
            animation: animation,
            child: _buildItem(context, produkt, model),
          );
        },
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, Produkt produkt, SucheViewModel model) {
    final bool _isLastItem = model.suchErgebnisse.isNotEmpty
        ? produkt == model.suchErgebnisse.last
        : false;
    final bool _isFirstItem = model.suchErgebnisse.isNotEmpty
        ? produkt == model.suchErgebnisse.first
        : false;
    return Container(
      child: Column(
        children: [
          if (_isFirstItem) SizedBox(height: 4.4),
          GestureDetector(
            onTap: () => model.showDetails(produkt),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 24, 8),
              child: Container(
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color:
                                model.getColorForKategorie(produkt.kategorie),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              produkt.name,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              produkt.subtitle,
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Icon(CupertinoIcons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          if (!_isLastItem)
            Divider(color: CupertinoColors.opaqueSeparator, height: 0.4),
          if (_isLastItem) SizedBox(height: 4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SucheViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04,
                    top: 110,
                    bottom: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // FilterSortierenContainer(),
                      SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          model.onKategorienContainerTapped(3);
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.height * 0.25,
                            decoration: BoxDecoration(
                              color: Color(0xffBF8EBC),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 14,
                                  left: 15,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Picknick",
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth(context) * 0.9,
                                        child: Text(
                                          "Entdecke verschiedenste Picknick Möglichkeiten",
                                          style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 14,
                                  right: 36,
                                  height: screenHeight(context) * 0.145,
                                  child: Image(
                                    image:
                                        AssetImage('assets/illustration.png'),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 14),
                                      child: Row(
                                        children: [
                                          Icon(CupertinoIcons.flame,
                                              color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            "Beliebt",
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                model.onKategorienContainerTapped(0);
                              },
                              child: _KategorienContainer(
                                color: Color(0xff80A6F2),
                                kategorieName: "Cocktails",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                model.onKategorienContainerTapped(1);
                              },
                              child: _KategorienContainer(
                                color: Color(0xffFEAA02),
                                kategorieName: "Alkoholfreie Cocktails",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                model.onKategorienContainerTapped(2);
                              },
                              child: _KategorienContainer(
                                color: Color(0xffE39280),
                                kategorieName: "Softdrinks",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                model.onKategorienContainerTapped(5);
                              },
                              child: _KategorienContainer(
                                color: Color(0xffF26835),
                                kategorieName: "Snacks",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                model.onKategorienContainerTapped(4);
                              },
                              child: _KategorienContainer(
                                color: Color(0xffC17D40),
                                kategorieName: "Alkoholhaltige Getränke",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                model.onKategorienContainerTapped(6);
                              },
                              child: _KategorienContainer(
                                color: Color(0xff30BF62),
                                kategorieName: "Sport & Freizeit",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              buildFloatingSearchBar(context, model),
            ],
          )),
      viewModelBuilder: () => SucheViewModel(),
    );
  }
}

class _KategorienContainer extends StatelessWidget {
  final Color color;
  final String kategorieName;

  _KategorienContainer({
    this.color = Colors.white,
    this.kategorieName = "Cocktails",
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      width: screenWidth(context) * 0.45,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 14, left: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth(context) * 0.4,
              child: Text(
                kategorieName,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            // SizedBox(height: 2),
            // Text(
            //   "$elementAnzahl Elemente",
            //   style: GoogleFonts.roboto(
            //     textStyle: TextStyle(
            //         color: Colors.white,
            //         fontSize: 17,
            //         fontWeight: FontWeight.w300),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
