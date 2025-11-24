class SigninResponseModel {
  final String accessToken;
  final String refreshToken;

  SigninResponseModel({required this.accessToken, required this.refreshToken});

  factory SigninResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return SigninResponseModel(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
    );
  }
}
