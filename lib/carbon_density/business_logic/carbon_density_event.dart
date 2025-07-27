part of 'carbon_density_bloc.dart';

sealed class CarbonDensityEvent extends Equatable {
  const CarbonDensityEvent();

  @override
  List<Object?> get props => [];
}

class StartPollingCarbonDensityEvent extends CarbonDensityEvent {
  const StartPollingCarbonDensityEvent();

  @override
  List<Object?> get props => [];
}
