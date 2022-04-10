import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet/shared/services/local_secure_storage/auth_data_storage.dart';

class AuthDataStorageImpl implements AuthDataStorage {
  @override
  Future<void> deleteUserData() async {
    const _storage = FlutterSecureStorage();
    await _storage.deleteAll();
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
}
