import 'package:proving/proving.dart';
import 'package:test/test.dart';

void main() {
  parametizedGroup<List<int>>(
    'Parametized Group',
    [
      [1, 2, 3],
      [2, 4, 6],
    ],
    (List<int> arg) => expect(arg[0] + arg[1], equals(arg[2])),
  );

  group('Parametized Test', () {
    parametizedTest<List<int>>(
      [
        [1, 2, 3],
        [2, 4, 6],
      ],
      (List<int> arg) => expect(arg[0] + arg[1], equals(arg[2])),
    );
  });
}
