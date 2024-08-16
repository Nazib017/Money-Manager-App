// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amount_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AmountModelAdapter extends TypeAdapter<AmountModel> {
  @override
  final int typeId = 1;

  @override
  AmountModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AmountModel(
      fields[0] as double,
      fields[1] as String,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AmountModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amountToAdd)
      ..writeByte(1)
      ..write(obj.DescriptionToAdd)
      ..writeByte(2)
      ..write(obj.dateTimeAdd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AmountModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
