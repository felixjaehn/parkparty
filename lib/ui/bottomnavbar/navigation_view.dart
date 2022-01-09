import 'package:animations/animations.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:parkparty/ui/Erkunden/erkunden_view.dart';

import 'package:parkparty/ui/suche/suche_main/suche_view.dart';
import 'package:parkparty/ui/warenkorb/warenkorb_view.dart';
import 'package:stacked/stacked.dart';

import 'navigation_viewmodel.dart';

class BottomNavigationView extends StatelessWidget {
  BottomNavigationView({Key? key}) : super(key: key);

  final Map<int, Widget> _viewCache = Map<int, Widget>();
  final Color bgColor = Colors.grey[800]!;
  final Color itemColor = Color(0xffDAA24A);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BottomNavigationViewModel>.reactive(
      onModelReady: (model) {
        model.showLieferPositionAbfrage();
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: CupertinoColors.extraLightBackgroundGray,
        body: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 600),
            reverse: model.reverse,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                child: child,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
              );
            },
            child: getViewForIndex(model.currentTabIndex)),
        bottomNavigationBar: Container(
          color: bgColor,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: GNav(
              selectedIndex: model.currentTabIndex,
              backgroundColor: bgColor,
              haptic: true,
              tabBorderRadius: 8,
              gap: 12,
              activeColor: Colors.white,
              onTabChange: (index) {
                model.setTabIndex(index);
              },
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[700]!,
              color: Colors.grey[100]!,
              tabs: [
                GButton(
                  icon: CupertinoIcons.home,
                  text: 'Entdecken',
                ),
                GButton(
                  icon: CupertinoIcons.search,
                  text: 'Suchen',
                ),
                if (model.bestellungAktiv)
                  GButton(
                    gap: model.warenkorbElemente >= 10 ? 17 : 12,
                    icon: CupertinoIcons.bag,
                    text: 'Lieferung',
                    iconColor: Colors.white,
                    leading: Badge(
                        padding: EdgeInsets.all(4),
                        position: BadgePosition.topEnd(top: 1, end: -3),
                        shape: BadgeShape.circle,
                        elevation: 0,
                        badgeColor: CupertinoColors.destructiveRed,
                        badgeContent: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        ),
                        child: Icon(CupertinoIcons.bag, color: Colors.white)),
                  ),
                if (!model.bestellungAktiv)
                  GButton(
                    gap: model.warenkorbElemente >= 10 ? 17 : 12,
                    leading: model.warenkorbElemente != 0
                        ? Badge(
                            position: model.warenkorbElemente >= 10
                                ? BadgePosition.bottomStart(
                                    bottom: -2.5, start: 7)
                                : BadgePosition.bottomStart(
                                    bottom: -2.5, start: 10),
                            padding: EdgeInsets.symmetric(
                                vertical: 0.75, horizontal: 4),
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
                                    fontSize: 12),
                              ),
                            ),
                            child:
                                Icon(CupertinoIcons.bag, color: Colors.white))
                        : null,
                    icon: CupertinoIcons.bag,
                    text: 'Warenkorb',
                    iconColor: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BottomNavigationViewModel(),
    );
  }

  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = ErkundenView();
          break;
        case 1:
          _viewCache[index] = SucheView();
          break;
        case 2:
          _viewCache[index] = WarenkorbView();
          break;
      }
    }
    return _viewCache[index]!;
  }
}
