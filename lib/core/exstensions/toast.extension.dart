import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spamify/core/constants/theme.dart';
import 'package:spamify/main.dart';

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
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(text),
        action: action,
        backgroundColor: toastType?.color,
      ),
    );
  }
}

/// Extending the BuildContext class with a new getter called toast.
extension ToastExtension on BuildContext {
  /// It's a getter that returns a new instance of the _Toast class.
  Toast get toast => Toast();
}
