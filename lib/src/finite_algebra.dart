class FiniteAlgebra<T> {
  final String? name;
  final String? description;
  final Set<T> elements;
  final T Function(T, T) operation;

  const FiniteAlgebra({
    required this.elements,
    required this.operation,
    this.name,
    this.description,
  });

  int get order => elements.length;

  T operate(T a, T b) {
    if (!elements.contains(a) || !elements.contains(b)) {
      throw ArgumentError("Both elements must belong to the algebra.");
    }

    return operation(a, b);
  }

  bool hasIdentity() {
    for (var element in elements) {
      bool hasIdentity = true;

      for (var otherElement in elements) {
        if (operation(element, otherElement) != otherElement ||
            operation(otherElement, element) != otherElement) {
          hasIdentity = false;
          break;
        }
      }

      if (hasIdentity) {
        return true;
      }
    }
    return false;
  }

  bool isAssociative() {
    for (var a in elements) {
      for (var b in elements) {
        for (var c in elements) {
          final leftResult = operation(operation(a, b), c);
          final rightResult = operation(a, operation(b, c));
          if (leftResult != rightResult) {
            return false;
          }
        }
      }
    }
    return true;
  }

  T getIdentityElement() {
    for (var element in elements) {
      bool isIdentity = true;

      // Check if element is an identity candidate
      for (var otherElement in elements) {
        if (operation(element, otherElement) != otherElement ||
            operation(otherElement, element) != otherElement) {
          isIdentity = false;
          break;
        }
      }

      // If it satisfies the identity properties, return it as the identity element
      if (isIdentity) {
        return element;
      }
    }

    throw ArgumentError('No identity element found.');
  }
}
