import 'package:abstract_algebra/src/magma.dart';
import 'package:test/test.dart';

void main() {
  group('Magma Tests', () {
    // Test case 1: Valid operation on elements
    test('Valid Operation', () {
      final magma = Magma<int>(
        elements: {1, 2, 3, 4},
        operation: (a, b) =>
            (a + b) % 5, // Example binary operation (addition modulo 5)
      );

      final result = magma.operate(2, 3);

      expect(result, equals(0));
    });

    // Test case 2: Non-associative operation
    test('Non-Associative Operation', () {
      final magma = Magma<int>(
        elements: {1, 2, 3, 4},
        operation: (a, b) => (a - b), // Subtraction is non-associative
      );

      // Attempt to operate in a non-associative manner
      final result1 = magma.operate(4, 2);
      final result2 = magma.operate(result1, 1);
      final result3 = magma.operate(4, result2);

      // Expect that the results will not be the same due to non-associativity
      expect(result3, isNot(equals(result1 - 2)));
    });
  });
}
