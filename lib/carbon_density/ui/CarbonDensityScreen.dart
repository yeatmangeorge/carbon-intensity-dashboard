import 'package:carbon_intensity_dashboard/carbon_density/business_logic/carbon_density_bloc.dart';
import 'package:carbon_intensity_dashboard/core/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarbonDensityScreen extends StatelessWidget {
  const CarbonDensityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.carbonIntensity),
      ),
      body: BlocConsumer<CarbonDensityBloc, CarbonDensityState>(
        listener: (context, state) {},
        builder: (context, state) {
          switch (state) {
            case CarbonDensityInitial():
              return Center(
                child: TextButton(
                  onPressed: () {
                    context.read<CarbonDensityBloc>().add(
                      StartPollingCarbonDensityEvent(),
                    );
                  },
                  child: Text(Strings.getCarbonIntensity),
                ),
              );
            case CarbonDensityLoading():
              return Center(child: CircularProgressIndicator());
            case CarbonDensityLoaded():
              return Column(
                children: [
                  Text(Strings.carbonIntensity),
                  Text(
                    Strings.currentCarbonIntensity(
                      state.currentIntensity.actual ??
                          state.currentIntensity.forecast,
                    ),
                  ),
                ],
              );
            case CarbonDensityError():
              return Center(
                child: TextButton(
                  onPressed: () {
                    context.read<CarbonDensityBloc>().add(
                      StartPollingCarbonDensityEvent(),
                    );
                  },
                  child: Text(state.failure.toHumanString()),
                ),
              );
          }
        },
      ),
    );
  }
}
