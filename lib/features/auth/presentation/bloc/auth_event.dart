part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final String role;

  const LoginRequested(this.email, this.password, this.role);

  @override
  List<Object?> get props => [email, password, role];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final UserRole role;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [name, email, password, role];
}

class LogoutRequested extends AuthEvent {}
