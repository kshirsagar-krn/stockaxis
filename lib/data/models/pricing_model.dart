// To parse this JSON data, do
//
//     final pricingModel = pricingModelFromJson(jsonString);

import 'dart:convert';

List<PricingModel> pricingModelFromJson(String str) => List<PricingModel>.from(json.decode(str).map((x) => PricingModel.fromJson(x)));

String pricingModelToJson(List<PricingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PricingModel {
  String? pCode;
  String? pDescription;
  String? pAmount;
  String? pDuration;
  String? pkgName;
  String? comboOffer;
  String? alertMsg;
  String? couponCode;
  int? srNo;
  String? pTotaAmount;

  PricingModel({
    this.pCode,
    this.pDescription,
    this.pAmount,
    this.pDuration,
    this.pkgName,
    this.comboOffer,
    this.alertMsg,
    this.couponCode,
    this.srNo,
    this.pTotaAmount,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
    pCode: json["PCode"],
    pDescription: json["PDescription"],
    pAmount: json["PAmount"],
    pDuration: json["PDuration"],
    pkgName: json["PKGName"],
    comboOffer: json["ComboOffer"],
    alertMsg: json["AlertMsg"],
    couponCode: json["CouponCode"],
    srNo: json["SrNo"],
    pTotaAmount: json["PTotaAmount"],
  );

  Map<String, dynamic> toJson() => {
    "PCode": pCode,
    "PDescription": pDescription,
    "PAmount": pAmount,
    "PDuration": pDuration,
    "PKGName": pkgName,
    "ComboOffer": comboOffer,
    "AlertMsg": alertMsg,
    "CouponCode": couponCode,
    "SrNo": srNo,
    "PTotaAmount": pTotaAmount,
  };
}
