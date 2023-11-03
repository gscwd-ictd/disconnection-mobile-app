import 'package:shared_preferences/shared_preferences.dart';

class StorePreferences {
  Future<void> storeAccessToken(String accessToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('accessToken', accessToken);
  }

  Future<void> storeUserId(int userId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('userId', userId);
  }

  Future<void> storeMembershipLevel(int membershipLevel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('membershipLevel', membershipLevel);
  }

  Future<void> storeBrigadahanFoundationFundsSettings(String brigadahanFoundationFundsCode, String brigadahanFoundationFundsRecipient, String brigadahanFoundationTenantCodeAlias) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('brigadahanFoundationFundsCode', brigadahanFoundationFundsCode);
    sharedPreferences.setString('brigadahanFoundationFundsRecipient', brigadahanFoundationFundsRecipient);
    sharedPreferences.setString('brigadahanFoundationTenantCodeAlias', brigadahanFoundationTenantCodeAlias);
  }

  Future<void> storeIsOfficer(bool isOfficer) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('isOfficer', isOfficer);
  }
}
