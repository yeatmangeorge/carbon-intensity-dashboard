import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/repository/carbon_density_repository.dart';
import 'package:carbon_intensity_dashboard/core/either.dart';
import 'package:carbon_intensity_dashboard/core/failure.dart';
import 'package:carbon_intensity_dashboard/core/model/carbon_intensity.dart';
import 'package:carbon_intensity_dashboard/core/model/carbon_intensity_period.dart';
import 'package:equatable/equatable.dart';

part 'carbon_density_event.dart';

part 'carbon_density_state.dart';

class CarbonDensityBloc extends Bloc<CarbonDensityEvent, CarbonDensityState> {
  final CarbonDensityRepository _carbonDensityRepository;

  CarbonDensityBloc(this._carbonDensityRepository)
    : super(CarbonDensityInitial()) {
    on<StartPollingCarbonDensityEvent>(_onStartPollingEvent);
  }

  FutureOr<void> _onStartPollingEvent(
    StartPollingCarbonDensityEvent event,
    Emitter<CarbonDensityState> emit,
  ) {
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfTomorrow = DateTime(now.year, now.month, now.day + 1);

    final Stream<Either<Failure, List<CarbonIntensityPeriod>>>
    carbonDensityStream = _carbonDensityRepository.getPeriodsBetweenStream(
      startOfToday,
      startOfTomorrow,
    );

    emit.forEach(
      carbonDensityStream,
      onData: (Either<Failure, List<CarbonIntensityPeriod>> streamResult) {
        return streamResult.fold(
          onLeft: (Failure failure) => CarbonDensityError(failure),
          onRight: (List<CarbonIntensityPeriod> carbonIntensityPeriods) {
            CarbonIntensity? currentCarbonIntensity;
            DateTime now = DateTime.now();
            for (var period in carbonIntensityPeriods) {
              if (now.isAfter(period.from) && now.isBefore(period.to)) {
                currentCarbonIntensity = period.intensity;
                break;
              }
            }

            if (currentCarbonIntensity == null) {
              throw InvalidStateFailure();
            }
            CarbonDensityLoaded(
              currentIntensity: currentCarbonIntensity,
              intensityPeriodsForDay: carbonIntensityPeriods,
            );
          },
        );
      },
    );
  }
}
