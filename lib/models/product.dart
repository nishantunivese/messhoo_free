class Product {
  final String id;
  final String name;
  final String category;
  final int originalPrice;
  final int price;
  final int discountPercentage;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final String description;
  final bool isTrending;
  final bool isBestSeller;
  final List<String> availableSizes;
  final String deliveryTime;
  final String returnPolicy;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.originalPrice,
    required this.price,
    this.discountPercentage = 100,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.description,
    this.isTrending = false,
    this.isBestSeller = false,
    this.availableSizes = const ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
    this.deliveryTime = 'FREE Delivery by Tomorrow, 11 AM',
    this.returnPolicy = '7 Days Easy Returns (Supriya Special)',
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      originalPrice: (json['original_price'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      discountPercentage: (json['discount_percentage'] as num?)?.toInt() ?? 100,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: (json['reviews_count'] as num).toInt(),
      imageUrl: json['image_url'] as String,
      description: json['description'] as String,
      isTrending: json['is_trending'] as bool? ?? false,
      isBestSeller: json['is_best_seller'] as bool? ?? false,
      availableSizes: (json['available_sizes'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
      deliveryTime: json['delivery_time'] as String? ?? 'FREE Delivery Tomorrow',
      returnPolicy: json['return_policy'] as String? ?? '7 Days Easy Return',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'original_price': originalPrice,
      'price': price,
      'discount_percentage': discountPercentage,
      'rating': rating,
      'reviews_count': reviewsCount,
      'image_url': imageUrl,
      'description': description,
      'is_trending': isTrending,
      'is_best_seller': isBestSeller,
      'available_sizes': availableSizes,
      'delivery_time': deliveryTime,
      'return_policy': returnPolicy,
    };
  }
}

class CartItem {
  final Product product;
  final String selectedSize;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedSize,
    this.quantity = 1,
  });
}
