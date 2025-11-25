
// // ================= ComplaintDetails =================
// class ComplaintDetailsModel {
//   final int id;
//   final String referenceNumber;
//   final String location;
//   final String description;
//   final String status;
//   final String createdAt;
//   final List<dynamic> attachments;
//   final List<Comment> requestsAndReplies;
//   final List<Comment> employeeNotes;

//   ComplaintDetailsModel({
//     required this.id,
//     required this.referenceNumber,
//     required this.location,
//     required this.description,
//     required this.status,
//     required this.createdAt,
//     required this.attachments,
//     required this.requestsAndReplies,
//     required this.employeeNotes,
//   });

//   factory ComplaintDetailsModel.fromJson(Map<String, dynamic> json) {
//     return ComplaintDetailsModel(
//       id: json['id'],
//       referenceNumber: json['reference_number'],
//       location: json['location'],
//       description: json['description'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       attachments: json['attachments'] ?? [],
//       requestsAndReplies: (json['requestsAndReplies'] as List?)
//               ?.map((e) => Comment.fromJson(e))
//               .toList() ??
//           [],
//       employeeNotes: (json['employee_notes'] as List?)
//               ?.map((e) => Comment.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "reference_number": referenceNumber,
//       "location": location,
//       "description": description,
//       "status": status,
//       "created_at": createdAt,
//       "attachments": attachments,
//       "requestsAndReplies": requestsAndReplies.map((e) => e.toJson()).toList(),
//       "employee_notes": employeeNotes.map((e) => e.toJson()).toList(),
//     };
//   }
// }

// // ================= Comment =================
// class Comment {
//   final int id;
//   final String text;
//   final String complaintType;
//   final String createdAt;
//   final User user;

//   Comment({
//     required this.id,
//     required this.text,
//     required this.complaintType,
//     required this.createdAt,
//     required this.user,
//   });

//   factory Comment.fromJson(Map<String, dynamic> json) {
//     return Comment(
//       id: json['id'],
//       text: json['text'],
//       complaintType: json['complaintType'],
//       createdAt: json['created_at'],
//       user: User.fromJson(json['user']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "text": text,
//       "complaintType": complaintType,
//       "created_at": createdAt,
//       "user": user.toJson(),
//     };
//   }
// }

// // ================= User =================
// class User {
//   final int id;
//   final String fullName;
//   final String role;

//   User({
//     required this.id,
//     required this.fullName,
//     required this.role,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       fullName: json['full_name'] ?? '',
//       role: json['role'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "full_name": fullName,
//       "role": role,
//     };
//   }
// }
// ================= ComplaintDetails =================
class ComplaintDetailsModel {
  final int id;
  final String referenceNumber;
  final String location;
  final String description;
  final String status;
  final String createdAt;
  final List<Attachment> attachments;
  final List<Comment> requestsAndReplies;
  final List<Comment> employeeNotes;

  ComplaintDetailsModel({
    required this.id,
    required this.referenceNumber,
    required this.location,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.attachments,
    required this.requestsAndReplies,
    required this.employeeNotes,
  });

  factory ComplaintDetailsModel.fromJson(Map<String, dynamic> json) {
    return ComplaintDetailsModel(
      id: json['id'] ?? 0,
      referenceNumber: json['reference_number'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',

      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => Attachment.fromJson(e))
              .toList() ??
          [],

      requestsAndReplies: (json['requestsAndReplies'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e))
              .toList() ??
          [],

      employeeNotes: (json['employee_notes'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e))
              .toList() ??
          [],
    );
  }
}

// ===============================================================
// Attachment Model
// ===============================================================

class Attachment {
  final int id;
  final String filePath;
  final String fileType;
  final String createdAt;

  Attachment({
    required this.id,
    required this.filePath,
    required this.fileType,
    required this.createdAt,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'] ?? 0,
      filePath: json['file_path'] ?? "",
      fileType: json['file_type'] ?? "",
      createdAt: json['created_at'] ?? "",
    );
  }
}

// ===============================================================
// Comment Model
// ===============================================================

class Comment {
  final int id;
  final String text;
  final String complaintType;
  final String createdAt;
  final User user;

  Comment({
    required this.id,
    required this.text,
    required this.complaintType,
    required this.createdAt,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      complaintType: json['complaintType'] ?? '',
      createdAt: json['created_at'] ?? '',
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

// ===============================================================
// User Model
// ===============================================================

class User {
  final int id;
  final String fullName;
  final String role;

  User({
    required this.id,
    required this.fullName,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      fullName: json['full_name'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
