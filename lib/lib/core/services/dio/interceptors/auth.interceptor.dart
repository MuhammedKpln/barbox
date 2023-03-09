import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class AuthInterceptor extends Interceptor {
  final AuthController authController;
  AuthInterceptor(this.authController);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final isLoggedIn = authController.isLoggedIn;

    if (isLoggedIn) {
      authController.account.observe((value) {
        if (value.newValue != null) {
          options.headers["Authorization"] = "Bearer ${value.newValue?.token}";
        }
      });

      final account = authController.account.value;
      options.headers["Authorization"] = "Bearer ${account?.token}";
    }

    return super.onRequest(options, handler);
  }
}
