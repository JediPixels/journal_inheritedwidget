import 'package:flutter/material.dart';
import '../classes/app_state.dart';
import '../classes/mood.dart';
import 'journal_list.dart';
import 'journal_stats.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List _listPages = [];
  late Widget _currentPage;
  Moods selectedMood = Moods('Happy');
  List<Moods> listMood = [];

  @override
  void initState() {
    super.initState();

    // Default Selected Mood for DropDownButton
    listMood = Moods('Happy').buildMood();
    selectedMood = listMood[0];

    _listPages
      ..add(const JournalList())
      ..add(const JournalStats());
    _currentPage = const JournalList();
  }

  void _changePage(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
      _currentPage = _listPages[selectedIndex];
    });
  }

  Color _selectedColor(int index) {
    if (index == 0) return Colors.lightGreen;
    if (index == 1) return Colors.orange;
    return Colors.lightGreen;
  }

  Widget _buildDropdownDateFilter() {
    return DropdownButton<Moods>(
      focusColor: Colors.transparent,
      style: const TextStyle(
          color: Colors.black54,
          fontSize: 32.0,
          fontWeight: FontWeight.w900,
      ),
      underline: const SizedBox(),
      value: selectedMood,
      onChanged: (mood) {
        setState(() {
          selectedMood = mood!;
        });
      },
      items: listMood.map((Moods mood) {
        return DropdownMenuItem<Moods>(
          value: mood,
          child: Text(
            mood.mood,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold,),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildDropdownDateFilter(),
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(32.0),
            child: Container()
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen, Colors.lightGreen.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: _selectedColor(_currentIndex),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_input_hdmi),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            label: 'Stats',
          ),
        ],
        onTap: _changePage,
      ),
      body: AppState(
          moods: selectedMood,
          child: _currentPage
      ),
    );
  }
}
