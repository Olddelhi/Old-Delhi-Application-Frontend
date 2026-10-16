
import '../utils/app_strings.dart';

class FieldValidator {
  static String? validateEmail(String value) {
    print("validateEmail : $value ");

    if (value.isEmpty) return AppStrings.enterYourEmail;

    RegExp regex=
    RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');


    if (!regex.hasMatch(value.trim())) {
      return AppStrings.enterValidEmail;
    }

    return null;
  }

  /// Password matching expression. Password must be at least 4 characters,
  /// no more than 8 characters, and must include at least one upper case letter,
  /// one lower case letter, and one numeric digit.
  static String? validatePassword(String value) {
    print("validateEmail : $value ");

    if (value.isEmpty) return AppStrings.enterYourPassword;
    if (value.length<6) return AppStrings.weakPassword;
    return null;
  }

  static String? validateConfirmPassword(String value, String password) {
    print("validateEmail : $value ");

    if (value.isEmpty) return AppStrings.enterYourConfirmPassword;
    if (value!=password) return AppStrings.confirmPasswordNotMatching;
    return null;
  }


  static String? validateMobile(String? value) {

    if(value!.length<10){
       return AppStrings.enterValidMobile;
    }
    return null;


  }
}
