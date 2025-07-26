import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'intensity_with_date_response.g.dart';

///Could be refactored to be generic in the future
@JsonSerializable()
class IntensityWithDateResponse {
  final DateTime from;
  final DateTime to;
  final IntensityResponse intensity;

  IntensityWithDateResponse(this.from, this.to, this.intensity);

  factory IntensityWithDateResponse.fromJson(Map<String, dynamic> json) =>
      _$IntensityWithDateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IntensityWithDateResponseToJson(this);
}
