class AccessTokenAPI {
  AccessTokenAPI._();
  static Future<bool> getAccessToken(String accessRequest) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // HiveDB.addAccessToken("accessTokenResponse.accessToke");
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
