import 'package:equatable/equatable.dart';
import 'package:assignment/validation/fieldValidation.dart';
import 'package:formz/formz.dart';

class LoginState extends Equatable {
  const LoginState({
    this.username = const FieldValidation.pure(),
    this.password = const FieldValidation.pure(),
    this.status = FormzStatus.pure,
    this.exceptionError,
  });

  final FieldValidation username;
  final FieldValidation password;
  final FormzStatus status;
  final String exceptionError;

  @override
  List<Object> get props => [username, password, status, exceptionError];

  LoginState copyWith({
    FieldValidation username,
    FieldValidation password,
    FormzStatus status,
    String error,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      exceptionError: error ?? this.exceptionError,
    );
  }
}