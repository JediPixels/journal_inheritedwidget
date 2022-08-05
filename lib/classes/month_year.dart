import 'package:intl/intl.dart';

class MonthYear {
  final String title;
  final int year;
  final int month;

  MonthYear({this.title = 'January', this.year = 2022, this.month = 01});

  List<MonthYear> listMonthYear = <MonthYear>[];

  List<MonthYear> buildMonthYear() {
    // DateTime Previous, Next Month calculations
    DateTime previousMonth(DateTime m) {
      var year = m.year;
      var month = m.month;
      if (month == 1) {
        year--;
        month = 12;
      } else {
        month--;
      }
      return DateTime(year, month);
    }

    DateTime nextMonth(DateTime m) {
      var year = m.year;
      var month = m.month;

      if (month == 12) {
        year++;
        month = 1;
      } else {
        month++;
      }
      return DateTime(year, month);
    }

    listMonthYear.clear();
    DateTime today = DateTime.now();
    String title = "";
    int year = 0;
    int month = 0;

    for (int i = 0; i <= 11; i++) {
      title = DateFormat.yMMM().format(today);
      year = today.year;
      month = today.month;
      listMonthYear.add(MonthYear(title: title, year: year, month: month));
      today = previousMonth(today);
    }

    return listMonthYear;
  }

}