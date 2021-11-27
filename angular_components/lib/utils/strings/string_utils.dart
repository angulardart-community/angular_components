// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:change_case/change_case.dart';

final RegExp _camelCaseSplitter = RegExp('([a-z])([A-Z])');

final RegExp _capitalLetter = RegExp('[A-Z]');

final RegExp _wordBreakSplitter = RegExp(r'[\s\-_]');

// This is removed after the `change_case` package is used for `camelCase()`.
// final RegExp _wordBreak = RegExp(r'(^|[\-_ ])(\w)');

/// Returns the hyphenated form of [s].
///
/// For details on what characters split the string, see the [split] function.
///
/// In addition, the entire string is made lower case.
String hyphenate(String s) => split(s).join('-').toLowerCase();

/// Returns the underscored form of [s].
///
/// For details on what characters split the string, see the [split] function.
///
/// In addition, the entire string is made lower case.
String underscore(String s) => split(s).join('_').toLowerCase();

/// Returns the camel-cased form of [s].
///
/// **NOTE**: technically this is pascal case, but for legacy reasons the name
/// is perserved. This will be changed in later versions.
///
/// This is a very simple function: it merely replaces usual delimiters (spaces,
/// hyphens, underscores) and the following word-character, with the upper case
/// form of the word-character. It doesn't change the case of any other letters.
///
/// Examples:
///
///  * "foo bar" => "FooBar"
///  * "foo-bar" => "FooBar"
///  * "foo_bar" => "FooBar"
///  * "foo\bar" => "FooBar"
///  * "foo" => "Foo"
///  * "foo " => "Foo"
///  * "foo-" => "Foo"
///  * "_foo" => "Foo"
///  * "" => ""
///  * "   " => "   "
///  * "   -word" => "   Word"
///  * "1337" => "1337"
///  * "foo3bar" => "Foo3bar"
///  * "3bar" => "3bar"
// TODO: this is actually pascal case. Change all references.
String camelCase(String s) => s.toPascalCase();

/// Returns the lower-camel-cased form of [s].
///
/// By common definition, this is the actual camel case!
String lowerCamelCase(String s) {
  String result = camelCase(s);
  result = result.replaceRange(0, 1, s[0].toLowerCase());
  return result;
}

/// Returns a human-readable title-cased form of a camel-cased String.
String titleCase(String s) =>
    s[0].toUpperCase() +
    s.substring(1).replaceAllMapped(_capitalLetter, (m) => ' ${m[0]}');

/// Returns the String [s], with the first letter capitalized.
String capitalizeFirstLetter(s) => s[0].toUpperCase() + s.substring(1);

/// Splits [s] into tokens.
///
/// Splits occur on:
///
/// * Whitespace: "foo bar" => ["foo", "bar"]
/// * Hyphens: "foo-bar" => ["foo", "bar"]
/// * Underscores: "foo_bar" => ["foo", "bar"]
/// * Camelcasing: "fooBar" => ["foo", "Bar"]
List<String> split(String s) => s
    // Convert camelCase splitting into word splitting.
    .replaceAllMapped(_camelCaseSplitter, (m) => '${m[1]} ${m[2]}')
    .split(_wordBreakSplitter);
