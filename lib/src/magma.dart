import 'package:abstract_algebra/src/finite_algebra.dart';

/// A [Magma] consists of a set equipped with a single binary operation that must be closed by definition.
/// No other properties are imposed.
class Magma<T> extends FiniteAlgebra<T> {
  Magma({
    required super.elements,
    required super.operation,
  });
}
