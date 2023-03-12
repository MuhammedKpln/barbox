import 'package:barbox/core/shared/toast/views/controllers/toast.controller.dart';
import 'package:flutter/material.dart';

/// Extending the BuildContext class with a new getter called toast.
extension ToastExtension on BuildContext {
  /// It's a getter that returns a new instance of the _Toast class.
  Toast get toast => Toast();
}
