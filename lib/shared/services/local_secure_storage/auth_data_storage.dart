abstract class AuthDataStorage {
  Future<void> setRefreshToken({
    required String refreshTokenKey,
    required String refreshToken,
  });
  Future<void> setTokenId({
    required String tokenIdKey,
    required String tokenId,
  });
  Future<String?> getTokenId({
    required String tokenIdKey,
  });
  Future<String?> getRefreshToken({
    required String refreshTokenKey,
  });
  void deleteUserData();
}
