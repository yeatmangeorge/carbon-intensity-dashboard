import 'package:carbon_intensity_dashboard/carbon_density/business_logic/carbon_density_bloc.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/repository/carbon_density_repository.dart';
import 'package:carbon_intensity_dashboard/carbon_density/data/source/carbon_density_api/carbon_density_api_datasource.dart';
import 'package:carbon_intensity_dashboard/carbon_density/ui/CarbonDensityScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'carbon_density/data/repository/standard_carbon_density_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dio dio = Dio();
    CarbonDensityApiDatasource carbonDensityApiDatasource =
        CarbonDensityApiDatasource(dio);
    CarbonDensityRepository carbonDensityRepository =
        StandardCarbonDensityRepository(
          carbonDensityApiDatasource: carbonDensityApiDatasource,
        );

    return BlocProvider(
      create: (context) => CarbonDensityBloc(carbonDensityRepository),
      child: MaterialApp(
        title: 'Carbon Intensity',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const CarbonDensityScreen(),
      ),
    );
  }
}