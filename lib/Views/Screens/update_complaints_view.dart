import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/update_complaint/update_complaints_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Data/Models/complaint_details_model.dart';
import 'package:shakwa/Views/Widgets/language_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateComplaintsView extends StatefulWidget {
  final ComplaintDetailsModel complaint;

  const UpdateComplaintsView({super.key, required this.complaint});

  @override
  State<UpdateComplaintsView> createState() => _UpdateComplaintsViewState();
}

class _UpdateComplaintsViewState extends State<UpdateComplaintsView> {
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  late List<Attachment> localAttachments;

  List<int> oldImageIds = [];
  List<File> newImages = [];

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController(text: widget.complaint.location);
    descriptionController = TextEditingController(
      text: widget.complaint.description,
    );

    localAttachments = List.from(widget.complaint.attachments);
    // localAttachments = [
    //   Attachment(
    //     id: 991,
    //     filePath: "https://picsum.photos/200",
    //     fileType: "image",
    //     createdAt: "",
    //   ),
    //   Attachment(
    //     id: 991,
    //     filePath: "https://picsum.photos/200",
    //     fileType: "image",
    //     createdAt: "",
    //   ),
    //   Attachment(
    //     id: 992,
    //     filePath: "https://www.africau.edu/images/default/sample.pdf",
    //     fileType: "pdf",
    //     createdAt: "",
    //   ),
    // ];
    oldImageIds = widget.complaint.attachments.map((e) => e.id).toList();
  }

  /// اختيار صورة جديدة باستخدام file_picker
  Future<void> pickNewImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'webp', 'pdf'],
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        newImages.add(File(result.files.single.path!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.complaintEdit, style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===================== العنوان =====================
            SizedBox(height: 20),
            TextField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: t.complaintTitleEdit,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            // ===================== الوصف =====================
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: t.complaintDetails,
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // ===================== الصور القديمة =====================
            localAttachments.isEmpty
                ? SizedBox()
                : Text(
                  t.beforeImg,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
            SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  localAttachments.map((att) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey.shade200, // لون خلفية احتياطي
                            // --- التحقق من نوع الملف هنا ---
                            child:
                                att.fileType == 'image'
                                    ? Image.network(
                                      att.filePath,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(
                                                Icons.broken_image,
                                                size: 40,
                                              ),
                                    )
                                    : Column(
                                      // شكل افتراضي لملف PDF
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.picture_as_pdf,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                        const Text(
                                          "PDF",
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                          ),
                        ),
                        // زر الحذف (Close)
                        Positioned(
                          top: -5,
                          right: -5,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                oldImageIds.remove(att.id);
                                localAttachments.removeWhere(
                                  (e) => e.id == att.id,
                                );
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),

            // Wrap(
            //   spacing: 10,
            //   runSpacing: 10,
            //   children:
            //       localAttachments.map((att) {
            //         return Stack(
            //           children: [
            //             ClipRRect(
            //               borderRadius: BorderRadius.circular(12),
            //               child: Image.network(
            //                 att.filePath,
            //                 width: 90,
            //                 height: 90,
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //             Positioned(
            //               top: -5,
            //               right: -5,
            //               child: IconButton(
            //                 icon: Icon(Icons.close, color: Colors.red),
            //                 onPressed: () {
            //                   setState(() {
            //                     oldImageIds.remove(att.id);
            //                     localAttachments.removeWhere(
            //                       (e) => e.id == att.id,
            //                     );
            //                   });
            //                 },
            //               ),
            //             ),
            //           ],
            //         );
            //       }).toList(),
            // ),
            SizedBox(height: 20),

            // ===================== الصور الجديدة =====================
            Text(
              t.afterImg,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // ===================== الصور والملفات الجديدة =====================
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                // زر إضافة جديد
                InkWell(
                  onTap: pickNewImage,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ),

                // عرض القائمة المختارة
                ...newImages.map((file) {
                  // التحقق هل الملف هو PDF بناءً على الامتداد
                  final isPdf = file.path.toLowerCase().endsWith('.pdf');

                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: 90,
                          height: 90,
                          color: Colors.grey.shade200,
                          child:
                              isPdf
                                  ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                      Text(
                                        "PDF",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                  : Image.file(
                                    file,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                      Positioned(
                        top: -5,
                        right: -5,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              newImages.remove(file);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),

            // Wrap(
            //   spacing: 10,
            //   runSpacing: 10,
            //   children: [
            //     // زر إضافة صورة جديدة
            //     InkWell(
            //       onTap: pickNewImage,
            //       child: Container(
            //         width: 90,
            //         height: 90,
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade300,
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //         child: Icon(Icons.add),
            //       ),
            //     ),

            //     // عرض الصور الجديدة
            //     ...newImages.map((file) {
            //       return Stack(
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(12),
            //             child: Image.file(
            //               file,
            //               width: 90,
            //               height: 90,
            //               fit: BoxFit.cover,
            //             ),
            //           ),
            //           Positioned(
            //             top: -5,
            //             right: -5,
            //             child: IconButton(
            //               icon: Icon(Icons.close, color: Colors.red),
            //               onPressed: () {
            //                 setState(() {
            //                   newImages.remove(file);
            //                 });
            //               },
            //             ),
            //           ),
            //         ],
            //       );
            //     }).toList(),
            //   ],
            // ),
            SizedBox(height: 30),

            // ===================== زر حفظ التعديلات =====================
            BlocConsumer<UpdateComplaintsCubit, UpdateComplaintsState>(
              listener: (context, state) {
                if (state is UpdateComplaintsSuccess) {
                  //  GoRouter.of(context).push(AppRouter.addComplaintView);
                  context.pop(true);
                }
              },
              builder: (context, state) {
                final cubit = UpdateComplaintsCubit.get(context);
                if (state is UpdateComplaintsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        cubit.updateComplaint(
                          widget.complaint.id,
                          locationController.text,
                          descriptionController.text,
                          newImages,
                          oldImageIds,
                        );
                        print("location: ${locationController.text}");
                        print("Desc: ${descriptionController.text}");

                        print("Old Image IDs: $oldImageIds");
                        print("New Images Count: ${newImages.length}");
                        print("====================================");

                        print("Final Attachments to Send:");
                        print("🟦 Old IDs → $oldImageIds");

                        for (var file in newImages) {
                          print("🟩 New File → ${file.path}");
                        }

                        print(
                          "Total Attachments: ${oldImageIds.length + newImages.length}",
                        );
                        print("====================================");
                      },

                      child: Text(
                        t.saveEdit,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  );
                }
              },
            ),
            LanguageToggleButton(),
          ],
        ),
      ),
    );
  }
}
