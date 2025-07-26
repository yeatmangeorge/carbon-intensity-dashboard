import 'dart:convert';

import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Decoding intensity response", () {
    final jsonString = '''
      {
        "forecast": 266,
        "actual": 263,
        "index": "moderate"
      }
    ''';

    final json = jsonDecode(jsonString);
    final response = IntensityResponse.fromJson(json);

    expect(response.forecast, 266);
    expect(response.actual, 263);
    expect(response.index, "moderate");
  });
}
