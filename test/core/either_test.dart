import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test either folding", () {
    test("Left folds", () {
      Either<String, int> result = Either.left("error");
      result.fold(
        onLeft: (String value) {
          expect(value, "error");
        },
        onRight: (_) {
          fail("should not have folded right");
        },
      );
    });
    test("Right folds", () {
      Either<String, int> result = Either.right(50);
      result.fold(
        onLeft: (_) {
          fail("should not have folded left");
        },
        onRight: (int value) {
          expect(50, value);
        },
      );
    });
  });
}
