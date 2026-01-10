import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class CustomTextField extends StatefulWidget {
  final String? hint;
  final IconData? icon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? baseText;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    this.hint,
    this.icon,
    this.baseText,
    this.validator,
    this.isPassword = false,
    required this.keyboardType,
    required this.controller,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.baseText != null) ...[
          Text(
            widget.baseText!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
             //  color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
        ],

        TextFormField(
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? !_passVisible : false,
          validator: widget.validator,
          controller: widget.controller,

          decoration: InputDecoration(
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: AppColor.primaryColor, width: 0.77),
            //   borderRadius: BorderRadius.circular(7.69),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: AppColor.primaryColor, width: 0.77),

            //   borderRadius: BorderRadius.circular(7.69),
            // ),

            hintText: widget.hint,
            // hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),

            // filled: true,
            // fillColor: AppColor.fillTextField,

            prefixIcon:
                widget.icon != null
                    ? Icon(widget.icon, color: AppColor.primaryColor)
                    : null,

            suffixIcon:
                widget.isPassword
                    ? InkWell(
                      onTap: () {
                        setState(() {
                          _passVisible = !_passVisible;
                        });
                      },
                      child: Icon(
                        _passVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColor.primaryColor,
                      ),
                    )
                    : null,

            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(7.69),
            // ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 15,
            ),
          ),
        ),

        const SizedBox(height: 31),
      ],
    );
  }
}
