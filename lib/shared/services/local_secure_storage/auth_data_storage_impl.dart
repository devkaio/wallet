import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet/shared/services/local_secure_storage/auth_data_storage.dart';

class AuthDataStorageImpl implements AuthDataStorage {
  @override
  void deleteUserData() {
    const _storage = FlutterSecureStorage();
    _storage.deleteAll();
  }

  @override
  Future<String?> getTokenId({required String tokenIdKey}) async {
    const _storage = FlutterSecureStorage();
    final result = await _storage.read(key: tokenIdKey);
    return result;
  }

  @override
  Future<void> setTokenId({
    required String tokenIdKey,
    required String tokenId,
  }) async {
    const _storage = FlutterSecureStorage();
    _storage.write(
      key: tokenIdKey,
      value: tokenId,
    );
  }

  @override
  Future<String?> getRefreshToken({
    required String refreshTokenKey,
  }) async {
    const _storage = FlutterSecureStorage();
    final result = await _storage.read(key: refreshTokenKey);
    return result;
  }

  @override
  Future<void> setRefreshToken({
    required String refreshTokenKey,
    required String refreshToken,
  }) async {
    const _storage = FlutterSecureStorage();
    _storage.write(
      key: refreshTokenKey,
      value: refreshToken,
    );
  }
}
