
import 'package:shared_preferences/shared_preferences.dart';

class DeletePreferences{
  Future<void> deleteAccessToken() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('accessToken');
  }

  Future<void> deleteUserId() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userId');
  }
}