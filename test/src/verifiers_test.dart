import 'package:proving/proving.dart';
import 'package:test/test.dart';

void main() {
  group('Verifiers', () {
    test('to-string literal', () {
      verifyToString(8675309, '8675309');
    });

    test('to-string matcher', () {
      verifyToStringMatches(
        'The time is 234234 pm.',
        allOf(
          startsWith('The time is '),
          endsWith(' pm.'),
        ),
      );
    });

    test('equality', () {
      const instA = '123abc';
      const instB = '123abc';
      verifyEqualsAndHashCode(instA, instB);
    });
  });
}
