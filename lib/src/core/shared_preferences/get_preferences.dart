import 'package:shared_preferences/shared_preferences.dart';

class GetPreferences {
  Future<String?> getStoredAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString('accessToken');

    return accessToken;
  }

  Future<int?> getStoredUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? userId = sharedPreferences.getInt('userId');

    return userId;
  }

  Future<int?> getStoredMembershipLevel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? membershipLevel = sharedPreferences.getInt('membershipLevel');

    return membershipLevel;
  }

  Future<Map<String, dynamic>> getBrigadahanFoundationFundsSettings() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? brigadahanFoundationFundsCode = sharedPreferences.getString('brigadahanFoundationFundsCode');
    String? brigadahanFoundationFundsRecipient = sharedPreferences.getString('brigadahanFoundationFundsRecipient');
    String? brigadahanFoundationTenantCodeAlias = sharedPreferences.getString('brigadahanFoundationTenantCodeAlias');

    Map<String, dynamic> result = {
      "brigadahanFoundationFundsCode": brigadahanFoundationFundsCode,
      "brigadahanFoundationFundsRecipient": brigadahanFoundationFundsRecipient,
      "brigadahanFoundationTenantCodeAlias": brigadahanFoundationTenantCodeAlias
    };

    // BrigadahanFundsCode.brigadahanFundsCode = brigadahanFoundationFundsCode;
    // BrigadahanFundsCode.brigadahanFundsRecipient = brigadahanFoundationFundsRecipient;
    // BrigadahanFundsCode.brigadahanFoundationTenantCodeAlias = brigadahanFoundationTenantCodeAlias;

    return result;
  }

  Future<bool> getIsOfficer() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    bool? isOfficer = sharedPreferences.getBool('isOfficer');

    if(isOfficer == null){
      return false;
    }

    return isOfficer;
  }
}

class SharedPreferencesManager{
  static const String freshInstallKey = "is_freshly_installed";
  // static const String fresh_install_key = null;
  SharedPreferencesManager();

  Future<bool> isFreshInstalled() async{
    var pref = await SharedPreferences.getInstance();

    bool? isFreshlyInstalled = pref.getBool(freshInstallKey);

    if(isFreshlyInstalled == null){
      return await pref.setBool(freshInstallKey, false);
    }
    else{
      return isFreshlyInstalled;
    }
  }
}