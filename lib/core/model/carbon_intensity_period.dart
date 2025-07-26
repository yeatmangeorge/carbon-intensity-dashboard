import 'package:carbon_intensity_dashboard/core/model/carbon_intensity.dart';

import '../either.dart';
import '../failure.dart';

class CarbonIntensityPeriod {
  final DateTime from;
  final DateTime to;
  final CarbonIntensity intensity;

  CarbonIntensityPeriod._(this.from, this.to, this.intensity);

  /// ensures validation when creating the model
  static Either<Failure, CarbonIntensityPeriod> create(
    DateTime from,
    DateTime to,
    CarbonIntensity intensity,
  ) {
    final CarbonIntensityPeriod carbonIntensityPeriod = CarbonIntensityPeriod._(
      from,
      to,
      intensity,
    );

    if (!carbonIntensityPeriod._validate()) {
      return Either.left(Failure.invalidState());
    }

    return Either.right(carbonIntensityPeriod);
  }

  bool _validate() {
    if (from.isAfter(to)) {
      return false;
    }

    return true;
  }
}
