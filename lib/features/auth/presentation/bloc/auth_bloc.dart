import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pathguide_app/core/data/models.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      emit(AuthUnauthenticated());
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock login logic: using the provided email to determine role, but keeping the name dynamic
      final role = event.role == 'student' ? UserRole.student : UserRole.recruiter;
      final name = event.email.split('@').first; // Just a simple mock name from email
      
      emit(AuthAuthenticated(UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        name: name, 
        email: event.email, 
        role: role
      )));
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthAuthenticated(UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(), 
        name: event.name, 
        email: event.email, 
        role: event.role
      )));
    });

    on<LogoutRequested>((event, emit) {
      emit(AuthUnauthenticated());
    });
  }
}
