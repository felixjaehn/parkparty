import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter/material.dart';

class CheckoutSegment extends StatelessWidget {
  ///Dieser bool Value dient dazu den Style vom SliverHeader zu entscheiden
  ///Ist true, wenn der Header geschlossen ist
  final bool headerGeschlossen;

  ///Der Titel des Segments
  final String title;

  ///Der Untertitel des Segments
  final String? subtitle;

  ///Der Pfad zum SVG Icon, welches in der Titelzeile dargestellt wird
  final String iconPath;

  ///Gibt an ob der Abschnitt einen Untertitel haben soll oder nicht
  final bool hasSubtitle;

  ///Das zentrale Form-Element in der CustomScrollView
  final Widget formView;

  final Color? subtitleTextColor;

  ///Die Funktion welche aufgerufen wird, wenn der Header angetippt wird
  final Function() onTap;

  const CheckoutSegment({
    required this.headerGeschlossen,
    required this.title,
    required this.formView,
    required this.onTap,
    required this.iconPath,
    this.subtitle,
    this.subtitleTextColor,
    this.hasSubtitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: <Widget>[
        SliverPinnedHeader(
          child: TitleHeader(
            onTap: onTap,
            headerGeschlossen: headerGeschlossen && !hasSubtitle,
            title: title,
            iconPath: iconPath,
          ),
        ),
        formView,
        if (hasSubtitle)
          SliverPinnedHeader(
            child: SubtitleHeader(
              textColor: subtitleTextColor,
              headerGeschlossen: headerGeschlossen,
              subtitle: subtitle,
            ),
          ),
      ],
    );
  }
}

class TitleHeader extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool headerGeschlossen;
  final VoidCallback onTap;

  TitleHeader(
      {required this.title,
      required this.iconPath,
      required this.onTap,
      required this.headerGeschlossen});

  Color getColor() {
    switch (iconPath) {
      case "assets/idle.svg":
        return CupertinoColors.darkBackgroundGray;
      case "assets/success.svg":
        return CupertinoColors.activeGreen;
      case "assets/failed.svg":
        return CupertinoColors.destructiveRed;
      default:
        return CupertinoColors.darkBackgroundGray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: CupertinoColors.extraLightBackgroundGray,
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(8),
                    bottom: headerGeschlossen
                        ? Radius.circular(8)
                        : Radius.circular(0)),
              ),
              height: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          height: 26,
                          width: 26,
                          child: SvgPicture.asset(
                            iconPath,
                            color: getColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubtitleHeader extends StatelessWidget {
  final String? subtitle;
  final bool headerGeschlossen;
  final Color? textColor;

  SubtitleHeader({
    this.subtitle,
    this.textColor,
    required this.headerGeschlossen,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            color: CupertinoColors.extraLightBackgroundGray,
            borderRadius: BorderRadius.vertical(
              bottom:
                  headerGeschlossen ? Radius.circular(0) : Radius.circular(8),
            )),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 14, right: 10, bottom: 8, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    subtitle ?? "",
                    textAlign:
                        headerGeschlossen ? TextAlign.left : TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: textColor ?? Colors.grey[800],
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
