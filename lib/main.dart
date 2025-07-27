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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
