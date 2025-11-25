class ComplaintTypeResponse {
  final List<ComplaintTypeModel>? data;
  final String? message;
  final String? status;

  ComplaintTypeResponse({this.data, this.message, this.status});

  factory ComplaintTypeResponse.fromJson(Map<String, dynamic> json) {
    return ComplaintTypeResponse(
      data:
          json['data'] != null
              ? (json['data'] as List)
                  .map((e) => ComplaintTypeModel.fromJson(e))
                  .toList()
              : null,
      message: json['message'] as String?,
      status: json['status'] as String?,
    );
  }
}

class ComplaintTypeModel {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  ComplaintTypeModel({this.id, this.name, this.createdAt, this.updatedAt});

  factory ComplaintTypeModel.fromJson(Map<String, dynamic> json) {
    return ComplaintTypeModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
