import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_with_date_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intensity_data_response.g.dart';

@JsonSerializable()
class IntensityDataResponse {
  final List<IntensityWithDateResponse> data;

  IntensityDataResponse(this.data);

  factory IntensityDataResponse.fromJson(Map<String, dynamic> json) =>
      _$IntensityDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IntensityDataResponseToJson(this);
}
