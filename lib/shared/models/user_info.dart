import 'dart:convert';

class UserInfo {
  String? providerId;
  String? displayName;
  String? photoUrl;
  String? federatedId;
  String? email;
  String? rawId;
  String? screenName;
  UserInfo({
    this.providerId,
    this.displayName,
    this.photoUrl,
    this.federatedId,
    this.email,
    this.rawId,
    this.screenName,
  });

  UserInfo copyWith({
    String? providerId,
    String? displayName,
    String? photoUrl,
    String? federatedId,
    String? email,
    String? rawId,
    String? screenName,
  }) {
    return UserInfo(
      providerId: providerId ?? this.providerId,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      federatedId: federatedId ?? this.federatedId,
      email: email ?? this.email,
      rawId: rawId ?? this.rawId,
      screenName: screenName ?? this.screenName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'providerId': providerId,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'federatedId': federatedId,
      'email': email,
      'rawId': rawId,
      'screenName': screenName,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      providerId: map['providerId'],
      displayName: map['displayName'],
      photoUrl: map['photoUrl'],
      federatedId: map['federatedId'],
      email: map['email'],
      rawId: map['rawId'],
      screenName: map['screenName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserInfo(providerId: $providerId, displayName: $displayName, photoUrl: $photoUrl, federatedId: $federatedId, email: $email, rawId: $rawId, screenName: $screenName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfo &&
        other.providerId == providerId &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl &&
        other.federatedId == federatedId &&
        other.email == email &&
        other.rawId == rawId &&
        other.screenName == screenName;
  }

  @override
  int get hashCode {
    return providerId.hashCode ^
        displayName.hashCode ^
        photoUrl.hashCode ^
        federatedId.hashCode ^
        email.hashCode ^
        rawId.hashCode ^
        screenName.hashCode;
  }
}
