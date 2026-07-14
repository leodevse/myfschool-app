class UserAccount {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String phone;
  final String role;
  final bool isActive;

  UserAccount({
    required this.id,
    required this.fullName,
    required this.username,
    required this.email,
    required this.phone,
    required this.role,
    required this.isActive,
  });

  UserAccount copyWith({
    String? id,
    String? fullName,
    String? username,
    String? email,
    String? phone,
    String? role,
    bool? isActive,
  }) {
    return UserAccount(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "username": username,
      "email": email,
      "phone": phone,
      "role": role,
      "isActive": isActive,
    };
  }

  factory UserAccount.fromJson(Map<String, dynamic> json) {
    return UserAccount(
      id: json["id"].toString(),
      fullName: json["fullName"].toString(),
      username: json["username"].toString(),
      email: json["email"].toString(),
      phone: json["phone"].toString(),
      role: json["role"].toString(),
      isActive: json["isActive"] == true,
    );
  }
}