import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  static final HomeRepository _homeRepository = HomeRepository._();

  HomeRepository._();

  factory HomeRepository() {
    return _homeRepository;
  }

  Future<dynamic> getTournamentList({
    @required String cursor,
  }) async {
    try {
      if (cursor.isEmpty) {
        return await http.get(Uri.parse(
            'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all'));
      } else {
        return await http.get(Uri.parse(
            'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$cursor'));
      }
    } catch (e) {
      return e.toString();
    }
  }
}
