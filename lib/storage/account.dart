import 'dart:async';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:spamify/cubits/AccountCubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveAccount(Account account) async {
  final box = Hive.box('accountBox');
  box.put('account', account.toJson());
}

removeAccount() async {
  final box = Hive.box('accountBox');
  box.delete('account');
}

getAccount() {
  final box = Hive.box('accountBox');
  final _json = box.get('account');

  if (_json != null) {
    final account = Account.fromJson(json.decode(_json));

    return account;
  }

  return null;
}

Future<bool> isLoggedIn() async {
  final box = Hive.box('accountBox');
  final _json = box.get('account');

  if (_json != null) {
    return true;
  }

  return false;
}
