abstract class AuthDataStorage {
  Future<void> setTokenId({
    required String tokenIdKey,
    required String tokenId,
  });
  Future<String?> getTokenId({
    required String tokenIdKey,
  });
  Future<void> deleteUserData();
}
