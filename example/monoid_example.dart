import 'package:abstract_algebra/src/monoid.dart';

void main() {
  var scale = ['C2', 'D2', 'E2', 'F2', 'G2'];

  final monoid = Monoid<int>(
    elements: {0, 1, 2, 3, 4},
    operation: (a, b) => (a * b) % 5,
  );

  var res = [];
  for (final row in monoid.elements) {
    var r = [];
    for (final col in monoid.elements) {
      r.add(scale[monoid.operate(row, col)]);
    }
    res.add(r);
  }
  res.forEach((r) => print(r));
}
