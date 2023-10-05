import 'package:proving/proving.dart';
import 'package:test/test.dart';

void main() {
  group('Fixtures', () {
    final tmpDir = applyFixture(TempDirFixture());

    test('verify exists', () => expect(tmpDir.directory.existsSync(), isTrue));
  });
}
