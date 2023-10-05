import 'package:proving/proving.dart';
import 'package:test/test.dart';

void main() {
  group('Fixtures - each', () {
    final tmpDir = fixtureForEach(TempDirFixture());

    test(
      'verify exists - each',
      () => expect(tmpDir.directory.existsSync(), isTrue),
    );
  });

  group('Fixtures - all', () {
    final tmpDir = fixtureForAll(TempDirFixture());

    test(
      'verify exists - all',
      () => expect(tmpDir.directory.existsSync(), isTrue),
    );
  });
}
