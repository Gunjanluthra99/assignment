import 'package:assignment/home/cubit/home_cubit.dart';
import 'package:assignment/home/cubit/home_state.dart';
import 'package:assignment/home/model/tournament_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  final List<Tournaments> tournaments = [];
  final ScrollController _scrollController = ScrollController();
  Data tournamentData;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: ScrollAppBar(
          controller: _scrollController, // Note the controller here
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Center(
              child: Text(AppLocalizations.of(context).headerName, style: TextStyle(color: Colors.black))),
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeErrorState) {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.error),
              ));
            }
            return;
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              isLoading = true;
            } else if (state is HomeSuccessState) {
              isLoading = false;
              tournamentData = state.tournamentData;
              tournaments.addAll(state.tournamentData.tournaments);
            }
            return Snap(
                controller: _scrollController.appBar,
                child: SingleChildScrollView(
                    controller: _scrollController
                      ..addListener(() {
                        if (_scrollController.offset ==
                                _scrollController.position.maxScrollExtent &&
                            !tournamentData.isLastBatch) {
                          context.read<HomeCubit>().getTournamentList();
                        }
                      }),
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 85.0,
                                    height: 85.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(
                                                "https://i.imgur.com/BoN9kdC.png")))),
                                SizedBox(width: 15),
                                Column(
                                  children: [
                                    Text("Simon Baker", textScaleFactor: 1.5),
                                    SizedBox(height: 20),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 8, 20, 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.blue,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Center(
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '2250 ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.blue)),
                                              TextSpan(
                                                  text: 'Elo rating',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Statics(),
                            SizedBox(height: 20),
                            Text(AppLocalizations.of(context).recommandedTxt, textScaleFactor: 1.5),
                            SizedBox(height: 20),
                            ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  ListItem(tournaments[index]),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 20),
                              itemCount: tournaments.length,
                            ),
                            isLoading
                                ? Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CircularProgressIndicator())
                                : Container()
                          ],
                        ))));
          },
        ));
  }
}

class Statics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                        height: 80,
                        color: Colors.orange,
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("34",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              Text("Tournaments Played",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ]))),
                Expanded(
                    child: Container(
                        height: 80,
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        color: Colors.purple,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("09",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              Text("Tournaments won",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ]))),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        height: 80,
                        color: Colors.redAccent,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("26%",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              Text("Winning Percentage",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12)),
                            ])))
              ],
            )));
  }
}

class ListItem extends StatelessWidget {
  Tournaments tournament;

  ListItem(this.tournament);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      tournament.coverUrl,
                      fit: BoxFit.cover,
                    )),
                Padding(
                    child: Text(tournament.name,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    padding: EdgeInsets.fromLTRB(15, 10, 00, 0)),
                Padding(
                    child: Text(tournament.gameName,
                        style: TextStyle(color: Colors.black, fontSize: 14)),
                    padding: EdgeInsets.fromLTRB(15, 10, 00, 10)),
              ]),
        ));
  }
}
