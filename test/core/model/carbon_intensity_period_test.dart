import 'package:carbon_intensity_dashboard/core/model/carbon_intensity.dart';
import 'package:carbon_intensity_dashboard/core/model/carbon_intensity_period.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("carbon intensity period validation", () {
    final carbonIntensityResult = CarbonIntensity.create(5, 5);
    final carbonIntensity = carbonIntensityResult.fold(
      onLeft: (_) => fail("couldn't create carbon intensity"),
      onRight: (value) => value,
    );
    test("carbon intensity valid", () {
      final carbonIntensityPeriod = CarbonIntensityPeriod.create(
        DateTime(2025),
        DateTime(2026),
        carbonIntensity,
      );
      carbonIntensityPeriod.fold(
        onLeft: (_) => fail("should be valid"),
        onRight: (value) => value,
      );
    });
    test("carbon intensity invalid", () {
      final carbonIntensityPeriod = CarbonIntensityPeriod.create(
        DateTime(2026),
        DateTime(2025),
        carbonIntensity,
      );
      carbonIntensityPeriod.fold(
        onLeft: (_) {},
        onRight: (_) => fail("should be invalid"),
      );
    });
  });
}
