import 'dart:io';

import 'package:test/test.dart';

/// Defines an abstract Fixture which will setup (`before`) and teardown (`after`)
/// required "fixtures" for testing.
///
/// Use one of the two fixture application functions to apply the fixture to
/// the test lifecyle:
/// - `fixtureForEach` to have the fixture registered before and after each test
/// - `fixtureForAll` to have it registered before and after all tests in a group.
///
/// Your implementation should override the before and/or after methods to
/// perform your desired setup and teardown operations.
abstract class Fixture {
  /// The lifecycle handler method for setting up the desired fixture data.
  void before() {}

  /// The lifecycle handler method for tearing down the fixture data.
  void after() {}
}

/// Used to register a `Fixture` to be executed before and after each test method
/// in the group.
///
/// # Arguments
/// - `T fixture` - the fixture instance to be registered
///
/// # Returns
/// The instance of the fixture passed in, for convenience.
T fixtureForEach<T extends Fixture>(T fixture) {
  setUp(fixture.before);
  tearDown(fixture.after);
  return fixture;
}

/// Used to register a `Fixture` to be executed before the tests are executed in
/// a group, and then again after all the group tests have executed.
///
/// # Arguments
/// - `T fixture` - the fixture instance to be registered
///
/// # Returns
/// The instance of the fixture passed in, for convenience.
T fixtureForAll<T extends Fixture>(T fixture) {
  setUpAll(fixture.before);
  tearDownAll(fixture.after);
  return fixture;
}

/// A `Fixture` used to create a temporary directory, which will be created on
/// setup, and deleted on teardown.
///
/// # Example
/// ```dart
/// group('Some test', (){
///   final tmpDir = fixtureForEach<TempDirFixture>(TempDirFixture())
///
///   test('testing something', (){
///     // ... use tmpDir.directory here ...
///   });
/// });
/// ```
class TempDirFixture extends Fixture {
  /// The temporary directory (will be deleted after tests).
  late Directory directory;

  /// Creates the temporary directory and exposes it as the `directory` property.
  @override
  void before() {
    directory = Directory.systemTemp.createTempSync();
  }

  /// Cleans out and deletes the temporary directory.
  @override
  void after() {
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
  }
}
