import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:parkparty/helper/ui_helpers.dart';
import 'package:parkparty/models/produkte.dart';

class DetailsHeader extends StatelessWidget {
  const DetailsHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.auswahlInfo,
    required this.preis,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Row? auswahlInfo;
  final double preis;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.w700),
                ),
              ),
              auswahlInfo ??
                  Text(
                    subtitle ?? "Eiskalt",
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Preis",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              ),
              Text(
                NumberFormat.currency(locale: 'eu', symbol: '€').format(preis),
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class ZutatenListe extends StatelessWidget {
  final Function() openHinweise;
  final List<Zutat> zutaten;
  const ZutatenListe({
    required this.openHinweise,
    required this.zutaten,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff80A6F2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 18, left: 20, bottom: 14, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Zutaten",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                "So bereiten wir den Cocktail zu",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: zutaten.map((Zutat zutat) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (zutat.subtitle != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              zutat.subtitle ?? "",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    height: 1.2,
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            zutat.title,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  height: zutat.subtitle != null ? 1.2 : null,
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        if (zutat != zutaten.last)
                          Divider(
                            color: Colors.white70,
                            height: 8,
                            endIndent: screenWidth(context) * 0.42,
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  openHinweise();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Allergiehinweise",
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(CupertinoIcons.arrow_right,
                        color: Colors.white, size: 22),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AllergieHinweise extends StatelessWidget {
  const AllergieHinweise({
    Key? key,
    required this.goBack,
    required this.allergene,
    required this.zusatzstoffe,
  }) : super(key: key);
  final VoidCallback goBack;
  final List<String> allergene;
  final List<String> zusatzstoffe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => goBack(),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.chevron_back, size: 22),
                SizedBox(width: 4),
                Text(
                  "Zurück zur Übersicht",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28, left: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Allergene",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16, top: 6),
                    child: allergene.isEmpty
                        ? Text("Keine Allergene enthalten",
                            style: GoogleFonts.roboto(
                                fontSize: 18, fontWeight: FontWeight.w300))
                        : Column(
                            children: allergene.map((String allergen) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 3,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      allergen,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Zusatzstoffe",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 16, top: 6),
                    child: zusatzstoffe.isEmpty
                        ? Text(
                            "Keine Zusatzstoffe",
                            style: GoogleFonts.roboto(
                                fontSize: 18, fontWeight: FontWeight.w300),
                          )
                        : Column(
                            children: zusatzstoffe.map((String zusatzstoff) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 3,
                                      width: 3,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[700],
                                          shape: BoxShape.circle),
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      zusatzstoff,
                                      style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 60),
            child: Text(
              "Auch wenn wir diese Hinweise regelmäßig überprüfen, kann es passieren, dass Informationen nicht ganz aktuell sind. Wenn du weitere Fragen zu diesen Hinweisen hast, kannst du dich gerne an uns wenden!",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AbbrechenAuswahlWidget extends StatelessWidget {
  const AbbrechenAuswahlWidget(
      {Key? key,
      required this.onTap,
      required this.addToCart,
      required this.endPreis})
      : super(key: key);
  final VoidCallback onTap;
  final VoidCallback addToCart;
  final double endPreis;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            height: 50,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
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
              onPressed: () {
                onTap();
              },
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
                  NumberFormat.currency(locale: 'eu', symbol: '€')
                      .format(endPreis),
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              onPressed: () {
                addToCart();
              },
            ),
          ),
        ],
      ),
    );
  }
}
