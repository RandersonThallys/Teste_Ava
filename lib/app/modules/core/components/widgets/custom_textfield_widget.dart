import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_colors.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_typography.dart';
import 'package:teste_ava/app/modules/core/components/utils/app_validations.dart';

enum MaskTypes { cep, none }

class CustomTextfieldWidget extends StatefulWidget {
  final bool? fullWidth;
  final String labelText;
  final TextEditingController? controller;
  final bool isPassword;
  final Function(String? text)? onChanged;
  final Function(String? text)? validator;

  final MaskTypes maskTypes;

  const CustomTextfieldWidget({
    Key? key,
    this.labelText = '',
    this.fullWidth = false,
    this.isPassword = false,
    this.onChanged,
    this.validator,
    this.maskTypes = MaskTypes.none,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomTextfieldWidget> createState() => _CustomTextfieldWidgetState();
}

bool _passwordVisible = true;

@override
void initState() {
  _passwordVisible = true;
}

class _CustomTextfieldWidgetState extends State<CustomTextfieldWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return SizedBox(
      width: widget.fullWidth! ? double.infinity : null,
      child: TextFormField(
        controller: widget.controller,
        style: AppTypography().input,
        onChanged: (value) {
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
        validator: (value) {
          if (widget.validator != null) {
            return widget.validator!(value);
          }
          return null;
        },
        keyboardType:
            widget.maskTypes == MaskTypes.cep ? TextInputType.number : null,
        inputFormatters: [
          selectMaskType(widget.maskTypes),
        ],
        maxLines: 1,
        obscureText: widget.isPassword ? _passwordVisible : !_passwordVisible,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              borderSide: BorderSide(
                color: AppColors().purple,
                width: 2.0,
              )),
          suffixIcon: widget.isPassword ? returnButtonSeePassword() : null,
          errorText: widget.isPassword
              ? AppValidations().validatePassword(textEditingController.text)
              : null,
          errorStyle: AppTypography().forgotPassword,
          label: Text(
            widget.labelText,
            style: AppTypography().label,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }

  MaskTextInputFormatter selectMaskType(MaskTypes type) {
    switch (type) {
      case MaskTypes.cep:
        return AppValidations().cepMask;
      default:
        return AppValidations().none;
    }
  }

  IconButton? returnButtonSeePassword() {
    return IconButton(
      icon: _passwordVisible
          ? Icon(
              Icons.visibility_off,
              color: AppColors().purple,
            )
          : Icon(
              Icons.visibility,
              color: AppColors().purple,
            ),
      onPressed: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
    );
  }
}
