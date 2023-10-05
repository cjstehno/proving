import 'package:proving/proving.dart';
import 'package:test/test.dart';

void main() {
  group('Resources', () {
    test('using resourceFile', () {
      expect(resourceFile('foo.txt').readAsStringSync(), equals('This is foo!'));
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
  });
}
