import 'package:flutter/material.dart';

class Titelzeile extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final double? hoehe;
  final String? titel;

  ///Diese Icons werden als Action Icons angezeigt. Funktionalitäten sind mit anzugeben
  final List<Widget>? aktionsicons;

  Titelzeile({
    Key? key,
    this.titel,
    this.hoehe,
    this.aktionsicons,
  })  : preferredSize = Size.fromHeight(hoehe!),
        super(key: key);

  Widget build(BuildContext context) {
    return AppBar(
      actions: aktionsicons,
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: MediaQuery.of(context).size.height * 0.08,
      title: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Text(
          titel ?? "Titel",
          style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 24),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(4),
        ),
      ),
    );
  }
}
