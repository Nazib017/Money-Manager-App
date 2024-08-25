import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:money_manager/models/expanse_model.dart';

class ExController extends GetxController{

  Box ExpenseBox=Hive.box("Expense");
  void createHistory(ExModel history){

    ExpenseBox.add(history);
    update();
  }

  List<FlSpot> getExpenseFlSpotsFromHive() {
    List<ExModel> Expensedata = ExpenseBox.values.toList().cast<ExModel>();

    Map<DateTime, double> dailyExpense = {};

    for (var entry in Expensedata) {
      DateTime date = DateTime(entry.dateTime.year, entry.dateTime.month, entry.dateTime.day);
      if (dailyExpense.containsKey(date)) {
        dailyExpense[date] = dailyExpense[date]! + entry.amount;
      } else {
        dailyExpense[date] = entry.amount;
      }
    }


    List<FlSpot> Exspots = dailyExpense.entries.map((e) {
      double x = e.key.day.toDouble();
      double y = e.value;
      return FlSpot(x, y);
    }).toList();


    return Exspots;
  }

}