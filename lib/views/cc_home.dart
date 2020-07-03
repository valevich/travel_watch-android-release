import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency_base/currency_base_bloc.dart';
import '../bloc/currency_converter/currency_converter_bloc.dart';
import '../bloc/currency_rate/cc_bloc.dart';
import '../bloc/cc_delegate.dart';
import '../services/cc_repository.dart';
import 'cc_home_screen.dart';

class ConvertHome extends StatefulWidget {
  @override
  _ConvertHomeState createState() => _ConvertHomeState();
}

class _ConvertHomeState extends State<ConvertHome> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrencyRateBloc>(
          create: (_) => CurrencyRateBloc(Repository()),
        ),
        BlocProvider<CurrencyConverterBloc>(
          create: (_) => CurrencyConverterBloc(Repository()),
        ),
        BlocProvider<CurrencyBaseBloc>(
          create: (_) => CurrencyBaseBloc(Repository()),
        ),
      ],
      child: MaterialApp(
        title: "Currency Converter",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.purple),
        home: CurrencyHomeScreen(),
        // home: Scaffold(
        //   body: SplashScreen(
        //     splashAnimationDuration: 3,
        //     navigateAfterSeconds: HomeScreen(),
        //   ),
        // ),
      ),
    );
  }
}
