import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';

void openImageViewer(
  BuildContext context,
  int startIndex,
  List<String> images,
) {
  final controller = PageController(initialPage: startIndex);
  int current = startIndex;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 24,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        CloseButton(),
                        Text(
                          "المرفقات",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 40),
                      ],
                    ),
                  ),

                  // Photos
                  Expanded(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: images.length,
                      onPageChanged: (i) => setState(() => current = i),
                      itemBuilder: (context, index) {
                        return InteractiveViewer(
                          child: Image.network(
                            images[index],
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      images.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: current == i ? 12 : 8,
                        height: current == i ? 12 : 8,
                        decoration: BoxDecoration(
                          color:
                              current == i
                                  ? AppColor.primaryColor
                                  : Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
