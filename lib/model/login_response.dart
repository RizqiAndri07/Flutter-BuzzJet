class LoginResponse {
  final bool status;
  final String message;
  final UserData userData;
  final String token;

  LoginResponse(
      {required this.status,
      required this.message,
      required this.userData,
      required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      userData: UserData.fromJson(json['data']['user']),
      token: json['data']['access_token'],
    );
  }
}

class UserData {
  final int id;
  final String name;
  final String email;

  UserData({required this.id, required this.name, required this.email});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}
