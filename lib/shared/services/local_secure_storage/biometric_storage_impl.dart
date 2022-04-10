import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wallet/shared/services/local_secure_storage/biometrics_storage.dart';

class BiometricStorageImpl implements BiometricsStorage {
  @override
  Future<void> deleteBiometrics() async {
    const _storage = FlutterSecureStorage();
    await _storage.deleteAll();
  }

  @override
  Future<String?> getBiometrics({
    required String biometricsKey,
  }) async {
    const _storage = FlutterSecureStorage();
    return await _storage.read(key: biometricsKey);
  }

  @override
  Future<void> setBiometrics({
    required String biometricsKey,
    required bool biometric,
  }) async {
    const _storage = FlutterSecureStorage();
    return await _storage.write(
      key: biometricsKey,
      value: biometric.toString(),
    );
  }
}
