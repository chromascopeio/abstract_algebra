import 'semigroup.dart';

class Monoid<T> extends Semigroup<T> {
  Monoid({
    required super.elements,
    required super.operation,
  }) {
    if (!isAssociative()) {
      throw ArgumentError('Monoid binary operations must be associative.');
    }
    if (!hasIdentity()) {
      throw ArgumentError('Monoids must have an identity element.');
    }
  }

  T get identity => getIdentityElement();
}
