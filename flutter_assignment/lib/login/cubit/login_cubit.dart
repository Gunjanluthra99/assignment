import 'package:assignment/authentication/service/auth_service.dart';
import 'package:assignment/validation/fieldValidation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment/authentication/authentication_cubit.dart';
import 'package:formz/formz.dart';
import '../cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationCubit _authenticationCubit;
  final AuthenticationService _authenticationService;

  LoginCubit(this._authenticationCubit, this._authenticationService)
      : super(const LoginState());

  void usernameChanged(String value) {
    final name = FieldValidation.dirty(value);
    emit(state.copyWith(
      username: name,
      status: Formz.validate([name, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = FieldValidation.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.username, password]),
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final user = await _authenticationService.signIn(state.username.value, state.password.value);
      if (user != null) {
        _authenticationCubit.loggedIn(user);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(
            status: FormzStatus.submissionFailure, error: "Unknown Error"));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, error: e.toString() ?? 'An unknown error occured'));
    }
  }
}
