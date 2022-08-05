import 'package:flutter/material.dart';
import '../classes/app_state.dart';
import '../classes/charts.dart';
import '../classes/database.dart';

class JournalStats extends StatefulWidget {
  const JournalStats({Key? key}) : super(key: key);

  @override
  State<JournalStats> createState() => _JournalStatsState();
}

class _JournalStatsState extends State<JournalStats> {
  late AppState appState;
  late Database database;
  late Future<List<Journal>> statsData;
  int totalNumberOfJournals = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = AppState.of(context)!;
    GetData.getTotalJournalsCount().then((value) => totalNumberOfJournals = value);
    statsData = GetData.loadJournals(appState);
  }

  Widget buildStatsWidget(AsyncSnapshot snapshot) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 400.0,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Mood", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MoodVerticalBarWidget(
                    moodIcon: appState.moods.mood != 'ALL' ? appState.moods.mood.toLowerCase() : 'lol',
                    numberOfMoods: appState.moods.mood != 'ALL' ? snapshot.data.length : totalNumberOfJournals,
                    totalNumberOfJournals: totalNumberOfJournals,
                  ),
                  const Padding(padding: EdgeInsets.only(left: 48.0)),
                  MoodVerticalBarWidget(
                    moodIcon: 'book',
                    numberOfMoods: totalNumberOfJournals,
                    totalNumberOfJournals: totalNumberOfJournals,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: statsData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return !snapshot.hasData
                ? const Center(child: CircularProgressIndicator(),)
                : buildStatsWidget(snapshot);
          },
        ),
      ),
    );
  }
}
