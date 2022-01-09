import 'package:flutter/cupertino.dart';
import 'package:parkparty/helper/ui_helpers.dart';

class ProgressRowSmall extends StatelessWidget {
  const ProgressRowSmall({
    Key? key,
    required this.lieferStufe,
  }) : super(key: key);

  final int lieferStufe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                  color: CupertinoColors.activeGreen,
                  borderRadius: smallRadius),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                  color: lieferStufe >= 2
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.lightBackgroundGray,
                  borderRadius: smallRadius),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                  color: lieferStufe == 4
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.lightBackgroundGray,
                  borderRadius: smallRadius),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                  color: lieferStufe == 4
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.lightBackgroundGray,
                  borderRadius: smallRadius),
            ),
          ),
        ),
      ],
    );
  }
}
