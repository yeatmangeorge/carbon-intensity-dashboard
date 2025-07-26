import 'package:json_annotation/json_annotation.dart';

part 'intensity_response.g.dart';

@JsonSerializable()
class IntensityResponse {
  final int forecast;
  final int? actual;
  final String index;

  IntensityResponse({
    required this.forecast,
    required this.actual,
    required this.index,
  });

  factory IntensityResponse.fromJson(Map<String, dynamic> json) =>
      _$IntensityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IntensityResponseToJson(this);
}
