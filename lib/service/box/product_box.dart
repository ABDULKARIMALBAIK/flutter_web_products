import 'dart:typed_data';
import 'package:hive_flutter/hive_flutter.dart';
import '../../model/products_model.dart';

class ProductBox {
  ProductBox.constructor();

  late Box _boxProduct;

  init(Uint8List encryptionKey) async {
    _boxProduct = await Hive.openBox<Product>('Products',
        encryptionCipher: HiveAesCipher(encryptionKey));
  }

  clear() async {
    await _boxProduct.clear();
  }

  Product? getProduct(int key) {
    Product? currentProduct = _boxProduct.get(key);
    return currentProduct;
  }

  Future<void> updateProduct(Product product) async {
    await _boxProduct.put(product.key, product);
  }

  Future<void> deleteProduct(int key) async {
    await _boxProduct.delete(key);
  }

  Future<void> saveProduct(Product product) async {
    int newKey = await _boxProduct.add(product);
    product.keyProduct = newKey;
    await updateProduct(product);
  }

  Future<List<Product>> allProducts() async {
    final List<Product> data = _boxProduct.keys.map((key) {
      final Product product = _boxProduct.get(key);
      return product;
    }).toList();

    return data;
  }

  Future<int> countProducts() async {
    int count = _boxProduct.keys.length;
    return count;
  }
}
