import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class BuildDropDwonButton extends StatelessWidget {
  const BuildDropDwonButton({
    super.key,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.value,
  });

  final String? value;
  final String hint;
  final List<String> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.7)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          hint: Text(hint, textAlign: TextAlign.right),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
          onChanged: onChanged,
          items:
              items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, textAlign: TextAlign.right),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
