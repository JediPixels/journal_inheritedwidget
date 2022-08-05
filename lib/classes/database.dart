import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:journal_inheritedwidget/classes/app_state.dart';

// Local Storage JSON Database file and Journal Class
// To read and parse from JSON data - databaseFromJson(jsonString);
// To save and parse to JSON Data - databaseToJson(jsonString);

Database databaseFromJson(String str) {
  final dataFromJson = json.decode(str);
  return Database.fromJson(dataFromJson);
}

String databaseToJson(Database data) {
  final dataToJson = data.toJson();
  return json.encode(dataToJson);
}

class GetData {
  static Future<String> readJson() async {
    final String response = await rootBundle.loadString('assets/json/journals.json');
    return response;
  }

  static Future<int> getTotalJournalsCount() async {
    String journalsJson = await readJson();
    Database database = databaseFromJson(journalsJson);
    return database.journal.length;
  }

  static Future<List<Journal>> loadJournals(AppState appState) async {
    String journalsJson = await readJson();
    Database database = databaseFromJson(journalsJson);
    if (appState.moods.mood != 'ALL') {
      database.journal = database.journal.where((element) => (element.mood) ==
          (appState.moods.mood)).toList();
    }
    database.journal.sort((comp1, comp2) => comp2.date.compareTo(comp1.date));
    return database.journal;
  }
}

class Database {
  List<Journal> journal;

  Database({
    required this.journal,
  });

  Future<String> readJson() async {
    final String response = await rootBundle.loadString('journals.json');
    return response;
  }

  factory Database.fromJson(Map<String, dynamic> json) => Database(
    journal: List<Journal>.from(json["journals"].map((x) => Journal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "journals": List<dynamic>.from(journal.map((x) => x.toJson())),
  };
}

class Journal {
  String id;
  String date;
  String mood;
  String note;

  Journal({
    required this.id,
    required this.date,
    required this.mood,
    required this.note,
  });

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
    id: json["id"],
    date: json["date"],
    mood: json["mood"],
    note: json["note"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "mood": mood,
    "note": note,
  };
}