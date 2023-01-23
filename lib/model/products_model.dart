import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'products_model.g.dart';

// ignore: must_be_immutable
class ProductsModel extends Equatable {
  ProductsModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  List<Product> products;
  int total;
  String skip;
  int limit;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [products, total, limit, skip];
}

@HiveType(typeId: 2)
// ignore: must_be_immutable
class Product extends HiveObject implements Equatable {
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
    this.quantity = 1,
    this.keyProduct = 0,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  int price;
  @HiveField(4)
  double discountPercentage;
  @HiveField(5)
  double rating;
  @HiveField(6)
  int stock;
  @HiveField(7)
  String brand;
  @HiveField(8)
  String category;
  @HiveField(9)
  String thumbnail;
  @HiveField(10)
  List<String> images;

  @HiveField(11)
  int quantity;
  @HiveField(12)
  int keyProduct;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discountPercentage: json["discountPercentage"].toDouble(),
        rating: json["rating"].toDouble(),
        stock: json["stock"],
        brand: json["brand"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images": List<dynamic>.from(images.map((x) => x)),
        "quantity": quantity,
        "key": key
      };

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPercentage,
        rating,
        stock,
        brand,
        category,
        thumbnail,
        images,
        quantity,
        key
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}
