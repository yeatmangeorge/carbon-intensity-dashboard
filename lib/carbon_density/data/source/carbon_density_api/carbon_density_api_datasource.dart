import 'package:dio/dio.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_data_response.dart';

import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:carbon_intensity_dashboard/core/failure.dart';
import 'package:intl/intl.dart';

final _carbonIntensityBaseEndpoint = "https://api.carbonintensity.org.uk";

/// We have chosen this endpoint as the one for the current date doesn't include
/// the last half an hour. This endpoint is also the most flexible for the
/// future.
String _carbonIntensityFromToEndpoint(String from, String to) =>
    "/intensity/$from/$to";

// todo add tests for this
class CarbonDensityApiDatasource {
  final Dio _dio;
  final _dateFormatter = DateFormat("yyyy-MM-ddTHH:mm'Z'");

  CarbonDensityApiDatasource(this._dio);

  Future<Either<Failure, IntensityDataResponse>> fetchIntensity(
    DateTime from,
    DateTime to,
  ) async {
    try {
      final url =
          _carbonIntensityBaseEndpoint +
          _carbonIntensityFromToEndpoint(
            _dateFormatter.format(from),
            _dateFormatter.format(to),
          );

      final response = await _dio.get(url);

      if (response.statusCode != 200) {
        final statusCode = response.statusCode;
        if (statusCode == null) {
          return Either.left(Failure.unknown());
        }
        final failure = Failure.http(statusCode);
        return Either.left(failure);
      }

      final intensityDataResponse = IntensityDataResponse.fromJson(
        response.data,
      );
      return Either.right(intensityDataResponse);

      //todo this could be extracted into a generic handler or interceptor
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
        case DioExceptionType.badCertificate:
        case DioExceptionType.cancel:
          return Either.left(Failure.networkConnection());
        case DioExceptionType.badResponse:
        case DioExceptionType.unknown:
          return Either.left(Failure.unknown());
      }
    } catch (e) {
      return Either.left(Failure.unknown());
    }
  }
}
