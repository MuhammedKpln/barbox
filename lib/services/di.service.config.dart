// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:spamify/features/app/controller/app.controller.dart' as _i4;
import 'package:spamify/features/home/controllers/home.controller.dart' as _i10;
import 'package:spamify/features/home/repositories/account.repository.dart'
    as _i9;
import 'package:spamify/features/mails/controller/messages.controller.dart'
    as _i11;
import 'package:spamify/features/mails/repositories/messages.repository.dart'
    as _i8;
import 'package:spamify/services/dio.service.dart' as _i6;
import 'package:spamify/services/dio/interceptors/auth.interceptor.dart' as _i5;
import 'package:spamify/storage/account.storage.dart' as _i3;
import 'package:spamify/storage/messagesStorage.dart' as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.AccountStorage>(() => _i3.AccountStorage());
  gh.lazySingleton<_i4.AppViewController>(
      () => _i4.AppViewController(gh<_i3.AccountStorage>()));
  gh.lazySingleton<_i5.AuthInterceptor>(
      () => _i5.AuthInterceptor(gh<_i3.AccountStorage>()));
  gh.lazySingleton<_i6.DioService>(
      () => _i6.DioService(gh<_i5.AuthInterceptor>()));
  gh.lazySingleton<_i7.MessageStorage>(() => _i7.MessageStorage());
  gh.lazySingleton<_i8.MessagesRepository>(
      () => _i8.MessagesRepository(gh<_i6.DioService>()));
  gh.lazySingleton<_i9.AccountRepository>(
      () => _i9.AccountRepository(gh<_i6.DioService>()));
  gh.lazySingleton<_i10.HomeViewController>(
    () => _i10.HomeViewController(
      gh<_i9.AccountRepository>(),
      gh<_i3.AccountStorage>(),
      gh<_i6.DioService>(),
    ),
    dispose: _i10.disposeHomeViewController,
  );
  gh.lazySingleton<_i11.MessagesController>(
      () => _i11.MessagesController(gh<_i8.MessagesRepository>()));
  return getIt;
}
