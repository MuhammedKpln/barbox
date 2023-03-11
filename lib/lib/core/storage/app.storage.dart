import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _AppKeys { didShowWelcomeSheet }

@LazySingleton()
class AppStorage {
  Future<void> setDidShowWelcomeSheet(bool value) async {
    final storage = await SharedPreferences.getInstance();

    await storage.setBool(_AppKeys.didShowWelcomeSheet.name, value);
  }

  Future<bool?> getDidShowWelcomeSheet() async {
    final storage = await SharedPreferences.getInstance();

    return storage.getBool(_AppKeys.didShowWelcomeSheet.name);
  }

  Future<void> clearAll() async {
    final storage = await SharedPreferences.getInstance();

    await storage.clear();
  }
}
