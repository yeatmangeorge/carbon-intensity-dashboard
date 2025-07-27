import 'dart:async';

import 'package:carbon_intensity_dashboard/carbon_density/data/repository/carbon_density_repository.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/carbon_density_api_datasource.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_data_response.dart';
import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:carbon_intensity_dashboard/core/failure.dart';
import 'package:carbon_intensity_dashboard/core/model/carbon_intensity_period.dart';

final _pollRateMs = 30_000;

class StandardCarbonDensityRepository implements CarbonDensityRepository {
  final CarbonDensityApiDatasource _carbonDensityApiDatasource;

  StandardCarbonDensityRepository({
    required CarbonDensityApiDatasource carbonDensityApiDatasource,
  }) : _carbonDensityApiDatasource = carbonDensityApiDatasource;

  @override
  Future<Either<Failure, List<CarbonIntensityPeriod>>> getPeriodsBetween(
    DateTime from,
    DateTime to,
  ) async {
    final Either<Failure, IntensityDataResponse> carbonIntensityResponseResult =
        await _carbonDensityApiDatasource.fetchIntensity(from, to);

    final IntensityDataResponse intensityDataResponse =
        carbonIntensityResponseResult.fold(
          onLeft: (Failure failure) {
            return Either.left(failure);
          },
          onRight: (IntensityDataResponse intensityDataResponse) =>
              intensityDataResponse,
        );

    return intensityDataResponse.toIntensityPeriodList();
  }

  @override
  Stream<Either<Failure, List<CarbonIntensityPeriod>>> getPeriodsBetweenStream(
    DateTime from,
    DateTime to,
  ) {
    final controller =
        StreamController<Either<Failure, List<CarbonIntensityPeriod>>>();
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
