part of 'pricing_bloc.dart';

abstract class PricingEvent {}

class FetchLittleMasters extends PricingEvent {}

class FetchEmergingMarketLeaders extends PricingEvent {}

class FetchLargeCapFocus extends PricingEvent {}

class SelectSmallCap extends PricingEvent {
 final PricingModel? pricingModel;
  SelectSmallCap(this.pricingModel);
}

class SelectMidCap extends PricingEvent {
  final PricingModel? pricingModel;

  SelectMidCap(this.pricingModel);
}

class SelectLargeCap extends PricingEvent {
  final PricingModel? pricingModel;

  SelectLargeCap(this.pricingModel);
}


