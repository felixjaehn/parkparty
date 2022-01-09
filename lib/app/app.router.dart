// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../models/produkte.dart';
import '../ui/Suche/kategorien/kategorien_view.dart';
import '../ui/bottomnavbar/navigation_view.dart';
import '../ui/checkout/checkout_view.dart';
import '../ui/lieferfortschritt/lieferfortschritt_view.dart';
import '../ui/mapsView/maps_view.dart';
import '../ui/mapsView/retry_maps_view.dart';
import '../ui/produktdetails/produktdetails_view.dart';
import '../ui/settings/settings_view.dart';
import '../ui/warenkorb/fullScreenDialog/warenkorb_fs_dialog_view.dart';

class Routes {
  static const String bottomNavigationView = '/';
  static const String kategorienView = '/kategorien-view';
  static const String produktDetailsView = '/produkt-details-view';
  static const String warenkorbDialogView = '/warenkorb-dialog-view';
  static const String retryMapsView = '/retry-maps-view';
  static const String settingsView = '/settings-view';
  static const String checkoutView = '/checkout-view';
  static const String lieferFortschrittView = '/liefer-fortschritt-view';
  static const String mapsView = '/maps-view';
  static const all = <String>{
    bottomNavigationView,
    kategorienView,
    produktDetailsView,
    warenkorbDialogView,
    retryMapsView,
    settingsView,
    checkoutView,
    lieferFortschrittView,
    mapsView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.bottomNavigationView, page: BottomNavigationView),
    RouteDef(Routes.kategorienView, page: KategorienView),
    RouteDef(Routes.produktDetailsView, page: ProduktDetailsView),
    RouteDef(Routes.warenkorbDialogView, page: WarenkorbDialogView),
    RouteDef(Routes.retryMapsView, page: RetryMapsView),
    RouteDef(Routes.settingsView, page: SettingsView),
    RouteDef(Routes.checkoutView, page: CheckoutView),
    RouteDef(Routes.lieferFortschrittView, page: LieferFortschrittView),
    RouteDef(Routes.mapsView, page: MapsView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    BottomNavigationView: (data) {
      var args = data.getArgs<BottomNavigationViewArguments>(
        orElse: () => BottomNavigationViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => BottomNavigationView(key: args.key),
        settings: data,
        maintainState: true,
      );
    },
    KategorienView: (data) {
      var args = data.getArgs<KategorienViewArguments>(
        orElse: () => KategorienViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => KategorienView(
          index: args.index,
          key: args.key,
        ),
        settings: data,
      );
    },
    ProduktDetailsView: (data) {
      var args = data.getArgs<ProduktDetailsViewArguments>(nullOk: false);
      return CupertinoPageRoute<dynamic>(
        builder: (context) => ProduktDetailsView(produkt: args.produkt),
        settings: data,
      );
    },
    WarenkorbDialogView: (data) {
      var args = data.getArgs<WarenkorbDialogViewArguments>(
        orElse: () => WarenkorbDialogViewArguments(),
      );
      return CupertinoPageRoute<dynamic>(
        builder: (context) => WarenkorbDialogView(
          key: args.key,
          alreadyInCheckout: args.alreadyInCheckout,
        ),
        settings: data,
        fullscreenDialog: true,
      );
    },
    RetryMapsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const RetryMapsView(),
        settings: data,
        fullscreenDialog: true,
      );
    },
    SettingsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const SettingsView(),
        settings: data,
      );
    },
    CheckoutView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const CheckoutView(),
        settings: data,
      );
    },
    LieferFortschrittView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const LieferFortschrittView(),
        settings: data,
      );
    },
    MapsView: (data) {
      return CupertinoPageRoute<dynamic>(
        builder: (context) => const MapsView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// BottomNavigationView arguments holder class
class BottomNavigationViewArguments {
  final Key? key;
  BottomNavigationViewArguments({this.key});
}

/// KategorienView arguments holder class
class KategorienViewArguments {
  final int? index;
  final Key? key;
  KategorienViewArguments({this.index, this.key});
}

/// ProduktDetailsView arguments holder class
class ProduktDetailsViewArguments {
  final Produkt produkt;
  ProduktDetailsViewArguments({required this.produkt});
}

/// WarenkorbDialogView arguments holder class
class WarenkorbDialogViewArguments {
  final Key? key;
  final bool? alreadyInCheckout;
  WarenkorbDialogViewArguments({this.key, this.alreadyInCheckout});
}
