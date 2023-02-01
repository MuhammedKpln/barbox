import 'package:mobx/mobx.dart';
part 'messages.controller.g.dart';

class MessagesController = _MessagesControllerBase with _$MessagesController;

abstract class _MessagesControllerBase with Store {
  @observable
  bool isLoading = true;
}
