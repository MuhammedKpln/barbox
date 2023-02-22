import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'router.controller.g.dart';

@LazySingleton()
class RouterServiceController = _RouterServiceBase
    with _$RouterServiceController;

abstract class _RouterServiceBase with Store {
  @observable
  RouteInformation? currentRoute;

  @action
  updateRoute(RouteInformation route) {
    currentRoute = route;
  }
}
