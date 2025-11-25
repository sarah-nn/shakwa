// ================= ComplaintItem =================
class ComplaintModel {
  final int id;
  final String referenceNumber;
  final String location;
  final String description;
  final String status;
  final ComplaintType complaintType;
  final String createdAt;
  final String updatedAt;

  ComplaintModel({
    required this.id, 
    required this.referenceNumber,
    required this.location,
    required this.description,
    required this.status,
    required this.complaintType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) {
    return ComplaintModel(
      id: json['id'],
      referenceNumber: json['reference_number'],
      location: json['location'],
      description: json['description'],
      status: json['status'],
      complaintType: ComplaintType.fromJson(json['complaintType']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "reference_number": referenceNumber,
      "location": location,
      "description": description,
      "status": status,
      "complaintType": complaintType.toJson(),
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}

// ================= ComplaintType =================
class ComplaintType {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  ComplaintType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComplaintType.fromJson(Map<String, dynamic> json) {
    return ComplaintType(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
