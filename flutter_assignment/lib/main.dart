import 'package:assignment/authentication/authentication_cubit.dart';
import 'package:assignment/authentication/authentication_state.dart';
import 'package:assignment/authentication/service/auth_service.dart';
import 'package:assignment/home/ui/home_scaffold.dart';
import 'package:assignment/login/login_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/l10n.dart';


void main() => runApp(
  // Injects the Authentication service
    RepositoryProvider<AuthenticationService>(
      create: (context) {
        return FakeAuthenticationService();
      },
      // Injects the Authentication Cubit
      child: BlocProvider<AuthenticationCubit>(
        create: (context) {
          final authService = RepositoryProvider.of<AuthenticationService>(context);
          return AuthenticationCubit(authService)..initializeApp();
        },
        child: MyApp(),
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      home: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            // show home page
            return HomeScaffold(
            );
          }
          // otherwise show login page
          return LoginScaffold();
        },
      ),
    );
  }
}

