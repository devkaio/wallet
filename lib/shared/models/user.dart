import 'dart:convert';

class UserData {
  final String userId;
  final String name;
  final String email;
  UserData({
    required this.userId,
    required this.name,
    required this.email,
  });

  UserData copyWith({
    String? userId,
    String? name,
    String? email,
  }) {
    return UserData(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() => 'UserData(userId: $userId, name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.userId == userId &&
        other.name == name &&
        other.email == email;
  }

  @override
  int get hashCode => userId.hashCode ^ name.hashCode ^ email.hashCode;
}
