import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import '../../services/cc_exceptions.dart';
import '../../services/cc_repository.dart';
import './cc_bloc.dart';

class CurrencyRateBloc extends Bloc<CurrencyRateEvent, CurrencyRateState> {
  final Repository _repository;
  CurrencyRateBloc(Repository repository)
      : assert(repository != null),
        _repository = repository;
  @override
  CurrencyRateState get initialState => CurrencyRateLoading();

  @override
  Stream<CurrencyRateState> mapEventToState(
    CurrencyRateEvent event,
  ) async* {
    if (event is GetCurrencyRate) {
      yield* _mapOfGetCurrencyRate();
    }
  }

  Stream<CurrencyRateState> _mapOfGetCurrencyRate() async* {
    yield CurrencyRateLoading();
    try {
      final response = await _repository.getCurrencyRate();
      yield CurrencyRateLoaded(response);
    } on ServerException catch (e) {
      yield CurrencyRateFailure(e.message);
    } on SocketException catch (e) {
      print("${e.message},${e.address},${e.port}");
    }
  }
}
