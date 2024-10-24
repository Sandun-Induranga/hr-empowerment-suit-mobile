import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  Future<void> setToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', value);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}
