import 'dart:convert';

class AuthData {
  final String? expiresIn;
  final String? refreshToken;
  final String? idToken;
  final String? localId;
  final String? email;
  final bool? registered;
  AuthData({
    this.expiresIn,
    this.refreshToken,
    this.idToken,
    this.localId,
    this.email,
    this.registered,
  });

  AuthData copyWith({
    String? expiresIn,
    String? refreshToken,
    String? idToken,
    String? localId,
    String? email,
    bool? registered,
  }) {
    return AuthData(
      expiresIn: expiresIn ?? this.expiresIn,
      refreshToken: refreshToken ?? this.refreshToken,
      idToken: idToken ?? this.idToken,
      localId: localId ?? this.localId,
      email: email ?? this.email,
      registered: registered ?? this.registered,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
      'idToken': idToken,
      'localId': localId,
      'email': email,
      'registered': registered,
    };
  }

  factory AuthData.fromMap(Map<String, dynamic> map) {
    return AuthData(
      expiresIn: map['expiresIn'],
      refreshToken: map['refreshToken'],
      idToken: map['idToken'],
      localId: map['localId'],
      email: map['email'],
      registered: map['registered'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthData.fromJson(String source) =>
      AuthData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthData(expiresIn: $expiresIn, refreshToken: $refreshToken, idToken: $idToken, localId: $localId, email: $email, registered: $registered)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthData &&
        other.expiresIn == expiresIn &&
        other.refreshToken == refreshToken &&
        other.idToken == idToken &&
        other.localId == localId &&
        other.email == email &&
        other.registered == registered;
  }

  @override
  int get hashCode {
    return expiresIn.hashCode ^
        refreshToken.hashCode ^
        idToken.hashCode ^
        localId.hashCode ^
        email.hashCode ^
        registered.hashCode;
  }
}
