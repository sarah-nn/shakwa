
import 'package:flutter/material.dart';
import 'package:shakwa/Core/Constants/app_color.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';
import 'package:shakwa/Views/Widgets/normal_appBar.dart';

class AddComplaintView extends StatefulWidget {
  const AddComplaintView({super.key});

  @override
  State<AddComplaintView> createState() => _AddComplaintViewState();
}

class _AddComplaintViewState extends State<AddComplaintView> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  String? _selectedGovernment;
  final TextEditingController _detailsController = TextEditingController();


  final List<String> types = ['نوع 1', 'نوع 2', 'نوع 3'];
  final List<String> governments = ['جهة 1', 'جهة 2', 'جهة 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: NormalAppBar(text: 'إضافة شكوى'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // نوع الشكوى
              const Text('نوع الشكوى', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _selectedType,
                hint: 'اختر نوع الشكوى',
                items: types,
                onChanged: (v) => setState(() => _selectedType = v),
              ),
                
              const SizedBox(height: 16),
                
              // الجهة الحكومية
              const Text('الجهة الحكومية', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _selectedGovernment,
                hint: 'اختر الجهة الحكومية',
                items: governments,
                onChanged: (v) => setState(() => _selectedGovernment = v),
              ),
                
              const SizedBox(height: 16),
                
              // الموقع
              const Text('الموقع', style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  side: BorderSide(color: AppColor.primaryColor.withOpacity(0.7)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  alignment: Alignment.centerRight,
                ),
                onPressed: () {
                 
                },
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "ادخل الموقع أو اختر من الخريطة",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
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
                    borderSide: BorderSide(color: AppColor.primaryColor.withOpacity(0.7)),
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.primaryColor.withOpacity(0.4), width: 1.5, style: BorderStyle.solid),
                ),
                child: Column(
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
                ),
              ),
                
              const SizedBox(height: 28),
                
              // زر الإرسال
              // 
              CustomButton(text: "ارسال الشكوى",onTap: (){},),
                
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({String? value, required String hint, required List<String> items, required Function(String?) onChanged}) {
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
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: onChanged,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, textAlign: TextAlign.right))).toList(),
        ),
      ),
    );
  }
}
