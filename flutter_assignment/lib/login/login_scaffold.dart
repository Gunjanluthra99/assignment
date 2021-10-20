import 'package:assignment/authentication/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment/authentication/authentication_cubit.dart';

import '../login/cubit/login_cubit.dart';
import 'login_form.dart';

class LoginScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authCubit = BlocProvider.of<AuthenticationCubit>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Login'),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => LoginCubit(authCubit,authService),
          child: LoginForm(),
        ),
      ),
    );
  }
}
