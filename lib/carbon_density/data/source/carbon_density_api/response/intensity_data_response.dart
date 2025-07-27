import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_with_date_response.dart';
import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:carbon_intensity_dashboard/core/failure.dart';
import 'package:carbon_intensity_dashboard/core/model/carbon_intensity_period.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intensity_data_response.g.dart';

@JsonSerializable()
class IntensityDataResponse {
  final List<IntensityWithDateResponse> data;

  IntensityDataResponse(this.data);

  factory IntensityDataResponse.fromJson(Map<String, dynamic> json) =>
      _$IntensityDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IntensityDataResponseToJson(this);

  Either<Failure, List<CarbonIntensityPeriod>> toIntensityPeriodList() {
    final List<CarbonIntensityPeriod> carbonIntensityPeriods = [];

    for (final intensityWithDateResponse in data) {
      intensityWithDateResponse.toCarbonIntensityPeriod().fold(
        onLeft: (Failure failure) {
          return Either.left(failure);
        },
        onRight: (CarbonIntensityPeriod carbonIntensityPeriod) {
          carbonIntensityPeriods.add(carbonIntensityPeriod);
        },
      );
    }

    return Either.right(carbonIntensityPeriods);
  }
}
