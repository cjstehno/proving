import 'package:equatable/equatable.dart';
import 'package:proving/proving.dart';
import 'package:test/test.dart';

class Person extends Equatable {
  const Person(this.name, this.age);

  final String name;
  final int age;

  @override
  List<Object?> get props => [name, age];
}

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
      verifyEqualsAndHashCode(
        // ignore: prefer_const_constructors
        Person('Bob', 42),
        // ignore: prefer_const_constructors
        Person('Bob', 42),
      );
    });

    test('same instance should fail', () {
      const inst = 'adsfg2345';

      try {
        verifyEqualsAndHashCode(inst, inst);
        fail('The expected excpeiton was not thrown.');
      } on Exception {
        // This is expected
      }
    });
  });
}
