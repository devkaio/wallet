import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wallet/shared/models/user_info.dart';

class User {
  String? localId;
  String? email;
  bool? emailVerified;
  String? displayName;
  List<UserInfo>? providerUserInfo;
  String? photoUrl;
  String? passwordHash;
  int? passwordUpdatedAt;
  String? validSince;
  bool? disabled;
  String? lastLoginAt;
  String? createdAt;
  bool? customAuth;
  User({
    this.localId,
    this.email,
    this.emailVerified,
    this.displayName,
    this.providerUserInfo,
    this.photoUrl,
    this.passwordHash,
    this.passwordUpdatedAt,
    this.validSince,
    this.disabled,
    this.lastLoginAt,
    this.createdAt,
    this.customAuth,
  });

  User copyWith({
    String? localId,
    String? email,
    bool? emailVerified,
    String? displayName,
    List<UserInfo>? providerUserInfo,
    String? photoUrl,
    String? passwordHash,
    int? passwordUpdatedAt,
    String? validSince,
    bool? disabled,
    String? lastLoginAt,
    String? createdAt,
    bool? customAuth,
  }) {
    return User(
      localId: localId ?? this.localId,
      email: email ?? this.email,
      emailVerified: emailVerified ?? this.emailVerified,
      displayName: displayName ?? this.displayName,
      providerUserInfo: providerUserInfo ?? this.providerUserInfo,
      photoUrl: photoUrl ?? this.photoUrl,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordUpdatedAt: passwordUpdatedAt ?? this.passwordUpdatedAt,
      validSince: validSince ?? this.validSince,
      disabled: disabled ?? this.disabled,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      createdAt: createdAt ?? this.createdAt,
      customAuth: customAuth ?? this.customAuth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'localId': localId,
      'email': email,
      'emailVerified': emailVerified,
      'displayName': displayName,
      'providerUserInfo': providerUserInfo?.map((x) => x.toMap()).toList(),
      'photoUrl': photoUrl,
      'passwordHash': passwordHash,
      'passwordUpdatedAt': passwordUpdatedAt,
      'validSince': validSince,
      'disabled': disabled,
      'lastLoginAt': lastLoginAt,
      'createdAt': createdAt,
      'customAuth': customAuth,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      localId: map['localId'],
      email: map['email'],
      emailVerified: map['emailVerified'],
      displayName: map['displayName'],
      providerUserInfo: map['providerUserInfo'] != null
          ? List<UserInfo>.from(
              map['providerUserInfo']?.map((x) => UserInfo.fromMap(x)))
          : null,
      photoUrl: map['photoUrl'],
      passwordHash: map['passwordHash'],
      passwordUpdatedAt: map['passwordUpdatedAt']?.toInt(),
      validSince: map['validSince'],
      disabled: map['disabled'],
      lastLoginAt: map['lastLoginAt'],
      createdAt: map['createdAt'],
      customAuth: map['customAuth'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(localId: $localId, email: $email, emailVerified: $emailVerified, displayName: $displayName, providerUserInfo: $providerUserInfo, photoUrl: $photoUrl, passwordHash: $passwordHash, passwordUpdatedAt: $passwordUpdatedAt, validSince: $validSince, disabled: $disabled, lastLoginAt: $lastLoginAt, createdAt: $createdAt, customAuth: $customAuth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.localId == localId &&
        other.email == email &&
        other.emailVerified == emailVerified &&
        other.displayName == displayName &&
        listEquals(other.providerUserInfo, providerUserInfo) &&
        other.photoUrl == photoUrl &&
        other.passwordHash == passwordHash &&
        other.passwordUpdatedAt == passwordUpdatedAt &&
        other.validSince == validSince &&
        other.disabled == disabled &&
        other.lastLoginAt == lastLoginAt &&
        other.createdAt == createdAt &&
        other.customAuth == customAuth;
  }

  @override
  int get hashCode {
    return localId.hashCode ^
        email.hashCode ^
        emailVerified.hashCode ^
        displayName.hashCode ^
        providerUserInfo.hashCode ^
        photoUrl.hashCode ^
        passwordHash.hashCode ^
        passwordUpdatedAt.hashCode ^
        validSince.hashCode ^
        disabled.hashCode ^
        lastLoginAt.hashCode ^
        createdAt.hashCode ^
        customAuth.hashCode;
  }
}
