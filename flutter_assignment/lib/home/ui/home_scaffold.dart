import 'package:assignment/home/cubit/home_cubit.dart';
import 'package:assignment/home/cubit/home_repository.dart';
import 'package:assignment/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => HomeCubit(HomeRepository())..getTournamentList(),
        child: HomePage());

  }
}
