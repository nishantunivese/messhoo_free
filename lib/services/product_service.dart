import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class ProductService {
  static final ProductService instance = ProductService._internal();
  ProductService._internal();

  List<Product>? _cachedProducts;

  Future<List<Product>> getAllProducts() async {
    if (_cachedProducts != null && _cachedProducts!.isNotEmpty) {
      return _cachedProducts!;
    }

    try {
      final jsonString = await rootBundle.loadString('assets/data/products.json');
      final List<dynamic> list = json.decode(jsonString);
      _cachedProducts = list.map((item) => Product.fromJson(item)).toList();
      return _cachedProducts!;
    } catch (e) {
      return [];
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final all = await getAllProducts();
    if (category.toLowerCase() == 'all') return all;
    return all.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }

  Future<List<Product>> searchProducts(String query) async {
    final all = await getAllProducts();
    if (query.trim().isEmpty) return all;
    final q = query.toLowerCase().trim();
    return all.where((p) =>
        p.name.toLowerCase().contains(q) ||
        p.category.toLowerCase().contains(q) ||
        p.description.toLowerCase().contains(q)).toList();
  }
}
