import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_data_response.dart';
import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:carbon_intensity_dashboard/core/failure.dart';

abstract class CarbonDensityRepository {
  /// fetches in half hour periods
  Future<Either<Failure, IntensityDataResponse>> getPeriodsBetween(
    DateTime from,
    DateTime to,
  );

  Stream<Either<Failure, IntensityDataResponse>> getPeriodsBetweenStream(
    DateTime from,
    DateTime to,
  );
}
