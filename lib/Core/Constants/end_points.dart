class EndPoints {
  static const String baseUrl = 'https://complaint-app-gvhv.onrender.com';

  static const String signUp = '$baseUrl/authentication/user/sign-up';
  static const String signIn = '$baseUrl/authentication/sign-in';
  static const String verify = '$baseUrl/otps/verify-otp';
  static const String refreshToken = '$baseUrl/authentication/refresh-token';
  static const String allGovernment = '$baseUrl/government';
  static const String Ctype = '$baseUrl/complaint-types/government/';
  static const String sendComplaint = '$baseUrl/complaints/send-complaint';
  static const String complaint = '$baseUrl/complaints/user/my-complaints';
  static const String complaintDetails =
      '$baseUrl/complaints/user/my-complaints-sent-details/';
  static const String sendReply = '$baseUrl/complaint-comments/citizen-reply';
}
