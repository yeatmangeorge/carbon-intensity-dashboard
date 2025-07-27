import 'package:carbon_intensity_dashboard/core/failure.dart';

/// Class for strings. By keeping this in one place, it will be easy to refactor
/// for a translations package in the future
class Strings {
  static const String carbonIntensity = "Carbon Intensity";

  static const String getCarbonIntensity = "Get $carbonIntensity";

  static String currentCarbonIntensity(int grams) =>
      "Current $carbonIntensity $grams g CO2 per kWh";
}

extension FailureStrings on Failure {
  String toHumanString() {
    switch (this) {
      case NetworkConnectionFailure():
        return "Network Connection issue. Check you are connected to the internet";
      case HttpFailure():
        {
          int restCode = (this as HttpFailure).restCode;
          return "$restCode error: Something went wrong.";
        }
      case UnknownFailure():
        return "Something went wrong";
      case InvalidStateFailure():
        return "Something went wrong";
    }
  }
}
