/// A collection of unit testing tools to help "prove" that your code
/// works - the whole enchilada.
///
/// This library is somewhat opinionated, expecting the use of the standard
/// `test` library and matchers.
///
/// It provides functions to verify results, parametize tests, and work
/// with test resources. The goal is to provide some of the functionality
/// that seems to be missing from the available libraries.
library proving;

export 'src/fixtures.dart';
export 'src/parametized.dart';
export 'src/resources.dart';
export 'src/verifiers.dart';
