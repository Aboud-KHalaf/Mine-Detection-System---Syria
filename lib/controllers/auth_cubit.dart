import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/auth_service.dart';
import 'auth_state.dart';
import '../core/exceptions.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;

  AuthCubit(this.authService) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      final token = await authService.getToken();
      if (token != null && token.isNotEmpty) {
        emit(AuthAuthenticated(token));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      final tokenModel = await authService.login(username, password);
      emit(AuthAuthenticated(tokenModel.token));
    } on ApiException catch (e) {
      emit(AuthError(e.message));
    } on OfflineException catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError('An unexpected error occurred.'));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authService.logout();
    } catch (e) {
      // Best effort logout.
    }
    emit(AuthUnauthenticated());
  }
}
