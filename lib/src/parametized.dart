import 'package:test/test.dart';

/// Creates a parametized test group, where each element in `args` will be passed
/// to the test function as a separate test run.
///
/// The test calls generated with this method are wrapped in a single `group` call.
///
/// # Arguments
/// - `String description` - the group label to be used.
/// - `List<T> args` - the list of arguments for each test run.
/// - `Function testFn` - the test function to be executed.
///
/// # Example
/// The example below would add the first two numbers in each argument element
/// and expect the result to be the third element.
///
/// ```dart
/// parametizedGroup<List<int>>(
///   'adding two numbers',
///   [
///     [1, 2, 3],
///     [2, 4, 6],
///   ],
///   (List<int> arg) => expect(arg[0] + arg[1], equals(arg[2])),
/// );
/// ```
void parametizedGroup<T>(String description, List<T> args, Function testFn) {
  group(description, () {
    for (final arg in args) {
      test(' - testing: $arg', () {
        testFn(arg);
      });
    }
  });
}

/// Creates a collection of test calls based on the given test parameters, where
/// each element in the `args` list will be passed to a test function as a separate
/// test run.
///
/// The test calls generated with this function are NOT wrapped in a `group` call.
///
/// # Arguments
/// - `List<T> args` - the list of arguments for each test run.
/// - `Function testFn` - the test function to be executed.
///
/// # Example
/// The example below would add the first two numbers in each argument element
/// and expect the result to be the third element.
///
/// ```dart
/// group('testing addition', (){
///   parametizedTest<List<int>>(
///     [
///       [1, 2, 3],
///       [2, 4, 6],
///     ],
///     (List<int> arg) => expect(arg[0] + arg[1], equals(arg[2])),
///   );
/// });
/// ```
void parametizedTest<T>(List<T> args, Function testFn) {
  for (final arg in args) {
    test(' - testing: $arg', () {
      testFn(arg);
    });
  }
}
