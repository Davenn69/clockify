// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivityHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivityHiveAdapter extends TypeAdapter<ActivityHive> {
  @override
  final int typeId = 0;

  @override
  ActivityHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivityHive(
      uuid: fields[0] as String,
      description: fields[1] as String,
      start_time: fields[2] as DateTime,
      end_time: fields[3] as DateTime,
      location_lat: fields[4] as double,
      location_lng: fields[5] as double,
      created_at: fields[6] as DateTime,
      updated_at: fields[7] as DateTime,
      useruuid: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ActivityHive obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.uuid)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.start_time)
      ..writeByte(3)
      ..write(obj.end_time)
      ..writeByte(4)
      ..write(obj.location_lat)
      ..writeByte(5)
      ..write(obj.location_lng)
      ..writeByte(6)
      ..write(obj.created_at)
      ..writeByte(7)
      ..write(obj.updated_at)
      ..writeByte(8)
      ..write(obj.useruuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
