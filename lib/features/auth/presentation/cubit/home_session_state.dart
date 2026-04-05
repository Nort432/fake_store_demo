part of 'home_session_cubit.dart';

class HomeSessionState extends Equatable {
  const HomeSessionState({
    this.userName = '',
    this.isLoggingOut = false,
    this.didLogout = false,
  });

  final String userName;
  final bool isLoggingOut;
  final bool didLogout;

  HomeSessionState copyWith({
    String? userName,
    bool? isLoggingOut,
    bool? didLogout,
  }) {
    return HomeSessionState(
      userName: userName ?? this.userName,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      didLogout: didLogout ?? this.didLogout,
    );
  }

  @override
  List<Object?> get props => [userName, isLoggingOut, didLogout];
}
