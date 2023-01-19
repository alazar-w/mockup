import 'package:flutter_test/flutter_test.dart';
import 'package:interview_mockup/business/business.dart';

void main() {
  group('AccessTokenRepositoryTest', () {
    test("Testing Get Access Token", () async {
      final result = await AccessTokenAPI.getAccessToken("token");
      expect(result, true);
    });

  });
}