part of 'carbon_density_bloc.dart';

sealed class CarbonDensityState extends Equatable {}

final class CarbonDensityInitial extends CarbonDensityState {
  @override
  List<Object> get props => [];
}

final class CarbonDensityLoading extends CarbonDensityState {
  @override
  List<Object?> get props => [];
}

final class CarbonDensityLoaded extends CarbonDensityState {
  final CarbonIntensity currentIntensity;
  final List<CarbonIntensityPeriod> intensityPeriodsForDay;

  CarbonDensityLoaded({
    required this.currentIntensity,
    required this.intensityPeriodsForDay,
  });

  @override
  List<Object?> get props => [currentIntensity, intensityPeriodsForDay];
}

final class CarbonDensityError extends CarbonDensityState {
  final Failure failure;

  CarbonDensityError(this.failure);

  @override
  List<Object?> get props => [failure];
}
