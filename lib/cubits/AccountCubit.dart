import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spamify/cubits/repositories/AccountsRespository.dart';
import 'package:spamify/storage/account.dart';
import 'package:spamify/storage/messagesStorage.dart';

import '../utils.dart';

class AccountInitial {
  AccountInitial();
}

class AccountLoading extends AccountInitial {
  AccountLoading();
}

class AccountLoaded extends AccountInitial {
  final Account account;
  AccountLoaded(this.account);
}

class AccountError extends AccountInitial {
  final String error;
  AccountError(this.error);
}

class Account {
  String adress = "";
  String password = "";
  String token = "";

  Account(this.adress, this.password, this.token);

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        json['adress'],
        json['password'],
        json['token'],
      );

  String toJson() {
    return json.encode({
      "adress": adress,
      "password": password,
      "token": token,
    });
  }
}

class AccountCubit extends Cubit<AccountInitial> {
  final AccountRepository accountRepository;
  AccountCubit(this.accountRepository) : super(AccountInitial());

  void loadAccount() {
    emit(AccountLoading());
    try {
      final account = getAccount();

      if (account != null) {
        emit(AccountLoaded(account));
      } else {
        emit(AccountError("No account found"));
      }
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> login(String adress, String password) async {
    emit(AccountLoading());
    try {
      final account = await accountRepository.login(adress, password);
      emit(AccountLoaded(Account(adress, password, account.token)));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> fetchNewAdress() async {
    emit(AccountLoading());
    try {
      final password = generateRandomString(10);

      final domains = await accountRepository.fetchDomains();
      final account = await accountRepository.createAccount(
          domains.hydraMember?[0].domain ?? "", password);

      final token =
          await accountRepository.login(account.address ?? "", password);

      final _account = Account(account.address ?? "", password, token.token);

      await saveAccount(_account);
      emit(AccountLoaded(_account));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AccountLoading());
    try {
      await removeAccount();
      Hive.box(accountBox).clear();
      Hive.box(messagesBox).clear();

      emit(AccountInitial());
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }
}
