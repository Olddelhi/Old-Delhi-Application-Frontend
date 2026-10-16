import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCardController extends GetxController{

TextEditingController holderNameTextController= TextEditingController();
TextEditingController cardNumberTextController= TextEditingController();
TextEditingController expiryDateTextController= TextEditingController();
TextEditingController cvvTextController= TextEditingController();

FocusNode holderNameFocusNode= FocusNode();
FocusNode cardNumberFocusNode= FocusNode();
FocusNode expiryDateFocusNode= FocusNode();
FocusNode cvvFocusNode= FocusNode();

}