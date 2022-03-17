import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:spamify/cubits/AccountCubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

saveAccount(Account account) async {
  final json = account.toJson();

  final storage = await SharedPreferences.getInstance();

  await storage.setString('account', json);
}

removeAccount() async {
  final storage = await SharedPreferences.getInstance();

  await storage.remove('account');
}

getAccount() async {
  final storage = await SharedPreferences.getInstance();
  final _json = storage.getString('account');

  if (_json != null) {
    final account = Account.fromJson(json.decode(_json));

    return account;
  }

  return null;
}
