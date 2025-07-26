import '../either.dart';
import '../failure.dart';

class CarbonIntensity {
  final int forecast;
  final int? actual;

  CarbonIntensity._(this.forecast, this.actual);

  /// ensures validation when creating the model
  static Either<Failure, CarbonIntensity> create(int forecast, int? actual) {
    final carbonIntensity = CarbonIntensity._(forecast, actual);
    if (!carbonIntensity._validate()) {
      return Either.left(Failure.invalidState());
    }
    return Either.right(carbonIntensity);
  }

  bool _validate() {
    if (forecast < 0) {
      return false;
    }

    if (actual != null && actual! < 0) {
      return false;
    }

    return true;
  }
}
