# Proving

A collection of useful functions for doing Dart unit testing.

## Installation 💻

In order to start using Proving you must have the [Dart SDK](https://dart.dev/get-dart) 
installed on your machine.

Install via `dart pub add`:

```sh
dart pub add proving
```

> **Taskfile.** This project uses [Taskfile](https://taskfile.dev) to simplify development tasks.
> It is not a requirement, but recommended.

## Running Tests 🧪

To run all unit tests:

```sh
dart test
```

### Coverage

In order to do anything useful with the test coverage, you must have `lcov` installed. You can
install it using one of the following:

```sh
sudo apt install lcov
brew install lcov
sudo yum install lcov
```

Once you have `lcov` installed, you can run the tests with coverage as follows:

```sh
dart pub global run coverage:test_with_coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
genhtml coverage/lcov.info -o coverage/
```

The you can open the `coverage/index.html` file to review the coverage report.

## License

Proving is licensed under the [3-Clause BSD License](https://opensource.org/license/bsd-3-clause/).
