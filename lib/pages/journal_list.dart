import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../classes/app_state.dart';
import '../classes/database.dart';

class JournalList extends StatefulWidget {
  const JournalList({Key? key}) : super(key: key);

  @override
  State<JournalList> createState() => _JournalListState();
}

class _JournalListState extends State<JournalList> {
  late AppState appState;
  late Future<List<Journal>> journalsListData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = AppState.of(context)!;
    journalsListData = GetData.loadJournals(appState);
  }

  // Build the ListView with Separator
  Widget buildListViewSeparated(AsyncSnapshot snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        String mood = snapshot.data[index].mood;
        String titleDate = DateFormat.yMMMd().format(DateTime.parse(snapshot.data[index].date));
        String titleDay = DateFormat.E().format(DateTime.parse(snapshot.data[index].date));
        String subtitle = snapshot.data[index].mood + "\n" + snapshot.data[index].note;
        return ListTile(
          leading: SizedBox(
            height: 48.0,
            width: 48.0,
            child: Center(
              child: snapshot.data.length > 0 ?
              Image(image: AssetImage("assets/images/${mood.toLowerCase()}.png",), color: Colors.orange,) :
              const SizedBox(),
            ),
          ),
          title: Text(
            '$titleDay - $titleDate',
            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: Colors.grey,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: journalsListData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return !snapshot.hasData
              ? const Center(child: CircularProgressIndicator(),)
              : buildListViewSeparated(snapshot);
          },
        )
      ),
    );
  }
}
