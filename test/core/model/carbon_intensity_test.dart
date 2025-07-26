import 'package:carbon_intensity_dashboard/core/model/carbon_intensity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("carbon intensity validation", () {
    test("carbon intensity valid", () {
      final carbonIntensity = CarbonIntensity.create(10, 15);
      carbonIntensity.fold(
        onLeft: (_) {
          fail("should be a valid input");
        },
        onRight: (value) {
          expect(value.forecast, 10);
          expect(value.actual, 15);
        },
      );
    });
    test("carbon intensity valid null actual", () {
      final carbonIntensity = CarbonIntensity.create(10, null);
      carbonIntensity.fold(
        onLeft: (_) {
          fail("should be a valid input");
        },
        onRight: (value) {
          expect(value.forecast, 10);
          expect(value.actual, null);
        },
      );
    });
    test("carbon intensity invalid", () {
      final carbonIntensity = CarbonIntensity.create(-12, null);
      carbonIntensity.fold(
        onLeft: (_) {},
        onRight: (value) {
          fail("should be an invalid input");
        },
      );
    });
  });
}
