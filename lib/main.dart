import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stockaxis/core/network/api_client.dart';
import 'package:stockaxis/data/repos/pricing_data_repo.dart';
import 'package:stockaxis/presentation/pricing/blocs/pricing_bloc.dart';

import 'presentation/pricing/pages/pricing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> PricingBloc(PricingDataRepo(apiClient: ApiClient())))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Stock Axis',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const  PricingScreen(),
      ),
    );
  }
}
