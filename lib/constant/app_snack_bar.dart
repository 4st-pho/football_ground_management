import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:cherry_toast/cherry_toast.dart';

class AppSnackBar {
  static BuildContext? mainContext;
  static void showTopSnackBarSuccess(String message, {BuildContext? context}) {
    CherryToast.success(
      animationCurve: Curves.easeInOutCubic,
      toastDuration: const Duration(seconds: 2),
      title: Text(message),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 400),
      actionHandler: () {},
    ).show(context ?? mainContext!);
  }

  static void showTopSnackBarWarning(String message, {BuildContext? context}) {
    CherryToast.warning(
      animationCurve: Curves.easeInOutCubic,
      toastDuration: const Duration(seconds: 2),
      title: Text(message),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 400),
      actionHandler: () {},
    ).show(context ?? mainContext!);
  }

  static void showTopSnackBarInfo(String message, {BuildContext? context}) {
    CherryToast.info(
      animationCurve: Curves.easeInOutCubic,
      toastDuration: const Duration(seconds: 2),
      title: Text(message),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 400),
      actionHandler: () {},
    ).show(context ?? mainContext!);
  }

  static void showTopSnackBarError(String message, {BuildContext? context}) {
    CherryToast.error(
      animationCurve: Curves.easeInOutCubic,
      toastDuration: const Duration(seconds: 2),
      title: Text(message),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 400),
      actionHandler: () {},
    ).show(context ?? mainContext!);
  }
}
