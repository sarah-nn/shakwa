import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/complaint_type/complaint_type_cubit.dart';
import 'package:shakwa/Controllers/govenment/govenment_cubit.dart';
import 'package:shakwa/Data/Models/complaints_type_model.dart';
import 'package:shakwa/Data/Models/government_model.dart';
import 'package:shakwa/Views/Widgets/attachement_widget.dart';
import 'package:shakwa/Views/Widgets/complaint_add_details_widget.dart';
import 'package:shakwa/Views/Widgets/complaints_widget.dart';
import 'package:shakwa/Views/Widgets/custom_appBar.dart';
import 'package:shakwa/Views/Widgets/government_widget.dart';
import 'package:shakwa/Views/Widgets/location_widget.dart';
import 'package:shakwa/Views/Widgets/send_complaints_button.dart';

class AddComplaintView extends StatefulWidget {
  const AddComplaintView({super.key});

  @override
  State<AddComplaintView> createState() => _AddComplaintViewState();
}

class _AddComplaintViewState extends State<AddComplaintView> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  String? _selectedGovernment;
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  GovernmentModel? _governmentsList;
  ComplaintTypeResponse? _type;
  bool chooseGov = false;
  bool getFile = false;
  int? typeId;
  String? filepathes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GovenmentCubit>().getAllGovernment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('إضافة شكوى'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),

              // الجهة الحكومية
              GovernmentWidget(
                governmentsList: _governmentsList,
                onChanged: (v) {
                  setState(() {
                    _selectedGovernment = v;
                    chooseGov = true;
                  });
                  final selectedGov = _governmentsList!.data!.firstWhere(
                    (e) => e.name == v,
                  );
                  context.read<ComplaintTypeCubit>().getCoplaintsType(
                    selectedGov.id.toString(),
                  );
                },
                selectedGovernment: _selectedGovernment!,
              ),
              const SizedBox(height: 16),

              // نوع الشكوى
              !chooseGov
                  ? Container()
                  : ComplaintsWidget(
                    chooseGov: chooseGov,
                    onChanged: (v) {
                      setState(() {
                        _selectedType = v;
                        final selectedType = _type!.data!.firstWhere(
                          (e) => e.name == v,
                        );

                        typeId = selectedType.id;
                      });
                    },
                    selectedType: _selectedType!,
                  ),
              SizedBox(height: 16),

              // الموقع
              LocationWidget(controller: _locationController),

              const SizedBox(height: 16),

              // الوصف التفصيلي
              ComplaintAddDetailsWidget(controller: _detailsController),
              const SizedBox(height: 20),

              // المرفقات
              AttachementWidget(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    // إذا تم اختيار ملف
                    String? filePath = result.files.single.path;
                    if (filePath != null) {
                      print('مسار الملف: $filePath');
                      setState(() {
                        getFile = true;
                        filepathes = filePath;
                      });
                    } else {
                      print('حدث خطأ: لم يتم الحصول على مسار الملف.');
                    }
                  } else {
                    print('تم إلغاء اختيار الملف.');
                  }
                },
                getFile: getFile,
              ),

              const SizedBox(height: 28),

              // زر الإرسال
              SendComplaintsButton(
                locationC: _locationController,
                detailsC: _detailsController,
                typeId: typeId,
                filePathes: filepathes,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
