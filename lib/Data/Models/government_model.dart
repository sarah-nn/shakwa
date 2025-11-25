class GovernmentModel {
  final List<GovernmentItem>? data;
  final String? status;

  GovernmentModel({this.data, this.status});

  List<String> get governmentNames {
    return data?.map((item) => item.name).whereType<String>().toList() ?? [];
  }

  factory GovernmentModel.fromJson(Map<String, dynamic> json) {
    return GovernmentModel(
      data:
          (json['data'] as List?)
              ?.map((e) => GovernmentItem.fromJson(e))
              .toList(),
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data?.map((e) => e.toJson()).toList(), 'status': status};
  }
}

class GovernmentItem {
  final int? id;
  final String? name;
  final String? description;
  final String? createdAt;
  final String? updatedAt;

  GovernmentItem({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory GovernmentItem.fromJson(Map<String, dynamic> json) {
    return GovernmentItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
