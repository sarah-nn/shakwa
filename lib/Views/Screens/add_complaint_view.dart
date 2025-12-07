import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/add_complaints/add_complaints_cubit.dart';
import 'package:shakwa/Controllers/complaint_type/complaint_type_cubit.dart';
import 'package:shakwa/Controllers/govenment/govenment_cubit.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Data/Models/complaints_type_model.dart';
import 'package:shakwa/Data/Models/government_model.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';

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

  final List<String> types = ['نوع 1', 'نوع 2', 'نوع 3'];
  final List<String> governments = ['نوع 1', 'نوع 2', 'نوع 3'];
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
      //appBar: NormalAppBar(text: 'إضافة شكوى'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 6),

              // الجهة الحكومية
              const Text('الجهة الحكومية', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),

              BlocConsumer<GovenmentCubit, GovenmentState>(
                listener: (context, state) {
                  if (state is GovenmentLoaded) {
                    setState(() {
                      _governmentsList = state.model;
                      //  _governmentsList = state.model.governmentNames;
                    });
                  }
                },
                builder: (context, state) {
                  if (state is GovenmentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GovenmentFetchFail) {
                    return Center(child: Text('حدث خطأ: ${state.errMessage}'));
                  }
                  if (_governmentsList == null) {
                    return const SizedBox(); // أو Text("لا توجد بيانات بعد")
                  }
                  // الحالة الافتراضية: عرض الـ Dropdown مع القائمة المتاحة (سواء كانت فارغة أو مملوءة)
                  return _buildDropdown(
                    value: _selectedGovernment,
                    hint: 'اختر الجهة الحكومية',
                    // استخدام القائمة التي تم جلبها
                    // items: governments,
                    items: _governmentsList!.data!.map((e) => e.name!).toList(),
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
                  );
                },
              ),
              const SizedBox(height: 16),
              // نوع الشكوى
              !chooseGov
                  ? Container()
                  : const Text('نوع الشكوى', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              !chooseGov
                  ? Container()
                  : BlocConsumer<ComplaintTypeCubit, ComplaintTypeState>(
                    listener: (context, state) {
                      if (state is ComplaintTypeLoaded) {
                        setState(() {
                          _type = state.model;
                          //  _governmentsList = state.model.governmentNames;
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is ComplaintTypeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ComplaintTypeFail) {
                        return Center(
                          child: Text('حدث خطأ: ${state.errMessage}'),
                        );
                      }
                      if (_type == null) return SizedBox();

                      // الحالة الافتراضية: عرض الـ Dropdown مع القائمة المتاحة (سواء كانت فارغة أو مملوءة)
                      return _buildDropdown(
                        value: _selectedType,
                        hint: 'اختر نوع الشكوى',
                        //items: types,
                        items: _type!.data!.map((e) => e.name!).toList(),
                        onChanged: (v) {
                          setState(() {
                            _selectedType = v;
                            final selectedType = _type!.data!.firstWhere(
                              (e) => e.name == v,
                            );

                            typeId = selectedType.id;
                          });
                        },
                      );
                    },
                  ),
              const SizedBox(height: 16),

              // الموقع
              const Text('الموقع', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'ادخل الموقع هنا ...',
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColor.primaryColor.withOpacity(0.7),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.primaryColor),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // الوصف التفصيلي
              const Text('الوصف التفصيلي', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _detailsController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'اكتب تفاصيل الشكوى هنا...',
                  contentPadding: const EdgeInsets.all(12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColor.primaryColor.withOpacity(0.7),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: AppColor.primaryColor),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // المرفقات
              const Text('المرفقات (اختياري)', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () async {
                  // فتح نافذة اختيار الملف
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
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 12,
                  ),
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

              const SizedBox(height: 28),

              // زر الإرسال
              //
              BlocBuilder<AddComplaintsCubit, AddComplaintsState>(
                builder: (context, state) {
                  return CustomButton(
                    text: "ارسال الشكوى",
                    onTap: () {
                      print(
                        "type id $typeId \n location ${_locationController.text} \n desss ${_detailsController.text}, \n $filepathes",
                      );
                      context.read<AddComplaintsCubit>().sendComplaint(
                        _locationController.text,
                        _detailsController.text,
                        typeId!,
                        filepathes!,
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
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
