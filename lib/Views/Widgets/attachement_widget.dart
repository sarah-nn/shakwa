import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

class AttachementWidget extends StatelessWidget {
  AttachementWidget({super.key, required this.onTap, required this.getFile});

  void Function()? onTap;

  final bool getFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('المرفقات (اختياري)', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.primaryColor.withOpacity(0.4),
                width: 1.5,
                style: BorderStyle.solid,
              ),
            ),
            child:
                !getFile
                    ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.attach_file_outlined, size: 28),
                            SizedBox(width: 18),
                            Icon(Icons.camera_alt_outlined, size: 28),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text('اسحب الملفات هنا أو انقر للتحميل'),
                      ],
                    )
                    : Center(child: Text(" تم اختيار ملف")),
          ),
        ),
      ],
    );
  }
}
