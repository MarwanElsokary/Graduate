import 'package:shared_preferences/shared_preferences.dart';
class cacheHelper{
  static SharedPreferences ? sp;
  static init() async {
    sp = await SharedPreferences.getInstance();
  }
  static Future<bool?> savedata ({
    required String key,
    required dynamic value,
  })async{
    if (value is String ) {
      print('save is working');
      return await sp?.setString( key, value);
    }
    print('save is working');
    if (value is int ) return await sp?.setInt( key, value);
    print('save is working');
    if (value is bool ) return await sp?.setBool( key, value);
    print('save is working');
    return await sp?.setDouble(key, value);
  }


  static dynamic getdata ({
    required String key,
  }) {
    print('get is working');
    return  sp?.get(key);
  }

  static Future<bool?> removedata({
    required String key,
  })async{
    return await sp?.remove(key);
  }

}

