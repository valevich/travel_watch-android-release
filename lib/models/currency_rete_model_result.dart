library currency_rete_model_result;

import 'dart:convert';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import '../models/cc_rates.dart';
import '../models/cc_serializers.dart';

part 'currency_rete_model_result.g.dart';

abstract class CurrencyRateModelResult
    implements Built<CurrencyRateModelResult, CurrencyRateModelResultBuilder> {
  //Fields
  String get base;
  String get date;
  Rates get rates;
  CurrencyRateModelResult._();
  factory CurrencyRateModelResult([updates(CurrencyRateModelResultBuilder b)]) =
      _$CurrencyRateModelResult;

  static Serializer<CurrencyRateModelResult> get serializer =>
      _$currencyRateModelResultSerializer;
  String toJson() {
    return json.encode(
        serializers.serializeWith(CurrencyRateModelResult.serializer, this));
  }

  static CurrencyRateModelResult fromJson(String jsonString) {
    return serializers.deserializeWith(
        CurrencyRateModelResult.serializer, json.decode(jsonString));
  }
}
