import 'package:flutter/material.dart';
import 'package:parkparty/services/checkout_service.dart';
import 'package:parkparty/services/database_service.dart';
import 'package:parkparty/services/error_service.dart';
import 'package:parkparty/services/localstorage_service.dart';
import 'package:parkparty/services/location_service.dart';
import 'package:parkparty/services/payment_service.dart';
import 'package:parkparty/services/warenkorb_service.dart';
import 'package:parkparty/ui/Erkunden/erkunden_viewmodel.dart';
import 'package:parkparty/ui/bottomnavbar/navigation_view.dart';
import 'package:parkparty/ui/Suche/kategorien/kategorien_view.dart';
import 'package:parkparty/ui/checkout/checkout_view.dart';
import 'package:parkparty/ui/lieferfortschritt/lieferfortschritt_view.dart';
import 'package:parkparty/ui/mapsView/maps_view.dart';
import 'package:parkparty/ui/mapsView/retry_maps_view.dart';
import 'package:parkparty/ui/produktdetails/produktdetails_view.dart';
import 'package:parkparty/ui/settings/settings_view.dart';
import 'package:parkparty/ui/warenkorb/fullScreenDialog/warenkorb_fs_dialog_view.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CustomRoute(
      page: BottomNavigationView,
      initial: true,
      maintainState: true,
    ),
    // MaterialRoute(
    //     page: BottomNavigationView, initial: true, maintainState: true),
    CupertinoRoute(page: KategorienView),
    CupertinoRoute(page: ProduktDetailsView),
    CupertinoRoute(page: WarenkorbDialogView, fullscreenDialog: true),
    CupertinoRoute(page: RetryMapsView, fullscreenDialog: true),
    CupertinoRoute(page: SettingsView),
    CupertinoRoute(page: CheckoutView),
    CupertinoRoute(page: LieferFortschrittView),
    CupertinoRoute(page: MapsView),
  ],
  dependencies: [
    Singleton(classType: ErkundenViewModel),
    LazySingleton(classType: WarenkorbService),
    LazySingleton(classType: PaymentService),
    LazySingleton(classType: ErrorService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: LocationService),
    LazySingleton(classType: CheckoutService),
    Presolve(
      classType: SharedPreferencesService,
      presolveUsing: SharedPreferencesService.getInstance,
    ),
  ],
  logger: StackedLogger(),
)
class AppSetup {}

Widget buildTransitions(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child) {
  return child;
  //return new FadeTransition(opacity: animation, child: child);
}
