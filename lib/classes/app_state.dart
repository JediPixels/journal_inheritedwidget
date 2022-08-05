import 'package:flutter/material.dart';
import 'mood.dart';

class AppState extends InheritedWidget {
  final Moods moods;

  const AppState({
    Key? key,
    required this.moods,
    required Widget child,
  })  : super(key: key, child: child);

  static AppState? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppState>();
  }

  @override
  bool updateShouldNotify(AppState oldWidget) {
    return moods != oldWidget.moods;
  }
}