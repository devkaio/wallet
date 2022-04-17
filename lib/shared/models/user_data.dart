import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wallet/shared/models/user.dart';

class UserData {
  List<User> users;
  UserData({
    required this.users,
  });

  UserData copyWith({
    List<User>? users,
  }) {
    return UserData(
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      users: List<User>.from(map['users']?.map((x) => User.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() => 'UserData(users: $users)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData && listEquals(other.users, users);
  }

  @override
  int get hashCode => users.hashCode;
}
