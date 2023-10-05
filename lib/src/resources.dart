import 'dart:io';
import 'dart:typed_data';

const _defaultPrefix = 'test/resources/';
const _projectFile = 'pubspec.yaml';

/// Retrieves a test resource, as a `File`.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
///
/// # Return
/// A `File` reference to the specified resource.
///
/// # Example
/// ```dart
/// File textFile = resourceFile('data/test.txt');
/// ```
File resourceFile(String path, {String prefix = _defaultPrefix}) {
  var dir = Directory.current;
  while (!dir.listSync().any((entity) => entity.path.endsWith(_projectFile))) {
    dir = dir.parent;
  }
  return File('${dir.path}/$prefix$path');
}

/// Retrieves a test resource, as a `Uri`.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
///
/// # Return
/// A `Uri` reference to the specified resource.
///
/// # Example
/// ```dart
/// Uri uri = resourceUri('data/test.txt');
/// ```
Uri resourceUri(String path, {String prefix = _defaultPrefix}) {
  return resourceFile(path, prefix: prefix).uri;
}

/// Retrieves a test resource `Directory`.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
///
/// # Return
/// A `Directory` reference to the specified resource.
///
/// # Example
/// ```dart
/// Directory resourceDir = resourceDirectory('data/dir');
/// ```
Directory resourceDirectory(
    {String path = '', String prefix = _defaultPrefix}) {
  var dir = Directory.current;
  while (
      !dir.listSync().any((entity) => entity.path.endsWith('pubspec.yaml'))) {
    dir = dir.parent;
  }
  return Directory('${dir.path}/$prefix$path');
}

/// Retrieves a test resource, as a `String` of the file contents.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
///
/// # Return
/// A `String` containing the contents of the resource file.
///
/// # Example
/// ```dart
/// String text = resourceString('data/test.txt');
/// ```
String resourceString(String path, {String prefix = _defaultPrefix}) {
  return resourceFile(path, prefix: prefix).readAsStringSync();
}

/// Retrieves a test resource, as a the bytes of the file content.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
///
/// # Return
/// A `Uint8List` containing the contents of the resource file.
///
/// # Example
/// ```dart
/// Uint8List bytes = resourceBytes('data/some.jpg');
/// ```
Uint8List resourceBytes(String path, {String prefix = _defaultPrefix}) {
  return resourceFile(path, prefix: prefix).readAsBytesSync();
}

/// Retrieves a `String` containing the contents of a resource text file with its
/// template values (surrounded by `{{}}`) replaced with the provided map values.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `Map<String, dynamic> params` - the template replacement values.
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
///
/// # Return
/// A `String` containing the rendered template.
///
/// # Example
/// ```dart
/// String rendered = templateResource('data/the_template.txt', {'name':'Bob'});
/// ```
String templateResource(
  String path,
  Map<String, dynamic> params, {
  String prefix = _defaultPrefix,
}) {
  var template = resourceString(path, prefix: prefix);

  params.forEach((key, value) {
    template = template.replaceAll('{{$key}}', value.toString());
  });

  return template;
}

/// Copies the test resource at the specified `path` into the provided `File`,
/// creating it if necessary.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `File file` - the file which will be a copy of the resource file data.
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
void copyResourceTo(String path, File file, {String prefix = _defaultPrefix}) {
  final sourceFile = resourceFile(path, prefix: prefix);

  if (!sourceFile.existsSync()) {
    throw Exception('Resource file ($path) does not exist.');
  }

  file.parent.createSync(recursive: true);
  sourceFile.copySync(file.path);
}

/// Copies the test resource at the specified `path` into the provided `Directory` as
/// a `File` with the same filename as the original.
///
/// "Test resources" are files stored (by default) under the `test/resources/`
/// directory of the project root. This prefix may be changed, using the `prefix`
/// argument.
///
/// # Arguments
/// - `String path` - the relative path (from the `prefix` by default).
/// - `Directory dir` - the directory where the file is to be copied.
/// - `String prefix` - the path prefix from the project root (defaults to `test/resources`).
void copyResourceInto(
  String path,
  Directory dir, {
  String prefix = _defaultPrefix,
}) {
  final sourceFile = resourceFile(path, prefix: prefix);

  if (!sourceFile.existsSync()) {
    throw Exception('Resource file ($path) does not exist.');
  }

  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }

  sourceFile.copySync('${dir.path}/${sourceFile.uri.pathSegments.last}');
}
