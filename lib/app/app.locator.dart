// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/checkout_service.dart';
import '../services/database_service.dart';
import '../services/error_service.dart';
import '../services/localstorage_service.dart';
import '../services/location_service.dart';
import '../services/payment_service.dart';
import '../services/warenkorb_service.dart';
import '../ui/Erkunden/erkunden_viewmodel.dart';

final locator = StackedLocator.instance;

Future setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerSingleton(ErkundenViewModel());
  locator.registerLazySingleton(() => WarenkorbService());
  locator.registerLazySingleton(() => PaymentService());
  locator.registerLazySingleton(() => ErrorService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DatabaseService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => CheckoutService());
  final sharedPreferencesService = await SharedPreferencesService.getInstance();
  locator.registerSingleton(sharedPreferencesService);
}
