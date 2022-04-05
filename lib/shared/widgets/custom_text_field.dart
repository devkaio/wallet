import 'package:flutter/material.dart';
import 'package:wallet/shared/constants/app_colors.dart';
import 'package:wallet/shared/constants/app_text_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool obscureText;
  const CustomTextField({
    Key? key,
    required this.controller,
    this.labelText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isVisible = true;
  bool _obscureText = false;

  @override
  void initState() {
    if (widget.obscureText) {
      _obscureText = !_obscureText;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText ?? 'label',
          style: AppTextStyle.inputLabel,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.secondary),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.inputBorder),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColors.inputBorder),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            suffixIcon: widget.obscureText
                ? IconButton(
                    splashRadius: 1,
                    onPressed: () {
                      setState(() {
                        _isVisible = !_isVisible;
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: _isVisible
                        ? const Icon(
                            Icons.visibility,
                            color: AppColors.grey,
                          )
                        : const Icon(Icons.visibility_off,
                            color: AppColors.grey),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
