import 'package:barbox/core/auth/controllers/auth.controller.dart';
import 'package:barbox/core/constants/theme.dart';
import 'package:barbox/core/exstensions/toast.extension.dart';
import 'package:barbox/features/home/repositories/account.repository.dart';
import 'package:barbox/types/domains.dart';
import 'package:barbox/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'new_account.controller.g.dart';

@LazySingleton(dispose: disposeNewAccountController)
class NewAccountController = _NewAccountControllerBase
    with _$NewAccountController;

abstract class _NewAccountControllerBase with Store {
  _NewAccountControllerBase(
      this._accountRepository, this._toastService, this._authController);

  final AccountRepository _accountRepository;
  final Toast _toastService;
  final AuthController _authController;

  final controllerUsername = TextEditingController();

  final controllerPassword = TextEditingController();

  @observable
  ObservableFuture<DomainsModel?> domains = ObservableFuture.value(null);

  @observable
  bool obsecuredText = true;

  @observable
  String? username;

  @observable
  String? password;

  @observable
  String? selectedDomain;

  @computed
  bool get isFormValid => username != null && password != null;

  @action
  Future<void> init() async {
    domains = ObservableFuture(_accountRepository.fetchDomains());

    domains.then((value) {
      selectedDomain = domains.value?.hydraMember[0].domain;
    });
  }

  generateRandomPassword() {
    controllerPassword.text = generateRandomString(10);
  }

  @action
  toggleObsecureText() {
    obsecuredText = !obsecuredText;
  }

  Future<void> createAddress(BuildContext context) async {
    final isValid = _validateForm();

    if (!isValid) {
      _toastService.showToast(
          "For security purposes, please make sure that both username and password fields are non-empty.",
          toastType: ToastType.error);

      return;
    }

    final address = "$username@$selectedDomain";

    final _account = await _accountRepository.createAccount(address, password!);

    final token = await _accountRepository.login(_account.address, password!);

    await _authController.login(
        acc: _account, password: password!, token: token.token);

    _toastService.showToast("Account created successfully",
        toastType: ToastType.success);

    Navigator.of(context).pop();
  }

  @action
  bool _validateForm() {
    final usernameValidator = validateUsername();
    final passwordValidator = validatePassword();

    return usernameValidator && passwordValidator ? true : false;
  }

  @action
  bool validateUsername() {
    if (username != null && username!.length > 5) {
      return true;
    }

    return false;
  }

  @action
  bool validatePassword() {
    if (password != null) {
      return true;
    }

    return false;
  }

  @action
  updateUsername(String value) {
    username = value;
  }

  @action
  updatePassword(String value) {
    password = value;
  }

  @action
  updateDomain(String? value) {
    selectedDomain = value;
  }

  void dispose() {}
}

disposeNewAccountController(NewAccountController instance) {
  instance.dispose();
}
