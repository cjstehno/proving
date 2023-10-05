import 'dart:io';

import 'package:proving/proving.dart';
import 'package:test/test.dart';

void main() {
  group('Resources', () {
    test('using resourceFile', () {
      expect(
          resourceFile('foo.txt').readAsStringSync(), equals('This is foo!'));
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

      expect(tempFile.existsSync(), isTrue);
      expect(tempFile.readAsStringSync(), equals('This is foo!'));
    });

    test('using copyResourceInto', () {
      copyResourceInto('foo.txt', tmpDir.directory);

      final file = File('${tmpDir.directory.path}/foo.txt');
      expect(file.existsSync(), isTrue);
      expect(file.readAsStringSync(), equals('This is foo!'));
    });
  });
}
