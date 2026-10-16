 import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewPasswordController extends GetxController{
  TextEditingController newPasswordTextController= TextEditingController();
  TextEditingController reTypePasswordTextController= TextEditingController();
  FocusNode newPasswordFocusNode= FocusNode();
  FocusNode reTypePasswordFocusNode= FocusNode();
  RxBool show=false.obs;

  bool showIcon() {
    return show.value = !show.value;
  }
}