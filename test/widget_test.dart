import 'package:flutter_test/flutter_test.dart';

import 'package:fake_store_demo/core/constants/app_constants.dart';

void main() {
  test('uses current Platzi fake API base URL', () {
    expect(AppConstants.apiBaseUrl, startsWith('https://api.escuelajs.co'));
  });
}
