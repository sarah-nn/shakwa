import 'package:flutter/material.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/complaint_image_dialog.dart';

class ComplaintImageAttachments extends StatelessWidget {
  final List<String> imageUrls;

  const ComplaintImageAttachments({super.key, required this.imageUrls});
  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'المرفقات (الصور):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final img = imageUrls[i];

              return GestureDetector(
                onTap: () => openImageViewer(context, i, imageUrls),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    img,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, err, __) => Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade200,
                          alignment: Alignment.center,
                          child: Text(
                            img.split('/').last,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
