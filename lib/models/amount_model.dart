import 'dart:ffi';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'amount_model.g.dart';

@HiveType(typeId: 1)
class AmountModel{
  @HiveField(0)
  double amountToAdd;
  @HiveField(1)
  String DescriptionToAdd;
  @HiveField(2)
  DateTime dateTimeAdd;
  AmountModel(this.amountToAdd,this.DescriptionToAdd,this.dateTimeAdd);

}