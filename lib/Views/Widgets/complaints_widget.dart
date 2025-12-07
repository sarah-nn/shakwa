import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/complaint_type/complaint_type_cubit.dart';
import 'package:shakwa/Data/Models/complaints_type_model.dart';
import 'package:shakwa/Views/Widgets/droip_dwon_button.dart';

class ComplaintsWidget extends StatelessWidget {
  ComplaintsWidget({
    super.key,
    this.type,
    required this.chooseGov,
    required this.onChanged,
    required this.selectedType,
  });

  ComplaintTypeResponse? type;
  final bool chooseGov;
  final Function(String?) onChanged;
  String selectedType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('نوع الشكوى', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        !chooseGov
            ? Container()
            : BlocConsumer<ComplaintTypeCubit, ComplaintTypeState>(
              listener: (context, state) {
                if (state is ComplaintTypeLoaded) {
                  type = state.model;
                  // setState(() {
                  //   type = state.model;
                  //   //  _governmentsList = state.model.governmentNames;
                  // });
                }
              },
              builder: (context, state) {
                if (state is ComplaintTypeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ComplaintTypeFail) {
                  return Center(child: Text('حدث خطأ: ${state.errMessage}'));
                }
                if (type == null) return SizedBox();

                // الحالة الافتراضية: عرض الـ Dropdown مع القائمة المتاحة (سواء كانت فارغة أو مملوءة)

                return BuildDropDwonButton(
                  hint: "اختر نوع الشكوى",
                  items: type!.data!.map((e) => e.name!).toList(),
                  onChanged: onChanged,
                  value: selectedType,
                );
              },
            ),
      ],
    );
  }
}
