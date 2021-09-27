import 'package:assignment/home/ui/home_scaffold.dart';
import 'package:assignment/validation/fieldValidation.dart';
import 'package:assignment/widget/auth_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../login/cubit/login_cubit.dart';
import '../login/cubit/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.exceptionError),
              backgroundColor: Theme.of(context).errorColor,
            ));
          } else if (state.status.isSubmissionSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScaffold()),
            );
          }
        },
        builder: (context, state) => Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
                child: Stack(
              children: [
               SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _Logo(),
                          _UsernameInputField(),
                          _PasswordInputField(),
                          _SubmitButton(),
                        ],
                      ),
                    ),
                state.status.isSubmissionInProgress
                    ? Positioned(
                        child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(),
              ],
            )));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Image.asset('assets/images/game_tv.jpg'),
    );
  }
}

class _UsernameInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        print(state.username.error);
        return AuthTextField(
          hint: 'Username',
          keyboardType: TextInputType.name,
          error: state.username.error.name,
          onChanged: (username) =>
              context.read<LoginCubit>().usernameChanged(username),
        );
      },
    );
  }
}

class _PasswordInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AuthTextField(
          padding: EdgeInsets.symmetric(vertical: 20),
          hint: 'Password',
          isPasswordField: true,
          keyboardType: TextInputType.text,
          error: state.password.error.name,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: CupertinoButton(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text('Submit'),
            disabledColor: Colors.blueAccent.withOpacity(0.6),
            color: Colors.blueAccent,
            onPressed: state.status.isValidated
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : null,
          ),
        );
      },
    );
  }
}
