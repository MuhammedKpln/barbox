import 'package:flutter/material.dart';

class ToastAction {
  final String label;
  final VoidCallback onPressed;

  ToastAction({required this.label, required this.onPressed});
}
