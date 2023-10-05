import 'dart:io';

import 'package:test/test.dart';

/// An abstract base class for test fixtures that can be registered
/// with the testing lifecycle using the `applyFixture(Fixture)`
/// function.
///
/// Implementations should override and implement the desired lifecycle
/// methods.
abstract class Fixture {
  /// Registers a `setUp` operation to be executed before each test (in a group).
  void setUp() {}

  /// Registers a `tearDown` operation to be executed after each test (in a group).
  void tearDown() {}

  /// Registers a `setUpAll` operation to be executed before all tests (in a group).
  void setUpAll() {}

  /// Registers a `tearDownAll` operation to be executed after all tests (in a group).
  void tearDownAll() {}
}

/// Registers the provided `Fixture` with the test lifecycle hooks for the
/// current group.
///
/// # Arguments
/// - `Fixture fixture` the fixture to be registered.
///
/// # Returns
/// The instance of the `Fixture` passed in, for convenience.
T applyFixture<T extends Fixture>(T fixture) {
  setUp(fixture.setUp);
  tearDown(fixture.tearDown);
  setUpAll(fixture.setUpAll);
  tearDownAll(fixture.tearDownAll);
  return fixture;
}

/// A `Fixture` used to create a temporary directory, which will be created on
/// setup, and deleted on teardown.
///
/// # Example
/// ```dart
/// group('Some test', (){
///   final tmpDir = applyFixture<TempDirFixture>(TempDirFixture())
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
  void setUp() {
    directory = Directory.systemTemp.createTempSync();
  }

  /// Cleans out and deletes the temporary directory.
  @override
  void tearDown() {
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
  }
}
