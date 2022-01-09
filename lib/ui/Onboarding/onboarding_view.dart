import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkparty/app/app.locator.dart';
import 'package:parkparty/ui/bottomnavbar/navigation_view.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingView extends StatefulWidget {
  OnboardingView({Key? key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  PageController _pageController = PageController(initialPage: 0);
  final navigationService = locator<NavigationService>();
  // ignore: unused_field
  bool _isScrolling = false;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    int initialPage = 0;
    _currentPage = initialPage.toDouble();
    _pageController = PageController(initialPage: initialPage);
  }

  void next() => animateScroll(_currentPage.round() + 1);

  Future<void> animateScroll(int page) async {
    setState(() => _isScrolling = true);
    await _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );
    if (mounted) {
      setState(() => _isScrolling = false);
    }
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;
    if (metrics is PageMetrics && metrics.page != null) {
      if (mounted) {
        setState(() => _currentPage = metrics.page!);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.extraLightBackgroundGray,
      body: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      navigationService.navigateToView(BottomNavigationView());
                    },
                    child: Text("Überspringen",
                        style: Theme.of(context).textTheme.bodyText2),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: NotificationListener<ScrollNotification>(
              onNotification: _onScroll,
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                children: [
                  OnboardingScreen1(),
                  OnboardingScreen2(),
                  OnboardingScreen3(),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print(_pageController.page);
            },
            child: FutureBuilder(
                future: Future.value(true),
                builder: (BuildContext context, AsyncSnapshot<void> snap) {
                  if (!snap.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                    );
                  }
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DotsIndicator(
                            dotsCount: 3,
                            position: _currentPage,
                            decorator: DotsDecorator(
                              activeColor: Colors.black,
                              color: CupertinoColors.inactiveGray,
                              spacing: EdgeInsets.symmetric(horizontal: 2),
                              activeSize: Size(40.0, 3.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0)),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0)),
                              size: Size(10.0, 3.5),
                            ),
                          ),
                          CupertinoButton(
                              color: Color(0xffDAA24A),
                              child: Text(
                                _pageController.page! >= 1.5
                                    ? "Starten"
                                    : "Weiter",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                              onPressed: () {
                                if (_pageController.page! >= 1.5) {
                                  navigationService
                                      .navigateToView(BottomNavigationView());
                                  // navigationService.navigateTo(
                                  //   Routes.bottomNavigationView,
                                  //predicate: (Route<dynamic> route) => false,
                                  //);
                                } else {
                                  next();
                                }
                              })
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _imageHeight = MediaQuery.of(context).size.height * 0.45;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: _imageHeight,
            child: Stack(
              children: [
                Positioned(
                  height: _imageHeight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: _imageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            "https://images.pexels.com/photos/3171736/pexels-photo-3171736.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(56),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: _imageHeight,
                  right: -MediaQuery.of(context).size.width * 0.7,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: _imageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            "https://images.pexels.com/photos/4393667/pexels-photo-4393667.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        bottomLeft: Radius.circular(18),
                        topRight: Radius.circular(81),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: 25,
                top: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Große Auswahl",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Entdecke deine Lieblingsprodukte in der App und füge sie direkt deiner Bestellung hinzu.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _imageHeight = MediaQuery.of(context).size.height * 0.45;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: _imageHeight,
            child: Stack(
              children: [
                Positioned(
                  height: _imageHeight,
                  left: -MediaQuery.of(context).size.width * 0.1,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: _imageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            "https://images.pexels.com/photos/4393667/pexels-photo-4393667.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(48),
                        bottomRight: Radius.circular(18),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  height: _imageHeight,
                  right: -MediaQuery.of(context).size.width * 0.88,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: _imageHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                            "https://images.pexels.com/photos/325521/pexels-photo-325521.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(48),
                        bottomLeft: Radius.circular(18),
                        topRight: Radius.circular(81),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: 25,
                top: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Einfache Bestellung",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Sobald du die Bestellung aufgibst machen sich unsere Lieferfahrer schnellstmöglich auf den Weg\nzu dir.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _imageHeight = MediaQuery.of(context).size.height * 0.45;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: _imageHeight,
              child: Stack(
                children: [
                  Positioned(
                    height: _imageHeight,
                    left: -MediaQuery.of(context).size.width * 0.12,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: _imageHeight,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: NetworkImage(
                              "https://images.pexels.com/photos/325521/pexels-photo-325521.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(48),
                          bottomLeft: Radius.circular(18),
                          topRight: Radius.circular(61),
                          bottomRight: Radius.circular(32),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: 25,
                top: 15),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ganz entspannt",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "Wir nutzen deinen GPS Standort um exakt zu dir zu liefern. Wir sind der festen Überzeugung, dass wir dir so das Bestmögliche Bestellerlebnis bieten können.",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
