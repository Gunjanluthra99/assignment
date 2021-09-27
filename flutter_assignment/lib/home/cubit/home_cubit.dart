import 'dart:convert';

import 'package:assignment/home/cubit/home_repository.dart';
import 'package:assignment/home/cubit/home_state.dart';
import 'package:assignment/home/model/tournament_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;
  String cursor = "";

  HomeCubit(this.homeRepository) : super(HomeInitialState());

  getTournamentList() async {
    emit(HomeLoadingState());
    final response = await homeRepository.getTournamentList(cursor: cursor);
    if (response is Response) {
      if (response.statusCode == 200) {
        final tournamentData = await compute(parseData, response.body);
        if (tournamentData.success) {
          cursor = tournamentData.data.cursor;
          emit(HomeSuccessState(tournamentData: tournamentData.data));
        } else {
          emit(HomeErrorState(error: "UnKnown Error"));
        }
      } else {
        emit(HomeErrorState(error:  response.body));
      }
    } else if (response is String) {
      emit(HomeErrorState(error:  response));
    }
  }
}

TournamentData parseData(String responseBody) {
  return TournamentData.fromJson(jsonDecode(responseBody));
}
