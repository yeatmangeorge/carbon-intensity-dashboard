import 'dart:convert';

import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/response/intensity_with_date_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Decoding intensity with date response", () {
    var jsonString = '''
    {
      "from": "2018-01-20T12:00Z",
      "to": "2018-01-20T12:30Z",
      "intensity": {
        "forecast": 266,
        "actual": 263,
        "index": "moderate"
      }
    }
    ''';

    final json = jsonDecode(jsonString);
    final response = IntensityWithDateResponse.fromJson(json);

    expect(
      response.from,
      DateTime.fromMillisecondsSinceEpoch(1516449600000).toUtc(),
    );
    expect(
      response.to,
      DateTime.fromMillisecondsSinceEpoch(1516451400000).toUtc(),
    );
  });
}
