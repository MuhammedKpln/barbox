import 'dart:math';

import 'package:isar/isar.dart';

part 'local_account.db.g.dart';

@collection
class LocalAccount {
  LocalAccount(
      {required this.address,
      required this.password,
      required this.token,
      required this.accountId});

  int get id => Random().nextInt(999999);

  final String address;

  final String password;

  final String token;

  final String accountId;
}
