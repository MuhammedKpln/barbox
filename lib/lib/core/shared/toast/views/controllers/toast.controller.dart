import 'package:barbox/core/shared/toast/constants/toastType.const.dart';
import 'package:barbox/core/shared/toast/constants/toastAction.const.dart';
import 'package:barbox/main.dart';
import 'package:injectable/injectable.dart';
import 'package:macos_ui/macos_ui.dart';
import '../toast.component.dart';

/// It's a class that shows a toast
@LazySingleton()
class Toast {
  /// It shows a snackbar with the text passed in.
  ///
  /// Args:
  ///   text (String): The text to be displayed in the toast.
  ///   toastType (ToastType): This is an enum that I created to define
  ///   the different types of toasts
  ///   that I want to show. Defaults to ToastType
  ///   action (SnackBarAction): This is the action that will be displayed
  ///   on the right side of the snackbar.
  void showToast(
    String text, {
    ToastType? toastType = ToastType.info,
    ToastAction? action,
  }) {
    showMacosAlertDialog(
        context: mainAppKey.currentContext!,
        builder: (_) {
          return ToastComponent(
            body: text,
            action: action,
            type: toastType,
          );
        });
  }
}
