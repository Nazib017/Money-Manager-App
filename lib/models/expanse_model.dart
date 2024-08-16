import 'dart:ffi';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'expanse_model.g.dart';

@HiveType(typeId: 0)
class ExModel{
  @HiveField(0)
  double amount;
  @HiveField(1)
  String expanse;
  @HiveField(2)
  DateTime dateTime;
  ExModel(this.amount,this.expanse,this.dateTime);

}