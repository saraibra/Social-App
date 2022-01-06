  
import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static late SharedPreferences sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static putData(
      {required String key, required dynamic value}) async {
     await sharedPreferences.setString(key, value);
  }
    static String? getData(
      {required String key})  {
    return  sharedPreferences.getString(key);
  }}