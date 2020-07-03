import 'package:equatable/equatable.dart';
import '../../models/cc_rates.dart';

abstract class CurrencyRateState extends Equatable {
  const CurrencyRateState();
}

class CurrencyRateLoading extends CurrencyRateState {
  @override
  List<Object> get props => [];
}

class CurrencyRateLoaded extends CurrencyRateState {
  final Rates rates;

  CurrencyRateLoaded(this.rates);

  @override
  List<Object> get props => [rates];
}

class CurrencyRateFailure extends CurrencyRateState {
  final String errorMessage;

  CurrencyRateFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
