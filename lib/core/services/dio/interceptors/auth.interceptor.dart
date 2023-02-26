import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:barbox/core/storage/account.storage.dart';

@LazySingleton()
class AuthInterceptor extends Interceptor {
  final AccountStorage accountStorage;
  AuthInterceptor(this.accountStorage);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final isLoggedIn = await accountStorage.isLoggedIn();

    if (isLoggedIn) {
      final account = await accountStorage.getAccount();
      options.headers["Authorization"] = "Bearer ${account?.token}";
    }

    return super.onRequest(options, handler);
  }
}
