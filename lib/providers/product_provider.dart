import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductState {
  final List<Product> allProducts;
  final String selectedCategory;
  final String searchQuery;
  final bool isLoading;

  const ProductState({
    this.allProducts = const [],
    this.selectedCategory = 'All',
    this.searchQuery = '',
    this.isLoading = false,
  });

  List<Product> get filteredProducts {
    var list = allProducts;
    if (selectedCategory != 'All') {
      list = list.where((p) => p.category.toLowerCase() == selectedCategory.toLowerCase()).toList();
    }
    if (searchQuery.trim().isNotEmpty) {
      final q = searchQuery.toLowerCase().trim();
      list = list.where((p) =>
          p.name.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.description.toLowerCase().contains(q)).toList();
    }
    return list;
  }

  ProductState copyWith({
    List<Product>? allProducts,
    String? selectedCategory,
    String? searchQuery,
    bool? isLoading,
  }) {
    return ProductState(
      allProducts: allProducts ?? this.allProducts,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  ProductNotifier() : super(const ProductState()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = state.copyWith(isLoading: true);
    final list = await ProductService.instance.getAllProducts();
    state = state.copyWith(allProducts: list, isLoading: false);
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }
}

final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  return ProductNotifier();
});
