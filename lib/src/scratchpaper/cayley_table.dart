class CayleyTable {
  final List<List<int>> table;
  final int order;

  CayleyTable(elements)
      : table = _validate(elements),
        order = elements.toList().length;

  factory CayleyTable.from(elements) => CayleyTable(elements);

  static List<List<int>> _validate(elements) {
    var arr = elements.toList();
    print(arr);

    int nrows = arr.length;
    int ncols = arr[0].length;

    if (nrows != ncols) {
      throw Exception(
          "Input arrays must be square; this one is $nrows x $ncols.");
    }

    if (!arr.every(
        (row) => row.every((element) => element >= 0 && element < nrows))) {
      throw Exception(
          "All integers must be between 0 and ${nrows - 1}, inclusive.");
    }

    return arr;
  }

  bool isAssociative() {
    List<int> indices = List<int>.generate(order, (index) => index);
    bool result = true;
    for (int a in indices) {
      for (int b in indices) {
        for (int c in indices) {
          int ab = table[a][b];
          int bc = table[b][c];
          if (table[ab][c] != table[a][bc]) {
            result = false;
            break;
          }
        }
      }
    }
    return result;
  }

  bool isCommutative() {
    bool result = true;
    for (int a = 0; a < order; a++) {
      for (int b = a + 1; b < order; b++) {
        if (table[a][b] != table[b][a]) {
          result = false;
          break;
        }
      }
    }
    return result;
  }

  bool distributesOver(CayleyTable other, {bool verbose = false}) {
    int n = order;
    int m = other.order;
    if (n != m) {
      throw ArgumentError("Table sizes must be the same.");
    } else {
      bool isDistributive = true;
      for (int a = 0; a < n; a++) {
        for (int b = 0; b < n; b++) {
          for (int c = 0; c < n; c++) {
            int otherBC = other.table[b][c];
            int ab = table[a][b];
            int ac = table[a][c];
            if (table[a][otherBC] != other.table[ab][ac]) {
              if (verbose) {
                print("\na = $a; b = $b; c = $c");
                print("$a x $otherBC != $ab + $ac");
              }
              isDistributive = false;
              break;
            }
          }
        }
      }
      return isDistributive;
    }
  }

  int? leftIdentity() {
    List<int> elements = List<int>.generate(order, (index) => index);
    int? lid;
    for (int x in elements) {
      if (table[x].every((element) => element == elements.indexOf(element))) {
        lid = x;
        break;
      }
    }
    return lid;
  }

  int? rightIdentity() {
    List<int> elements = List<int>.generate(order, (index) => index);
    int? rid;
    for (int x in elements) {
      if (table.every((row) => row[x] == elements.indexOf(row[x]))) {
        rid = x;
        break;
      }
    }
    return rid;
  }

  int? identity() {
    int? leftId = leftIdentity();
    int? rightId = rightIdentity();
    if (leftId != null && rightId != null) {
      return (leftId == rightId) ? leftId : null;
    } else {
      return null;
    }
  }

  bool hasInverses() {
    int? identityElem = identity();
    if (identityElem != null) {
      List<int> rowIndices = [];
      List<int> colIndices = [];
      for (int i = 0; i < order; i++) {
        for (int j = 0; j < order; j++) {
          if (table[i][j] == identityElem) {
            rowIndices.add(i);
            colIndices.add(j);
          }
        }
      }
      return Set<int>.from(rowIndices) == Set<int>.from(colIndices) &&
          rowIndices.length == order;
    } else {
      return false;
    }
  }

  Map<int, int> inverseLookupDict(int identity) {
    List<int> elements = List<int>.generate(order, (index) => index);
    List<int> rowIndices = [];
    List<int> colIndices = [];
    for (int i = 0; i < order; i++) {
      for (int j = 0; j < order; j++) {
        if (table[i][j] == identity) {
          rowIndices.add(i);
          colIndices.add(j);
        }
      }
    }
    return Map<int, int>.fromIterables(
        rowIndices.map((index) => elements[index]),
        colIndices.map((index) => elements[index]));
  }

  void about({bool printout = false}) {
    String n = order.toString();
    String ass = isAssociative().toString();
    String co = isCommutative().toString();
    String lid = leftIdentity()?.toString() ?? "None";
    String rid = rightIdentity()?.toString() ?? "None";
    String ident = identity()?.toString() ?? "None";
    String invs = hasInverses().toString();

    if (printout) {
      print(
        "  Order  Associative?  Commutative?  Left Id?  Right Id?  Identity?  Inverses?",
      );
      print('-' * 85);
      print(
        "${n.padLeft(6)} ${ass.padLeft(11)} ${co.padLeft(12)} ${lid.padLeft(12)} ${rid.padLeft(9)} ${ident.padLeft(10)} ${invs.padLeft(10)}",
      );
    }
  }
}
