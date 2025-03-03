
import 'dart:convert';

import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/api_client.dart';

class PricingDataRepo {
  final ApiClient apiClient;
  PricingDataRepo({required this.apiClient});

  /// Get Little Master <~>
  Future<Response> getLittleMaster() async {
    final response = await apiClient.getData(AppConstants.getLittleMasters);
    return response;
  }

  /// Get EmergingMarket <~>
  Future<Response> getEmergingMarket() async {
    final response =
        await apiClient.getData(AppConstants.getEmergingMarketLeaders);
    return response;
  }

  /// Get LargeCapFocus <~>
  Future<Response> getLargeCapFocus() async {
    final response = await apiClient.getData(AppConstants.getLargeCapFocus);
    return response;
  }

  Map<String, dynamic> extractJsonData(Response response) {
    try {
      // Find the JSON start and end position
      int jsonStartIndex = response.data.indexOf('{"data":');
      int jsonEndIndex = response.data.lastIndexOf(']}') + 2; // Ensure it includes the closing bracket

      if (jsonStartIndex != -1 && jsonEndIndex != -1) {
        String jsonString = response.data.substring(jsonStartIndex, jsonEndIndex);
        // convert jsonString to json data
        Map<String, dynamic> jsonData = json.decode(jsonString);
        return jsonData;
      }
    } catch (e) {
     throw  Exception("Error extracting JSON: $e");
    }
    return {};
  }
}
