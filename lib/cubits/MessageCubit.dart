import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spamify/cubits/AccountCubit.dart';
import 'package:spamify/cubits/repositories/MessageRepository.dart';
import 'package:spamify/types/message.dart';

class MessageSingleInitial {
  const MessageSingleInitial();
}

class MessageSingleLoading extends MessageSingleInitial {
  const MessageSingleLoading();
}

class MessageSingleCompleted extends MessageSingleInitial {
  final MessageSingle response;

  const MessageSingleCompleted(this.response);
}

class MessageCubit extends Cubit<MessageSingleInitial> {
  final AccountCubit currentAccountCubit;
  final MessageRepository messageRepository;

  MessageCubit(this.currentAccountCubit, this.messageRepository)
      : super(const MessageSingleInitial());

  Future<void> getMessage(String messageId) async {
    emit(const MessageSingleLoading());
    try {
      final accountToken =
          (currentAccountCubit.state as AccountLoaded).account.token;

      final response =
          await messageRepository.getMessage(messageId, accountToken);

      final message = response;
      emit(MessageSingleCompleted(message));
    } catch (e) {
      emit(const MessageSingleLoading());
    }
  }
}
