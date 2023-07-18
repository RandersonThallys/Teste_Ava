import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppValidations {
  MaskTextInputFormatter get cepMask => MaskTextInputFormatter(
      mask: '#####-###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  MaskTextInputFormatter get none => MaskTextInputFormatter(
        mask: null,
      );

  String? validatePassword(String value) {
    if (!(value.length >= 8) && value.isNotEmpty) {
      return "A senha precisa ter pelo menos 8 caracteres";
    }
    return null;
  }
}
