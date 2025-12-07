import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/govenment/govenment_cubit.dart';
import 'package:shakwa/Data/Models/government_model.dart';
import 'package:shakwa/Views/Widgets/droip_dwon_button.dart';

class GovernmentWidget extends StatelessWidget {
  GovernmentWidget({
    super.key,
    required this.governmentsList,
    required this.onChanged,
    required this.selectedGovernment,
  });

  GovernmentModel? governmentsList;
  Function(String?) onChanged;
  String selectedGovernment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('الجهة الحكومية', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),

        BlocConsumer<GovenmentCubit, GovenmentState>(
          listener: (context, state) {
            if (state is GovenmentLoaded) {
              governmentsList = state.model;
              // setState(() {
              //   //_governmentsList = state.model;
              // });
            }
          },
          builder: (context, state) {
            if (state is GovenmentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GovenmentFetchFail) {
              return Center(child: Text('حدث خطأ: ${state.errMessage}'));
            }
            if (governmentsList == null) {
              return const SizedBox();
            }

            return BuildDropDwonButton(
              value: selectedGovernment,
              hint: 'اختر الجهة الحكومية',
              items: governmentsList!.data!.map((e) => e.name!).toList(),
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }
}
