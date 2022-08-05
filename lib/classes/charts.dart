import 'package:flutter/material.dart';

class MoodVerticalBarWidget extends StatelessWidget {

  final String moodIcon;
  final int numberOfMoods;
  final int totalNumberOfJournals;

  const MoodVerticalBarWidget({Key? key, required this.moodIcon, required this.numberOfMoods, required this.totalNumberOfJournals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = 300;
    double barHeight = numberOfMoods.toDouble();
    barHeight = (sizedBoxHeight * (barHeight / totalNumberOfJournals)) * 0.70;

    return SizedBox(
      height: sizedBoxHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BuildMoodIcon(moodIcon: moodIcon, height: 48.0, width: 48.0,),
          const Padding(padding: EdgeInsets.only(top: 8.0)),
          SizedBox(
            width: 48.0,
            height: barHeight,
            child: LinearProgressIndicator(
              value: 1.0,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 8.0),),
          Text('$numberOfMoods'),
        ],
      ),
    );
  }
}

class BuildMoodIcon extends StatelessWidget {

  final String moodIcon;
  final double height;
  final double width;
  const BuildMoodIcon({Key? key, required this.moodIcon, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.orange,
      elevation: 8.0,
      shape: const CircleBorder(side: BorderSide(color: Colors.orange)),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.orange,
          ),
        ),
        child: Center(
          child: moodIcon.isNotEmpty ?
            Image(image: AssetImage("assets/images/$moodIcon.png"), color: Colors.orange, height: height, width: width,) :
            SizedBox(height: height, width: width,),
        ),
      ),
    );
  }
}