import 'dart:io';

import 'package:proving/proving.dart';
import 'package:test/test.dart';

void main() {
  group('Resources', () {
    test('using resourceFile', () {
      expect(
        resourceFile('foo.txt').readAsStringSync(),
        equals('This is foo!'),
      );
    });

    test('using resourceUri', () {
      expect(
        resourceUri('foo.txt').toString(),
        allOf(
          startsWith('file://'),
          endsWith('/proving/test/resources/foo.txt'),
        ),
      );
    });

    test('using resourceDirectory', () {
      expect(resourceDirectory().path, endsWith('/proving/test/resources/'));
    });

    test('using resourceString', () {
      expect(resourceString('foo.txt'), equals('This is foo!'));
      expect(resourceString('subdir/bar.txt'), equals('I am bar!'));
    });

    test('using templateResource', () {
      expect(
        templateResource('template.txt', {'alpha': '42', 'name': 'Chris'}),
        equals('Hi Chris, the answer is 42!'),
      );
    });

    test('using resourceBytes', () {
      expect(resourceBytes('foo.txt').length, equals(12));
    });
  });

  group('Copying Resources', () {
    final tmpDir = fixtureForEach(TempDirFixture());

    test('using copyResourceTo', () {
      final tempFile = File('${tmpDir.directory.path}/other.txt');
      copyResourceTo('foo.txt', tempFile);

      _expectFileWith(tempFile, 'This is foo!');
    });

    test('using copyResourceInto', () {
      copyResourceInto('foo.txt', tmpDir.directory);

      _expectFileWith(File('${tmpDir.directory.path}/foo.txt'), 'This is foo!');
    });

    test('copy of nonexisting resource', () {
      final tempFile = File('${tmpDir.directory.path}/other.txt');
      expect(() => copyResourceTo('nothere.txt', tempFile), throwsException);
    });

    test('copy-into with nonexisting resource', () {
      expect(
        () => copyResourceInto('nothere.txt', tmpDir.directory),
        throwsException,
      );
    });

    test('using copyResourceInto with new dir', () {
      copyResourceInto('foo.txt', Directory('${tmpDir.directory.path}/other'));

      _expectFileWith(
        File('${tmpDir.directory.path}/other/foo.txt'),
        'This is foo!',
      );
    });
  });
}

void _expectFileWith(File file, String text) {
  expect(file.existsSync(), isTrue);
  expect(file.readAsStringSync(), equals(text));
}
