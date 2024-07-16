import 'package:shared_preferences/shared_preferences.dart';

class SaveDataWithLocalStorage {
 static saveData(String key, data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   return prefs.getString(key);
  }

 static Future clearData()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
