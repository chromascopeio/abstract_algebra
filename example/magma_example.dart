import 'package:abstract_algebra/abstract_algebra.dart';

void main() {
  // Define a magma with integer addition
  var integerAdditionMagma = Magma<int>(
    elements: {1, 2, 3, 4, 5},
    operation: (a, b) => (a * b) % 5,
  );
}
