import 'dart:convert';

class TokenData {
  final String expiresIn;
  final String tokenType;
  final String refreshToken;
  final String idToken;
  final String userId;
  final String projectId;
  TokenData({
    required this.expiresIn,
    required this.tokenType,
    required this.refreshToken,
    required this.idToken,
    required this.userId,
    required this.projectId,
  });

  TokenData copyWith({
    String? expiresIn,
    String? tokenType,
    String? refreshToken,
    String? idToken,
    String? userId,
    String? projectId,
  }) {
    return TokenData(
      expiresIn: expiresIn ?? this.expiresIn,
      tokenType: tokenType ?? this.tokenType,
      refreshToken: refreshToken ?? this.refreshToken,
      idToken: idToken ?? this.idToken,
      userId: userId ?? this.userId,
      projectId: projectId ?? this.projectId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expires_in': expiresIn,
      'token_type': tokenType,
      'refresh_token': refreshToken,
      'id_token': idToken,
      'user_id': userId,
      'project_id': projectId,
    };
  }

  factory TokenData.fromMap(Map<String, dynamic> map) {
    return TokenData(
      expiresIn: map['expires_in'] ?? '',
      tokenType: map['token_type'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
      idToken: map['id_token'] ?? '',
      userId: map['user_id'] ?? '',
      projectId: map['project_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenData.fromJson(String source) =>
      TokenData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TokenData(expires_in: $expiresIn, token_type: $tokenType, refresh_token: $refreshToken, id_token: $idToken, user_id: $userId, project_id: $projectId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TokenData &&
        other.expiresIn == expiresIn &&
        other.tokenType == tokenType &&
        other.refreshToken == refreshToken &&
        other.idToken == idToken &&
        other.userId == userId &&
        other.projectId == projectId;
  }

  @override
  int get hashCode {
    return expiresIn.hashCode ^
        tokenType.hashCode ^
        refreshToken.hashCode ^
        idToken.hashCode ^
        userId.hashCode ^
        projectId.hashCode;
  }
}
