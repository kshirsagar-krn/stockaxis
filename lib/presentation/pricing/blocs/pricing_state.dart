part of 'pricing_bloc.dart';

abstract class PricingState {}

final class PricingInitial extends PricingState {}

final class PricingLoading extends PricingState {}

final class PricingLoaded extends PricingState {}

final class PricingError extends PricingState {
  final String errorMsg;
  PricingError(this.errorMsg);
}
