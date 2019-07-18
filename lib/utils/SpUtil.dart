import 'package:shared_preferences/shared_preferences.dart';

class SpUtil {

  static const String LOGIN_STATE = "login_state";
  static const String NICK_NAME = "nick_name";


  /// 保存字符串
  static Future setString(String key, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }

  /// 保存bool的值
  static Future setBool(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(key, value);
  }
}
