import 'magma.dart';

class Semigroup<T> extends Magma<T> {
  Semigroup({
    required super.elements,
    required super.operation,
  }) {
    if (!isAssociative()) {
      throw ArgumentError('Semigroup binary operations must be associative.');
    }
  }
}
