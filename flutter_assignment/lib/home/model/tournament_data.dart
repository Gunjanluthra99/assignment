class TournamentData {
  int code;
  Data data;
  bool success;

  TournamentData({this.code, this.data, this.success});

  TournamentData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  String cursor;
  List<Tournaments> tournaments=[];
  bool isLastBatch;

  Data({this.cursor, this.tournaments, this.isLastBatch});

  Data.fromJson(Map<String, dynamic> json) {
    cursor = json['cursor'];
    if (json['tournaments'] != null) {
      tournaments = [];
      json['tournaments'].forEach((v) {
        tournaments.add(new Tournaments.fromJson(v));
      });
    }
    isLastBatch = json['is_last_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cursor'] = this.cursor;
    if (this.tournaments != null) {
      data['tournaments'] = this.tournaments.map((v) => v.toJson()).toList();
    }
    data['is_last_batch'] = this.isLastBatch;
    return data;
  }
}

class Tournaments {
  String name;
  String coverUrl;
  String gameName;

  Tournaments({
    this.name,
    this.coverUrl,
    this.gameName,
  });

  Tournaments.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    gameName = json['game_name'];
    coverUrl = json['cover_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cover_url'] = this.coverUrl;
    data['game_name'] = this.gameName;

    return data;
  }
}
