import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // ini key untuk simpan ke shared preferences
  static const String _keyPrefsForLoggedIn = 'is_logged_in';
  static const String _keyPrefsForEmail = 'email';

  // akun demo, static untuk login
  // format key: value
  static const Map<String, String> _validUsers = {
    'admin@gmail.com': 'admin'
  };

  // func login
  static Future<bool> processLogin(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    if (_validUsers.containsKey(email) && _validUsers[email] == password) {
      await prefs.setBool(_keyPrefsForLoggedIn, true);
      await prefs.setString(_keyPrefsForEmail, email);
      return true;
    }
    return false;
  }

  // logout
  static Future<void> processLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyPrefsForLoggedIn, false);
    await prefs.setString(_keyPrefsForEmail, 'email');
  }

  // check is logged in 
  static Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getBool(_keyPrefsForLoggedIn) != null){
      if(prefs.getBool(_keyPrefsForLoggedIn) == true){
        return true; 
      }
    }
    return false;
  }
}
