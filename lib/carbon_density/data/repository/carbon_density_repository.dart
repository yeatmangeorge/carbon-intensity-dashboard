import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:carbon_intensity_dashboard/core/failure.dart';
import 'package:carbon_intensity_dashboard/core/model/carbon_intensity_period.dart';

abstract class CarbonDensityRepository {
  /// fetches in half hour periods
  Future<Either<Failure, List<CarbonIntensityPeriod>>> getPeriodsBetween(
    DateTime from,
    DateTime to,
  );

  Stream<Either<Failure, List<CarbonIntensityPeriod>>> getPeriodsBetweenStream(
    DateTime from,
    DateTime to,
  );
}
