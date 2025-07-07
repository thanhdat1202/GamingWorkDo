class UserModel {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String pass;

  UserModel({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.pass,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return UserModel(
      fullName: data['full_name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      pass: data['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'full_name': fullName, 'email': email, 'phone_number': phoneNumber};
  }
}
