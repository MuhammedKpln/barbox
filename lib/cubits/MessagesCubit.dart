import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spamify/cubits/AccountCubit.dart';
import 'package:spamify/cubits/repositories/MessagesRepository.dart';
import 'package:spamify/types/messages.dart';

class MessagesInitial {
  MessagesInitial();
}

class MessagesLoading extends MessagesInitial {
  MessagesLoading();
}

class MessagesLoaded extends MessagesInitial {
  final MessagesModel messages;
  MessagesLoaded(this.messages);
}

class MessagesNotLoaded extends MessagesInitial {
  MessagesNotLoaded();
}

class MessagesCubit extends Cubit<MessagesInitial> {
  MessagesRespository messagesRepository;
  AccountCubit accountCubit;
  MessagesCubit(this.messagesRepository, this.accountCubit)
      : super(MessagesInitial());

  Future<void> loadMessages() async {
    emit(MessagesLoading());

    final accountToken = (accountCubit.state as AccountLoaded).account.token;

    try {
      final response = await messagesRepository.getMessages(accountToken);
      emit(MessagesLoaded(response));
    } catch (e) {
      emit(MessagesNotLoaded());
    }
  }

  Future<bool> deleteMessage(String messageId) async {
    final accountToken = (accountCubit.state as AccountLoaded).account.token;

    try {
      await messagesRepository.deleteMessage(messageId, accountToken);

      final messagesFromRepo = (state as MessagesLoaded).messages;
      messagesFromRepo.hydraMember
          ?.removeWhere((message) => message.id == messageId);

      emit(MessagesLoaded(messagesFromRepo));

      return true;
    } catch (e) {
      throw Exception(e);
    }
  }
}
