import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

class CartState {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get totalQuantity => items.fold(0, (sum, i) => sum + i.quantity);
  int get totalPrice => 0; // Always ₹0 on Messhoo Free!
  int get originalTotalPrice => items.fold(0, (sum, i) => sum + (i.product.originalPrice * i.quantity));

  CartState copyWith({List<CartItem>? items}) {
    return CartState(items: items ?? this.items);
  }
}

class CartNotifier extends StateNotifier<CartState> {
  CartNotifier() : super(const CartState());

  void addToCart(Product product, String size) {
    final existingIndex = state.items.indexWhere(
        (i) => i.product.id == product.id && i.selectedSize == size);

    if (existingIndex >= 0) {
      final updated = List<CartItem>.from(state.items);
      updated[existingIndex].quantity += 1;
      state = state.copyWith(items: updated);
    } else {
      state = state.copyWith(
        items: [...state.items, CartItem(product: product, selectedSize: size)],
      );
    }
  }

  void updateQuantity(String productId, String size, int qty) {
    if (qty <= 0) {
      removeFromCart(productId, size);
      return;
    }
    final updated = state.items.map((i) {
      if (i.product.id == productId && i.selectedSize == size) {
        return CartItem(product: i.product, selectedSize: i.selectedSize, quantity: qty);
      }
      return i;
    }).toList();
    state = state.copyWith(items: updated);
  }

  void removeFromCart(String productId, String size) {
    state = state.copyWith(
      items: state.items.where((i) => !(i.product.id == productId && i.selectedSize == size)).toList(),
    );
  }

  void clearCart() {
    state = const CartState(items: []);
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, CartState>((ref) {
  return CartNotifier();
});

// Wishlist Provider
class WishlistNotifier extends StateNotifier<Set<String>> {
  WishlistNotifier() : super({});

  void toggleWishlist(String productId) {
    if (state.contains(productId)) {
      state = {...state}..remove(productId);
    } else {
      state = {...state, productId};
    }
  }

  bool isWishlisted(String productId) => state.contains(productId);
}

final wishlistProvider = StateNotifierProvider<WishlistNotifier, Set<String>>((ref) {
  return WishlistNotifier();
});

// Roast Tracking Provider
class RoastState {
  final int count;
  final bool isMuted;

  const RoastState({this.count = 0, this.isMuted = false});

  RoastState copyWith({int? count, bool? isMuted}) {
    return RoastState(
      count: count ?? this.count,
      isMuted: isMuted ?? this.isMuted,
    );
  }
}

class RoastNotifier extends StateNotifier<RoastState> {
  RoastNotifier() : super(const RoastState());

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void toggleMute() {
    state = state.copyWith(isMuted: !state.isMuted);
  }
}

final roastProvider = StateNotifierProvider<RoastNotifier, RoastState>((ref) {
  return RoastNotifier();
});
