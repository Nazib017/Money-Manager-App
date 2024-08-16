// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expanse_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExModelAdapter extends TypeAdapter<ExModel> {
  @override
  final int typeId = 0;

  @override
  ExModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExModel(
      fields[0] as double,
      fields[1] as String,
      fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.expanse)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
