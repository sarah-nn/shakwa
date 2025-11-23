import 'package:zapx/zapx.dart';

validInput(String val, int min, int max, String type) {
  if (type == "email") {
    if (Zap.isValidEmail(val) == false) {
      return "البريد الإلكتروني غير صالح";
    }
  }

  if (type == "phone") {
    if (Zap.isValidPhoneNumber(val)) {
      return "رقم الهاتف غير صالح";
    }
  }

  if (val.isEmpty) {
    return "لا يمكن أن يكون الحقل فارغًا";
  }

  if (val.length < min) {
    return "لا يمكن أن يكون أقل من $min محرف";
  }

  if (val.length > max) {
    return "لا يمكن أن يكون أكثر من $max محرف";
  }
}
