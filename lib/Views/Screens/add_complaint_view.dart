import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shakwa/Controllers/add_complaints/add_complaints_cubit.dart';
import 'package:shakwa/Controllers/complaint_type/complaint_type_cubit.dart';
import 'package:shakwa/Controllers/govenment/govenment_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Data/Models/complaints_type_model.dart';
import 'package:shakwa/Data/Models/government_model.dart';
import 'package:shakwa/Views/Widgets/custom_appBar.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddComplaintView extends StatefulWidget {
  const AddComplaintView({super.key});

  @override
  State<AddComplaintView> createState() => _AddComplaintViewState();
}

class _AddComplaintViewState extends State<AddComplaintView> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedGovernment;
  String? _selectedType;

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  GovernmentModel? _governmentsList;
  ComplaintTypeResponse? _type;

  int? typeId;
  List<File> selectedFiles = [];

  // متغير للتحكم في عرض مؤشر التحميل
  bool _isFetchingGovernments = false;

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: customAppBar(t.complaintAdd),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// ================= الجهة الحكومية =================
              Text(t.government),
              const SizedBox(height: 8),

              BlocListener<GovenmentCubit, GovenmentState>(
                listener: (context, state) {
                  if (state is GovenmentLoading) {
                    // إظهار ديالوج التحميل
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder:
                          (c) => const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          ),
                    );
                    _isFetchingGovernments = true;
                  } else if (state is GovenmentLoaded) {
                    // إخفاء ديالوج التحميل إذا كان مفتوحاً
                    if (_isFetchingGovernments) {
                      Navigator.pop(context);
                      _isFetchingGovernments = false;
                    }

                    _governmentsList = state.model;

                    // ✅ فتح القائمة تلقائياً بعد التحميل
                    _showSelectionSheet(
                      title: t.selectGovernment,
                      items:
                          _governmentsList?.data
                              ?.map((e) => e.name!)
                              .toList() ??
                          [],
                      onSelected: (val) {
                        setState(() {
                          _selectedGovernment = val;
                          _selectedType = null;
                          typeId = null;
                          _type = null;
                        });
                        final gov = _governmentsList!.data!.firstWhere(
                          (e) => e.name == val,
                        );
                        context.read<ComplaintTypeCubit>().getCoplaintsType(
                          gov.id.toString(),
                        );
                      },
                    );
                  } else if (state is GovenmentFetchFail) {
                    if (_isFetchingGovernments) {
                      Navigator.pop(context);
                      _isFetchingGovernments = false;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('فشل تحميل الجهات')),
                    );
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    // إذا كانت البيانات موجودة مسبقاً، افتح القائمة فوراً
                    if (_governmentsList != null) {
                      _showSelectionSheet(
                        title: 'اختر الجهة الحكومية',
                        items:
                            _governmentsList?.data
                                ?.map((e) => e.name!)
                                .toList() ??
                            [],
                        onSelected: (val) {
                          setState(() {
                            _selectedGovernment = val;
                            _selectedType = null;
                            typeId = null;
                            _type = null;
                          });
                          final gov = _governmentsList!.data!.firstWhere(
                            (e) => e.name == val,
                          );
                          context.read<ComplaintTypeCubit>().getCoplaintsType(
                            gov.id.toString(),
                          );
                        },
                      );
                    } else {
                      // إذا لم تكن موجودة، اطلبها (الـ Listener سيتولى فتح القائمة)
                      context.read<GovenmentCubit>().getAllGovernment();
                    }
                  },
                  child: _buildFakeDropdown(
                    text: _selectedGovernment ?? 'اختر الجهة الحكومية',
                    isPlaceholder: _selectedGovernment == null,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// ================= نوع الشكوى =================
              Text(t.complaintType),
              const SizedBox(height: 8),

              BlocListener<ComplaintTypeCubit, ComplaintTypeState>(
                listener: (context, state) {
                  if (state is ComplaintTypeLoaded) {
                    setState(() {
                      _type = state.model;
                    });
                  }
                },
                child: GestureDetector(
                  onTap: () {
                    if (_selectedGovernment == null) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(t.selectAlert)));
                      return;
                    }

                    if (_type != null) {
                      _showSelectionSheet(
                        title: t.selectType,
                        items: _type?.data?.map((e) => e.name!).toList() ?? [],
                        onSelected: (val) {
                          setState(() {
                            _selectedType = val;
                            final selectedType = _type!.data!.firstWhere(
                              (e) => e.name == val,
                            );
                            typeId = selectedType.id;
                          });
                        },
                      );
                    }
                  },
                  child: _buildFakeDropdown(
                    text: _selectedType ?? t.selectType,
                    isPlaceholder: _selectedType == null,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// ================= الموقع =================
              Text(t.loc),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                validator: (v) => v!.isEmpty ? t.enterLocation : null,
                decoration: _inputDecoration(t.enterLocation),
              ),

              const SizedBox(height: 16),

              /// ================= التفاصيل =================
              Text(t.addDetails),
              const SizedBox(height: 8),
              TextFormField(
                controller: _detailsController,
                maxLines: 6,
                validator: (v) => v!.isEmpty ? t.enterDetails : null,
                decoration: _inputDecoration(t.enterDetails),
              ),

              const SizedBox(height: 20),

              /// ================= المرفقات (كما هي في كودك) =================
              Text(t.attachment),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result = await FilePicker.platform
                      .pickFiles(allowMultiple: true, type: FileType.any);

                  if (result != null) {
                    setState(() {
                      selectedFiles.addAll(
                        result.paths.whereType<String>().map((e) => File(e)),
                      );
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColor.primaryColor.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  child:
                      selectedFiles.isEmpty
                          ? _emptyAttachmentWidget(t.selectFile)
                          : _filesGrid(),
                ),
              ),

              const SizedBox(height: 28),

              /// ================= زر الإرسال (كما هو في كودك) =================
              BlocConsumer<AddComplaintsCubit, AddComplaintsState>(
                listener: (context, state) {
                  if (state is AddComplaintsSuccess) {
                    context.pop(true);
                  } else if (state is AddComplaintsFailed) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text:
                        state is AddComplaintsLoading
                            ? t.sending
                            : t.sendComplaint,
                    onTap:
                        state is AddComplaintsLoading
                            ? null
                            : () {
                              if (typeId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(t.selectType)),
                                );
                              } else if (_formKey.currentState!.validate()) {
                                context
                                    .read<AddComplaintsCubit>()
                                    .sendComplaint(
                                      _locationController.text,
                                      _detailsController.text,
                                      typeId!,
                                      selectedFiles,
                                    );
                              }
                            },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Widgets ---

  // تصميم يشبه الـ Dropdown ولكنه مجرد Container
  Widget _buildFakeDropdown({
    required String text,
    required bool isPlaceholder,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.primaryColor.withOpacity(0.7)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: isPlaceholder ? Colors.grey[600] :Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
    );
  }

  // دالة لإظهار القائمة السفلية
  void _showSelectionSheet({
    required String title,
    required List<String> items,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    onTap: () {
                      onSelected(items[index]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // بقية الـ Widgets الخاصة بالمرفقات والحقول
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.all(12),
      // Border when not focused
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: BorderSide(
      //     color: AppColor.primaryColor.withOpacity(0.4), // 🔹 change this
      //     width: 1,
      //   ),
      // ),

      // // Border when focused
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(8),
      //   borderSide: const BorderSide(
      //     color: Colors.blue, // 🔹 change this
      //     width: 2,
      //   ),
      // ),
    );
  }

  Widget _emptyAttachmentWidget(String title) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.attach_file_outlined,
              size: 28,
              color: AppColor.primaryColor,
            ),
            SizedBox(width: 18),
            Icon(
              Icons.photo_library_outlined,
              size: 28,
              color: AppColor.primaryColor,
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(title),
      ],
    );
  }

  Widget _filesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedFiles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final file = selectedFiles[index];
        final isImage =
            file.path.endsWith('.png') ||
            file.path.endsWith('.jpg') ||
            file.path.endsWith('.jpeg');
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
              ),
              child:
                  isImage
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(file, fit: BoxFit.cover),
                      )
                      : const Center(
                        child: Icon(Icons.insert_drive_file, size: 32),
                      ),
            ),
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: () => setState(() => selectedFiles.removeAt(index)),
                child: const CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.black54,
                  child: Icon(Icons.close, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
