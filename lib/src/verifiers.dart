import 'package:test/test.dart';

/// Verifies (using `expect`) that the two provided instances, which should be
/// eqivalent (but not the same instance) are actually equal.
///
/// # Arguments
/// - `Object instanceA` - one distinct instance of the object
/// - `Object instanceB` - another distinct instance of the object
void verifyEqualsAndHashCode(Object instanceA, Object instanceB) {
  expect(instanceA, equals(instanceA));
  expect(instanceB, equals(instanceB));
  expect(instanceA, equals(instanceB));
  expect(instanceB, equals(instanceA));

  expect(instanceA.hashCode, equals(instanceA.hashCode));
  expect(instanceB.hashCode, equals(instanceB.hashCode));
  expect(instanceA.hashCode, equals(instanceB.hashCode));
  expect(instanceB.hashCode, equals(instanceA.hashCode));
}

/// Verifies (using `expect`) that the result of calling `toString()` on the given
/// object is equal to the expected value.
///
/// # Arguments
/// - `Object object` - the object being tested.
/// - `String string` - the expected string value.
void verifyToString(Object object, String string) {
  verifyToStringMatches(object, equals(string));
}

/// Verifies (using `expect`) that the result of calling `toString()` on the given
/// object matches the provided matcher.
///
/// # Arguments
/// - `Object object` - the object being tested.
/// - `Matcher matcher` - the matcher used to verify the result
void verifyToStringMatches(Object object, Matcher matcher) {
  expect(object.toString(), matcher);
}
