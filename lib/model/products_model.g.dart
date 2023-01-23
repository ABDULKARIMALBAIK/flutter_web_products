// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 2;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      price: fields[3] as int,
      discountPercentage: fields[4] as double,
      rating: fields[5] as double,
      stock: fields[6] as int,
      brand: fields[7] as String,
      category: fields[8] as String,
      thumbnail: fields[9] as String,
      images: (fields[10] as List).cast<String>(),
      quantity: fields[11] as int,
      keyProduct: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.discountPercentage)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.stock)
      ..writeByte(7)
      ..write(obj.brand)
      ..writeByte(8)
      ..write(obj.category)
      ..writeByte(9)
      ..write(obj.thumbnail)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.quantity)
      ..writeByte(12)
      ..write(obj.keyProduct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
