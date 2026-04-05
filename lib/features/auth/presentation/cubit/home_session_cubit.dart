import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/auth_repository.dart';

part 'home_session_state.dart';

@injectable
class HomeSessionCubit extends Cubit<HomeSessionState> {
  HomeSessionCubit(this._authRepository) : super(const HomeSessionState());

  final AuthRepository _authRepository;

  void restoreUserName({String? fallbackUserName}) {
    final saved = _authRepository.getSavedUserName();
    final resolved = (saved ?? fallbackUserName ?? '').trim();
    emit(state.copyWith(userName: resolved));
  }

  Future<void> logout() async {
    if (state.isLoggingOut) {
      return;
    }

    emit(state.copyWith(isLoggingOut: true));
    await _authRepository.logout();
    emit(state.copyWith(isLoggingOut: false, didLogout: true, userName: ''));
  }

  void resetLogoutFlag() {
    if (!state.didLogout) {
      return;
    }

    emit(state.copyWith(didLogout: false));
  }
}
