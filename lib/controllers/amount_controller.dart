import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';
import 'package:get/get.dart';
import 'package:money_manager/models/amount_model.dart';

class AmountController extends GetxController{
  late Box amountBox;
  late double current;
 static double TotalAddMoney=0;
  static double TotalExpense=0;
  Box AddMoneyBox=Hive.box("AddMoney");

  @override
  void onInit() {
    super.onInit();
    amountBox = Hive.box("CurrentM");
    current = amountBox.get("CurrentMoney", defaultValue: 0.0);
    TotalAddMoney=amountBox.get("TotalAdd",defaultValue: 0.0);
    TotalExpense=amountBox.get("TotalExpense",defaultValue: 0.0);
  }
  void Addmoney(double currentmon ){
    TotalAddMoney+=currentmon;
    current+=currentmon;
    amountBox.put("CurrentMoney", current);
    amountBox.put("TotalAdd", TotalAddMoney);

    update();
  }
  void spendMoney(double amount) {
    TotalExpense+=amount;
    current -= amount;
    amountBox.put("CurrentMoney", current);
    amountBox.put("TotalExpense", TotalExpense);
    update();
  }
  void historyAddMoney(AmountModel ModelAmount){
    AddMoneyBox.add(ModelAmount);
    update();
  }

  List<FlSpot> getFlSpotsFromHive() {
    List<AmountModel> data = AddMoneyBox.values.toList().cast<AmountModel>();

    Map<DateTime, double> dailyTotals = {};

    for (var entry in data) {
      DateTime date = DateTime(entry.dateTimeAdd.year, entry.dateTimeAdd.month, entry.dateTimeAdd.day);
      if (dailyTotals.containsKey(date)) {
        dailyTotals[date] = dailyTotals[date]! + entry.amountToAdd;
      } else {
        dailyTotals[date] = entry.amountToAdd;
      }
    }


    List<FlSpot> spots = dailyTotals.entries.map((e) {
      double x = e.key.day.toDouble();
      double y = e.value;
      return FlSpot(x, y);
    }).toList();


    return spots;
  }
  }

