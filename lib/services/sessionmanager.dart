import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  static const _storage = FlutterSecureStorage();

  static const _keyUsrId = 'user_id';
  static const _keyUsrRole = 'user_role';
  static const _keyToken = 'token';

  static Future<void> saveSession(String userId, String role, String token) async{
    await _storage.write(key: _keyUsrId, value: userId);
    await _storage.write(key: _keyUsrRole, value: role);
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<Map<String, String?>> getSession() async {
    final userId = await _storage.read(key: _keyUsrId);
    final role = await _storage.read(key: _keyUsrRole);
    final token = await _storage.read(key: _keyToken);

    return{
      'user_id' : userId,
      'user_role': role,
      'token': token
    };
  }

  static Future<void> clearSession() async {
    await _storage.deleteAll();
  }
}