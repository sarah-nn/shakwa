import 'package:shakwa/Data/Models/complaint_model.dart';

class ComplaintPaginationModel {
  final List<ComplaintModel> complaints;
  final int total;
  final int page;
  final int limit;

  ComplaintPaginationModel({
    required this.complaints,
    required this.total,
    required this.page,
    required this.limit,
  });
}
