import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:measured_size/measured_size.dart';

class DatenFormularView extends StatefulWidget {
  ///Funktion zur Verarbeitung der erhaltenen Höhe
  final Function(Size size) measureHeight;
  final bool hasSubtitle;
  final GlobalKey<FormState> formKey;
  final Function beiFormAbschluss;
  final void Function(String val) saveName;
  final void Function(String val) saveMail;
  final void Function(String val) savePhone;

  DatenFormularView(
      {Key? key,
      required this.measureHeight,
      required this.hasSubtitle,
      required this.beiFormAbschluss,
      required this.saveName,
      required this.saveMail,
      required this.savePhone,
      required this.formKey})
      : super(key: key);

  final List<bool> hasErrors = [false, false, false];

  @override
  _DatenFormularViewState createState() => _DatenFormularViewState();
}

class _DatenFormularViewState extends State<DatenFormularView> {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;

  void initState() {
    focusNode1 = new FocusNode();
    focusNode2 = new FocusNode();
    focusNode3 = new FocusNode();

    focusNode1.addListener(
        () => print('focusNode1 updated: hasFocus: ${focusNode1.hasFocus}'));
    focusNode2.addListener(
        () => print('focusNode2 updated: hasFocus: ${focusNode2.hasFocus}'));
    focusNode3.addListener(
        () => print('focusNode3 updated: hasFocus: ${focusNode3.hasFocus}'));
    super.initState();
  }

  @override
  void dispose() {
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _eMailValidator = MultiValidator([
      EmailValidator(errorText: "Bitte gib eine gültige E-Mail Adresse an"),
      RequiredValidator(errorText: "Bitte gib deine E-Mail Adresse ein"),
    ]);
    PhoneInputFormatter.replacePhoneMask(
        countryCode: "DE", newMask: '+00 000 00000000');

    return MeasuredSize(
      onChange: (Size size) => widget.measureHeight(size),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              bottom:
                  widget.hasSubtitle ? Radius.circular(0) : Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: widget.formKey,
            child: Builder(builder: (BuildContext context) {
              return Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 6),
                  //   child: Text(
                  //     "So wenig wie möglich aber doch irgendwo notwendig.",
                  //     style: GoogleFonts.roboto(
                  //       textStyle: TextStyle(
                  //           color: Colors.black,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w300),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 8),
                  TextFormField(
                    onSaved: (String? value) {
                      widget.saveName(value ?? "Kein Name");
                    },
                    focusNode: focusNode1,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.name],
                    validator: (value) {
                      if (value!.length == 0) {
                        return 'Bitte gib deinen Namen an';
                      } else if (!value.contains(" ")) {
                        return 'Bitte gib deinen vollen Namen an';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: focusNode1.hasFocus
                          ? Color(0xffE5EEFF)
                          : Color(0xffEFEEF3),
                      focusColor: Colors.black,
                      errorStyle: TextStyle(
                        fontSize: 14,
                      ),
                      labelText: 'Vor- und Zuname',
                    ),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    onSaved: (String? value) {
                      widget.saveMail(value ?? "Keine Mail");
                    },
                    focusNode: focusNode2,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: _eMailValidator,
                    autofillHints: [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: focusNode2.hasFocus
                          ? Color(0xffE5EEFF)
                          : Color(0xffEFEEF3),
                      errorStyle: TextStyle(
                        fontSize: 14,
                      ),
                      labelText: 'E-Mail Adresse',
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    onSaved: (String? value) {
                      widget.savePhone(value ?? "Kein Telefonnummer");
                    },
                    focusNode: focusNode3,
                    autofillHints: [AutofillHints.telephoneNumber],
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      focusNode3.unfocus();
                      widget.beiFormAbschluss();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte gib deine Telefonnummer an';
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      PhoneInputFormatter(
                        allowEndlessPhone: false,
                      ),
                    ],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: focusNode3.hasFocus
                          ? Color(0xffE5EEFF)
                          : Color(0xffEFEEF3),
                      errorStyle: TextStyle(
                        fontSize: 14,
                      ),
                      hintStyle: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.red[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                      labelText: 'Telefonnummer',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Die Angabe der Telefonnummer dient der Abklärung bei möglichen Rückfragen. Deine persönlichen Daten nutzen wir nur zur Bestellabwicklung gemäß unserer Datenschutzbestimmungen.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 13,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
