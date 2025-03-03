import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/pricing_model.dart';
import '../../../data/repos/pricing_data_repo.dart';
part 'pricing_event.dart';
part 'pricing_state.dart';

class PricingBloc extends Bloc<PricingEvent, PricingState> {
  final PricingDataRepo? _pricingDataRepo;
  List<PricingModel> product1 = [];
  List<PricingModel> product2 = [];
  List<PricingModel> product3 = [];

  PricingModel? selectSmallCap;
  PricingModel? selectMidCap;
  PricingModel? selectLargeCap;
  PricingBloc(this._pricingDataRepo) : super(PricingInitial()) {
    /// 1st Product ----
    on<FetchLittleMasters>((event, emit) async {
      emit(PricingLoading());
      try {
        final response = await _pricingDataRepo!.getLittleMaster();
        final jsonString = _pricingDataRepo.extractJsonData(response);
        product1 = pricingModelFromJson(jsonEncode(jsonString["data"]));
        log(jsonEncode(jsonString["data"]), name: "API DATA");
        emit(PricingLoaded());
      } catch (e) {
        emit(PricingError("ERROR -- $e"));
      }
    });

    /// 2nd Product ----
    on<FetchEmergingMarketLeaders>((event, emit) async {
      emit(PricingLoading());
      try {
        final response = await _pricingDataRepo!.getEmergingMarket();
        final jsonString = _pricingDataRepo.extractJsonData(response);
        product2 = pricingModelFromJson(jsonEncode(jsonString["data"]));
        log("${jsonString["data"]}", name: "API DATA");
        emit(PricingLoaded());
      } catch (e) {
        emit(PricingError("ERROR -- $e"));
      }
    });

    /// 2rd Product ----
    on<FetchLargeCapFocus>((event, emit) async {
      emit(PricingLoading());
      try {
        final response = await _pricingDataRepo!.getLargeCapFocus();
        final jsonString = _pricingDataRepo.extractJsonData(response);
        product3 = pricingModelFromJson(jsonEncode(jsonString["data"]));
        log("${jsonString["data"]}", name: "API DATA");
        emit(PricingLoaded());
      } catch (e) {
        emit(PricingError("ERROR -- $e"));
      }
    });

    on<SelectSmallCap>((event, emit) {
      selectSmallCap = event.pricingModel;
      emit(PricingLoaded());
    });

    on<SelectMidCap>((event, emit) {
      selectMidCap = event.pricingModel;
      emit(PricingLoaded());
    });

    on<SelectLargeCap>((event, emit) {
      selectLargeCap = event.pricingModel;
      emit(PricingLoaded());
    });
  }
}
