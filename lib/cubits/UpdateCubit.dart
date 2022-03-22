import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spamify/cubits/repositories/UpdatesRepository.dart';

import '../types/updates.dart';

class UpdatesState {}

class UpdatesLoading extends UpdatesState {
  UpdatesLoading();
}

class UpdatesLoaded extends UpdatesState {
  final UpdateModel updates;
  UpdatesLoaded(this.updates);
}

class UpdatesError extends UpdatesState {
  final String error;
  UpdatesError(this.error);
}

class UpdatesCubit extends Cubit<UpdatesState> {
  final UpdatesRepository updatesRepository;
  UpdatesCubit(this.updatesRepository) : super(UpdatesState());

  Future<void> checkForUpdates() async {
    emit(UpdatesLoading());

    try {
      final updates = await updatesRepository.checkForUpdates();

      emit(UpdatesLoaded(updates));
    } catch (e) {
      emit(UpdatesError(e.toString()));
    }
  }
}
