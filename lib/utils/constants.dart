import 'package:flutter/material.dart';
import 'package:ftoast/ftoast.dart';
import 'package:to_do/utils/app_str.dart';

/// lottie asset address
String lottieURL = 'assets/lottie/1.json';

/// Empty Title & Subtite TextFields Warning
dynamic emptyWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'You must fill all fields',
      corner: 20.0,
      duration: 2000,
      padding: const EdgeInsets.all(20));
}

/// Nothing Enter When user try to edit the current tesk
dynamic updateTaskWarning(BuildContext context) {
  return FToast.toast(context,
      msg: AppStr.oopsMsg,
      subMsg: 'You must edit the tasks then try to update it!',
      corner: 20.0,
      duration: 3000,
      padding: const EdgeInsets.all(20));
}
