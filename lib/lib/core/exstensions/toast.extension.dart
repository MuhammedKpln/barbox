import 'package:barbox/main.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:barbox/core/constants/theme.dart';
import 'package:cherry_toast/cherry_toast.dart';

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
    SnackBarAction? action,
  }) {
    CherryToast toast = CherryToast.info(
      title: const Text("Barbox"),
      description: Text(text),
      displayCloseButton: false,
      animationDuration: const Duration(milliseconds: 500),
    );

    switch (toastType) {
      case ToastType.error:
        toast = CherryToast.error(
          title: const Text("Barbox"),
          description: Text(text),
          displayCloseButton: false,
          animationDuration: const Duration(milliseconds: 500),
        );
        break;
      case ToastType.success:
        toast = CherryToast.success(
          title: const Text("Barbox"),
          description: Text(text),
          displayCloseButton: false,
          animationDuration: const Duration(milliseconds: 500),
        );
        break;
      case ToastType.info:
        // TODO: Handle this case.
        break;

      default:
        break;
    }

    toast.show(scaffoldMessengerKey.currentContext!);
  }
}

/// Extending the BuildContext class with a new getter called toast.
extension ToastExtension on BuildContext {
  /// It's a getter that returns a new instance of the _Toast class.
  Toast get toast => Toast();
}
