class EndPoints {
  static const String baseUrl = 'http://192.168.1.104:4000';

  static const String signUp = '$baseUrl/authentication/user/sign-up';
  static const String signIn = '$baseUrl/authentication/sign-in';
  static const String verify = '$baseUrl/otps/verify-otp';
  static const String refreshToken = '$baseUrl/authentication/refresh-token';
  static const String allGovernment = '$baseUrl/government/all';
  static const String cType = '$baseUrl/complaint-types/government/';
  static const String sendComplaint = '$baseUrl/complaints/send-complaint';
  static const String complaint = '$baseUrl/complaints/user/my-complaints';
  static const String complaintDetails =
      '$baseUrl/complaints/user/my-complaints-sent-details/';
  static const String sendReply = '$baseUrl/complaint-comments/citizen-reply';
  static const String updateComplaint = '$baseUrl/complaints/update-complaint/';
  static const String allNotification =
      '$baseUrl/notification/get-all-notifications';
}
