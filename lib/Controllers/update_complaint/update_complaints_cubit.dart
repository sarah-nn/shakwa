import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shakwa/Data/Repos/update_complaints_repo.dart';

part 'update_complaints_state.dart';

class UpdateComplaintsCubit extends Cubit<UpdateComplaintsState> {
  UpdateComplaintsCubit(this.updateComplaintRepo)
    : super(UpdateComplaintsInitial());

  final UpdateComplaintRepo updateComplaintRepo;

  static UpdateComplaintsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  updateComplaint(
    int complaintId,
    String location,
    String desc,
    List<File> newImages,
    List<int> oldImagesIds,
  ) async {
    emit(UpdateComplaintsLoading());

    final List<MultipartFile> multipartFiles = [];

    for (var file in newImages) {
      multipartFiles.add(
        await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      );
    }

    final Map<String, dynamic> data = {
      'location': location,
      'description': desc,
      'files': multipartFiles,
    };

    for (int i = 0; i < oldImagesIds.length; i++) {
      data['keepAttachmentIds[$i]'] = oldImagesIds[i];
    }

    final FormData formData = FormData.fromMap(data);

    final result = await updateComplaintRepo.update(formData, complaintId);
    result.fold(
      (failure) {
        emit(UpdateComplaintsFail(errMssg: failure.errorMessage));
      },
      (success) {
        emit(UpdateComplaintsSuccess(successMessage: success));
      },
    );
  }
}
