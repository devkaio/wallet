abstract class BiometricsStorage {
  Future<void> setBiometrics({
    required String biometricsKey,
    required bool biometric,
  });
  Future<String?> getBiometrics({
    required String biometricsKey,
  });
  Future<void> deleteBiometrics();
}
