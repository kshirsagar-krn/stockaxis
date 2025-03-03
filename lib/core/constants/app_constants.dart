class AppConstants {
  static const String _baseUrl = 'https://www.stockaxis.com';
  static  String get getBaseUrl => _baseUrl;

  //API ENDPOINT --
  static const String getLittleMasters = '/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=LM';
  static const String getEmergingMarketLeaders = '/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=EML';
  static const String getLargeCapFocus = '/webservices/android/index.aspx?action=search&activity=PricingV2&CID=984493&PKGName=LCF';
}