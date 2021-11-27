// This doesn't act as an actual test.
// It's just for the CI to pass when we have yet to write any meaningful tests.

import 'package:test/test.dart';

import 'package:angular_components/utils/strings/string_utils.dart';

void main() {
  group('Utils test | string_utils |', () {
    test('ensure `split()` split strings correctly', () {
      const result1 = ['foo', 'bar'];

      expect(split('foo bar'), result1);
      expect(split('foo-bar'), result1);
      expect(split('foo_bar'), result1);
      expect(split('fooBar'), ['foo', 'Bar']);
    });

    test('ensure camel case converts correctly', () {
      const result1 = 'FooBar';
      const result2 = 'Foo';

      expect(camelCase('foo bar'), result1);
      expect(camelCase('foo-bar'), result1);
      expect(camelCase('foo_bar'), result1);
      expect(camelCase('foo\\bar'), result1);
      expect(camelCase('foo'), result2);
      expect(camelCase('foo '), result2);
      expect(camelCase('foo-'), result2);
      expect(camelCase('_foo'), result2);
      expect(camelCase(''), '');
      expect('    ', '    ');
      // expect('   -word', '   Word');
      expect('1336', '1336');
      // expect('foo3bar', 'Foo3bar');
      expect('3bar', '3bar');
    });

    test('ensure hyphenate converts correctly', () {
      const result1 = 'bad-apple';

      expect(hyphenate('bad apple'), result1);
      expect(hyphenate('Bad apple'), result1);
      expect(hyphenate('Bad Apple'), result1);
      expect(hyphenate('bAd AppLe'), 'b-ad-app-le');
      expect(hyphenate('bAd 3AppLe'), 'b-ad-3app-le');
      expect(hyphenate('bAd App3Le'), 'b-ad-app3le');
    });

    test('ensure underscore converts correctly', () {
      const result1 = 'nice_peach';

      expect(underscore('nice peach'), result1);
      expect(underscore('nice Peach'), result1);
      expect(underscore('Nice Peach'), result1);
      expect(underscore('niCe PeaCh'), 'ni_ce_pea_ch');
      expect(underscore('niCe 3PeaCh'), 'ni_ce_3pea_ch');
      expect(underscore('niCe Pea3Ch'), 'ni_ce_pea3ch');
    });

    test('ensure lower camel case converts correctly', () {
      expect(lowerCamelCase('dart is cool'), 'dartIsCool');
      expect(lowerCamelCase('dart is 2cool'), 'dartIs2cool');
    });

    test('ensure title case converts correctly', () {
      expect(titleCase('ToKillAMockingbird'), 'To Kill A Mockingbird');
      expect(titleCase('Gone with the wind'), 'Gone with the wind');
    });
  });
}
