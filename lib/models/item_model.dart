import 'categories.dart';

class Item {
  final int productId;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final Categories category;
  final double price;
  final double stock;
  int quantity;

  Item({
    required this.productId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.category,
    required this.price,
    required this.stock,
    this.quantity = 0,
  });

  double get totalPrice => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'category': category.name,
      'price': price,
      'stock': stock,
      'quantity': quantity,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      productId: map['productId'],
      name: map['name'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      rating: map['rating'],
      category: Categories.values.firstWhere((e) => e.name == map['category']),
      price: map['price'],
      stock: map['stock'],
      quantity: map['quantity'] ?? 0,
    );
  }
}
