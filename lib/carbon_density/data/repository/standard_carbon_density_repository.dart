import 'dart:async';

import 'package:carbon_intensity_dashboard/carbon_density/data/repository/carbon_density_repository.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/carbon_density_api_datasource.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_data_response.dart';
import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:carbon_intensity_dashboard/core/failure.dart';

final _pollRateMs = 30_000;

class StandardCarbonDensityRepository implements CarbonDensityRepository {
  final CarbonDensityApiDatasource _carbonDensityApiDatasource;

  StandardCarbonDensityRepository({
    required CarbonDensityApiDatasource carbonDensityApiDatasource,
  }) : _carbonDensityApiDatasource = carbonDensityApiDatasource;

  @override
  Future<Either<Failure, IntensityDataResponse>> getPeriodsBetween(
    DateTime from,
    DateTime to,
  ) {
    return _carbonDensityApiDatasource.fetchIntensity(from, to);
  }

  @override
  Stream<Either<Failure, IntensityDataResponse>> getPeriodsBetweenStream(
    DateTime from,
    DateTime to,
  ) {
    final controller =
        StreamController<Either<Failure, IntensityDataResponse>>();
    Timer? timer;

    void poll() async {
      final result = await getPeriodsBetween(from, to);
      if (!controller.isClosed) {
        controller.add(result);
      }
    }

    poll();

    timer = Timer.periodic(Duration(milliseconds: _pollRateMs), (_) {
      poll();
    });

    controller.onCancel = () {
      timer?.cancel();
      controller.close();
    };

    return controller.stream;
  }
}
