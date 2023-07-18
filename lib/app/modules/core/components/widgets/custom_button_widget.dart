import 'package:flutter/material.dart';
import 'package:teste_ava/app/modules/core/components/theme/app_colors.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget widget;
  final bool? fullWidth;

  const CustomButtonWidget({
    Key? key,
    required this.onPressed,
    required this.widget,
    this.fullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: fullWidth! ? double.infinity : null,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors().purple,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            )),
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}
