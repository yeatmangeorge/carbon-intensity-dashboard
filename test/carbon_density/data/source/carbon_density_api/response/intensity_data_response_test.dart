import 'dart:convert';

import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_data_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Decoding intensity data response", () {
    final jsonString = '''
    {
      "data":[
      {
      "from": "2018-01-20T12:00Z",
      "to": "2018-01-20T12:30Z",
      "intensity": {
      "forecast": 266,
      "actual": 263,
      "index": "moderate"
      }
    }]
   }
  ''';

    final json = jsonDecode(jsonString);
    final response = IntensityDataResponse.fromJson(json);

    expect(response.data.length, 1);
  });
}
