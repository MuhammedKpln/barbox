class LoginResponse {
  String token;

  LoginResponse({required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        token: json["token"] as String,
      );
}
