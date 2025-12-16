import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Core/Constants/end_points.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/file_downloader.dart';
import 'package:shakwa/Views/Widgets/complaint%20card/complaint%20details%20section/pdf_viewer_page.dart';

class ComplaintFileAttachments extends StatelessWidget {
  final List<Attachment> files;

  const ComplaintFileAttachments({
    super.key,
    required this.files,
  });

  IconData _iconByType(String type) {
    switch (type.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text(
          'المرفقات (الملفات):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: files.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final file = files[index];
              final fileName = file.filePath.split('/').last;

              return GestureDetector(
                onTap: () async {
                  try {
                    final rawUrl =
                        "${EndPoints.baseUrl}/${file.filePath}";
                    final encodedUrl = Uri.encodeFull(rawUrl);

                    final downloadedFile =
                        await FileDownloader.downloadFile(
                      encodedUrl,
                      fileName,
                    );

                    if (!context.mounted) return;

                    if (file.fileType.toLowerCase() == 'pdf') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PdfViewerPage(file: downloadedFile!),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'هذا النوع من الملفات غير مدعوم للعرض'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('فشل تحميل الملف'),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _iconByType(file.fileType),
                        size: 36,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fileName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
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
