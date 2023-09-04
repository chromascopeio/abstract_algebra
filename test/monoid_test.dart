import 'package:abstract_algebra/src/monoid.dart';
import 'package:test/test.dart';

void main() {
  group('Monoid Tests', () {
    // Test case 1: Valid Monoid with addition modulo 5
    test('Valid Monoid (Addition Modulo 5)', () {
      final monoid = Monoid<int>(
        elements: {0, 1, 2, 3, 4},
        operation: (a, b) => (a + b) % 5,
      );

      expect(monoid.hasIdentity(), isTrue);
      expect(monoid.identity, equals(0));
    });

    // Test case 2: Valid Monoid with multiplication
    test('Valid Monoid (Multiplication)', () {
      final monoid = Monoid<int>(
        elements: {1, 2, 3, 4},
        operation: (a, b) => a * b,
      );

      expect(monoid.hasIdentity(), isTrue);
      expect(monoid.identity, equals(1));
    });

    // Test case 3: Invalid Monoid without an identity element
    test('Invalid Monoid (No Identity Element)', () {
      expect(
        () => Monoid<int>(
          elements: {1, 2, 3, 4},
          operation: (a, b) =>
              a - b, // Subtraction does not have an identity element
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
