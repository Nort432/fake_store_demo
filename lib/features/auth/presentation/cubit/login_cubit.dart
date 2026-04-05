import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/auth_repository.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState.initial());

  final AuthRepository _authRepository;

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading, errorMessage: ''));

    try {
      await _authRepository.login(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.success));
    } on AuthFailure catch (error) {
      emit(
        state.copyWith(status: LoginStatus.error, errorMessage: error.message),
      );
    }
  }

  void clearError() {
    if (state.errorMessage.isEmpty) {
      return;
    }

    emit(state.copyWith(errorMessage: ''));
  }
}

enum LoginStatus { initial, loading, success, error }

class LoginState extends Equatable {
  const LoginState({required this.status, required this.errorMessage});

  const LoginState.initial() : status = LoginStatus.initial, errorMessage = '';

  final LoginStatus status;
  final String errorMessage;

  LoginState copyWith({LoginStatus? status, String? errorMessage}) {
    return LoginState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, errorMessage];
}
