import 'package:test/test.dart';

import 'package:ngcomponents/utils/strings/string_utils.dart';

void main() {
  test('Ensure camelCase converts correctly', () {
    expect(camelCase('foo bar'), 'FooBar');
    expect(camelCase('foo-bar'), 'FooBar');
    expect(camelCase('foo_bar'), 'FooBar');
  });
}
