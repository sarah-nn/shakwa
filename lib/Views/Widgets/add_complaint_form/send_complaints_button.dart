import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Controllers/add_complaints/add_complaints_cubit.dart';
import 'package:shakwa/Controllers/compainte/complaint_cubit.dart';
import 'package:shakwa/Views/Widgets/custom_button.dart';

class SendComplaintsButton extends StatelessWidget {
  const SendComplaintsButton({
    super.key,
    this.filePathes,
    this.typeId,
    required this.locationC,
    required this.detailsC,
  });

  final String? filePathes;
  final int? typeId;
  final TextEditingController locationC, detailsC;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddComplaintsCubit, AddComplaintsState>(
      listener: (context, state) {
        if (state is AddComplaintsSuccess) {
          BlocProvider.of<ComplaintCubit>(context).getComplaint();
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return CustomButton(
          text: "ارسال الشكوى",
          onTap: () {
            print(
              "type id $typeId \n location ${locationC.text} \n desss ${detailsC.text}, \n $filePathes",
            );
            context.read<AddComplaintsCubit>().sendComplaint(
              locationC.text,
              detailsC.text,
              typeId!,
              filePathes!,
            );
          },
        );
      },
    );
  }
}
