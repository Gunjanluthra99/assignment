import 'package:assignment/home/model/tournament_data.dart';
import 'package:flutter/foundation.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState();
}

class HomeSuccessState extends HomeState {
  final Data tournamentData;

  const HomeSuccessState({
    @required this.tournamentData,
  });
}

class HomeErrorState extends HomeState {
  final String error;

  const HomeErrorState({
    @required this.error,
  });
}