import 'package:abstract_algebra/src/semigroup.dart';
import 'package:test/test.dart';

void main() {
  group('Semigroup Tests', () {
    // Test case 1: Associative binary operation
    test('Associative Binary Operation', () {
      final semigroup = Semigroup<int>(
        elements: {1, 2, 3, 4},
        operation: (a, b) => (a + b) % 5, // Addition modulo 5 is associative
      );

      expect(semigroup.isAssociative(), true);
    });

    // Test case 2: Non-associative binary operation
    test('Non-Associative Binary Operation', () {
      expect(
        () => Semigroup<int>(
          elements: {1, 2, 3, 4},
          operation: (a, b) => a - b, // Subtraction is not associative
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
