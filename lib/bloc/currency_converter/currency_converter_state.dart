import 'package:equatable/equatable.dart';
import '../../models/currency_converter_model.dart';

abstract class CurrencyConverterState extends Equatable {
  const CurrencyConverterState();
}

class CurrencyConverterLoading extends CurrencyConverterState {
  @override
  List<Object> get props => [];
}

class CurrencyConverterLoaded extends CurrencyConverterState {
  final CurrencyConverterModel currencyConverterData;

  CurrencyConverterLoaded(this.currencyConverterData);

  @override
  List<Object> get props => [currencyConverterData];
}

class CurrencyConverterFailure extends CurrencyConverterState {
  final String errorMessage;

  CurrencyConverterFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
