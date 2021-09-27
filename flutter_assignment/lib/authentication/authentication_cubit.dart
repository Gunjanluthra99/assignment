import 'package:assignment/authentication/authentication_state.dart';
import 'package:assignment/authentication/service/auth_service.dart';
import 'package:assignment/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationService _authService;
  SharedPreferences prefs;

  AuthenticationCubit(this._authService)
      : super(AuthenticationInitial());

  Future<Stream<AuthenticationState>> initializeApp() async {
    emit(AuthenticationLoading());
    try {
      final currentUser = await _authService.getCurrentUser();
      if (currentUser != null) {
        emit(Authenticated(user: currentUser));
      } else {
        emit(UnAuthenticated());
      }
    } catch (e) {
      emit(AuthenticationFailure(
          message: e.message ?? 'An unknown error occurred'));
    }
  }

  void loggedIn(User user) async
  {
   emit(Authenticated(user: user));
  }

  Future<void> logout() async {
    await _authService.signOut();
    emit(UnAuthenticated());
}
}
