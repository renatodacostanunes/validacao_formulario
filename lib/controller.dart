import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Controller extends GetxController {
  RxString password = "".obs;
  RxBool isObscure = true.obs;
  RxDouble strength = 0.0.obs;
  Rx<MaterialColor> color = Colors.red.obs;
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  String displayText = 'Por favor, digita uma senha';

  void checkPassword(String value) {
    password.value = value.trim();

    if (password.isEmpty) {
      strength.value = 0;
      color.value = Colors.red;
      displayText = 'Por favor, digite sua senha';
    } else if (password.value.length < 6) {
      strength.value = 1 / 4;
      color.value = Colors.red;
      displayText = 'Sua senha é muito curta';
    } else if (password.value.length < 8) {
      strength.value = 2 / 4;
      color.value = Colors.amber;
      displayText = 'Sua senha é aceitável, mas não é forte';
    } else {
      if (!letterReg.hasMatch(password.value) ||
          !numReg.hasMatch(password.value)) {
        strength.value = 3 / 4;
        color.value = Colors.blue;
        displayText = 'Sua senha é forte';
      } else {
        strength.value = 1;
        color.value = Colors.green;
        displayText = 'Sua senha é ótima';
      }
    }
  }
}
