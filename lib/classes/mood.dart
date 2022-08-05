class Moods {
  final String mood;

  Moods(this.mood);

  List<Moods> listMood = <Moods>[];

  List<Moods> buildMood() {
    listMood.clear();
    listMood
      ..add(Moods('ALL'))
      ..add(Moods('Happy'))
      ..add(Moods('Smile'))
      ..add(Moods('Neutral'))
      ..add(Moods('Bored'))
      ..add(Moods('Sad'));
    return listMood;
  }
}